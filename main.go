package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"os"
	"time"

	"github.com/cavaliercoder/grab"
	"github.com/gorilla/mux"
	flag "github.com/spf13/pflag"
	"github.com/spf13/viper"
)

func init() {
	flag.Bool("RestoreAssets", false, "Do you want to unpack static files to modify")
	flag.Parse()
	viper.BindPFlags(flag.CommandLine)
	viper.RegisterAlias("RestoreAssets", "Unpack")
	viper.SetConfigName("config")        // name of config file (without extension)
	viper.AddConfigPath("/etc/godown/")  // path to look for the config file in
	viper.AddConfigPath("$HOME/.godown") // call multiple times to add many search paths
	viper.AddConfigPath(".")             // optionally look for config in the working directory
	err := viper.ReadInConfig()          // Find and read the config file
	if err != nil {                      // Handle errors reading the config file
		panic(fmt.Errorf("fatal error config file: %s", err))
	}
}

func main() {

	if viper.GetBool("RestoreAssets") {
		RestoreAssets("./", "static")
		fmt.Println("Static folder unpacked")
	}

	fmt.Println("Starting Server")

	m := mux.NewRouter()

	m.HandleFunc("/download", downloadHandler)

	if viper.GetBool("LocalStaticFiles") {
		m.PathPrefix("/").Handler(http.FileServer(http.Dir("static")))
	} else {
		m.PathPrefix("/").Handler(http.FileServer(assetFS()))
	}

	fmt.Println("Server running on port 8080")

	http.ListenAndServe(":8080", m)
}

func downloadHandler(w http.ResponseWriter, r *http.Request) {

	fmt.Println("Request Recieved")

	body, _ := ioutil.ReadAll(r.Body)

	downloadURL := string(body)

	_, err := url.ParseRequestURI(downloadURL)

	if err == nil {

		filePath := viper.GetString("DownloadFolder")

		client := grab.NewClient()
		req, _ := grab.NewRequest(filePath, downloadURL)

		// sum, err := hex.DecodeString("12767bda45b430d66e538a8780587260427935f7513479371dc2a884723ae410")
		// if err != nil {
		// 	panic(err)
		// }
		//
		// req.SetChecksum(sha256.New(), sum, true)

		fmt.Printf("Downloading %v...\n", req.URL())
		resp := client.Do(req)
		fmt.Printf("  %v\n", resp.HTTPResponse.Status)

		// start UI loop
		t := time.NewTicker(500 * time.Millisecond)
		defer t.Stop()

	Loop:
		for {
			select {
			case <-t.C:
				fmt.Printf("  transferred %v / %v bytes (%.2f%%)\n",
					resp.BytesComplete(),
					resp.Size,
					100*resp.Progress())

			case <-resp.Done:
				// download is complete
				break Loop
			}
		}

		// check for errors
		if err := resp.Err(); err != nil {
			fmt.Fprintf(os.Stderr, "Download failed: %v\n", err)
			//os.Exit(1)
		}

		fmt.Printf("Download saved to %v \n", resp.Filename)
	}
}
