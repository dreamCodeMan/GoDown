start=`date +%s`

cd gui

ng build --prod

cd ..

go-bindata-assetfs static/...




env GOOS=android   GOARCH=arm      go build -o build/GoDown-android-arm     -v github.com/Pwed/GoDown
env GOOS=darwin    GOARCH=386      go build -o build/GoDown-darwin-386      -v github.com/Pwed/GoDown
env GOOS=darwin    GOARCH=amd64    go build -o build/GoDown-darwin-amd64    -v github.com/Pwed/GoDown
env GOOS=darwin    GOARCH=arm      go build -o build/GoDown-darwin-arm      -v github.com/Pwed/GoDown
env GOOS=darwin    GOARCH=arm64    go build -o build/GoDown-darwin-arm64    -v github.com/Pwed/GoDown
env GOOS=dragonfly GOARCH=amd64    go build -o build/GoDown-dragonfly-amd64 -v github.com/Pwed/GoDown
env GOOS=freebsd   GOARCH=386      go build -o build/GoDown-freebsd-386     -v github.com/Pwed/GoDown
env GOOS=freebsd   GOARCH=amd64    go build -o build/GoDown-freebsd-amd64   -v github.com/Pwed/GoDown
env GOOS=freebsd   GOARCH=arm      go build -o build/GoDown-freebsd-arm     -v github.com/Pwed/GoDown
env GOOS=linux     GOARCH=386      go build -o build/GoDown-linux-386       -v github.com/Pwed/GoDown
env GOOS=linux     GOARCH=amd64    go build -o build/GoDown-linux-amd64     -v github.com/Pwed/GoDown
env GOOS=linux     GOARCH=arm      go build -o build/GoDown-linux-arm       -v github.com/Pwed/GoDown
env GOOS=linux     GOARCH=arm64    go build -o build/GoDown-linux-arm64     -v github.com/Pwed/GoDown
env GOOS=linux     GOARCH=ppc64    go build -o build/GoDown-linux-ppc64     -v github.com/Pwed/GoDown
env GOOS=linux     GOARCH=ppc64le  go build -o build/GoDown-linux-ppc64le   -v github.com/Pwed/GoDown
env GOOS=linux     GOARCH=mips     go build -o build/GoDown-linux-mips      -v github.com/Pwed/GoDown
env GOOS=linux     GOARCH=mipsle   go build -o build/GoDown-linux-mipsle    -v github.com/Pwed/GoDown
env GOOS=linux     GOARCH=mips64   go build -o build/GoDown-linux-mips64    -v github.com/Pwed/GoDown
env GOOS=linux     GOARCH=mips64le go build -o build/GoDown-linux-mips64le  -v github.com/Pwed/GoDown
env GOOS=netbsd    GOARCH=386      go build -o build/GoDown-netbsd-386      -v github.com/Pwed/GoDown
env GOOS=netbsd    GOARCH=arm      go build -o build/GoDown-netbsd-arm      -v github.com/Pwed/GoDown
env GOOS=netbsd    GOARCH=amd64    go build -o build/GoDown-netbsd-amd64    -v github.com/Pwed/GoDown
env GOOS=openbsd   GOARCH=386      go build -o build/GoDown-openbsd-386     -v github.com/Pwed/GoDown
env GOOS=openbsd   GOARCH=amd64    go build -o build/GoDown-openbsd-amd64   -v github.com/Pwed/GoDown
env GOOS=openbsd   GOARCH=arm      go build -o build/GoDown-openbsd-arm     -v github.com/Pwed/GoDown
env GOOS=plan9     GOARCH=386      go build -o build/GoDown-plan9-386       -v github.com/Pwed/GoDown
env GOOS=plan9     GOARCH=amd64    go build -o build/GoDown-plan9-amd64     -v github.com/Pwed/GoDown
env GOOS=solaris   GOARCH=amd64    go build -o build/GoDown-solaris-amd64   -v github.com/Pwed/GoDown
env GOOS=windows   GOARCH=386      go build -o build/GoDown-windows-386     -v github.com/Pwed/GoDown
env GOOS=windows   GOARCH=amd64    go build -o build/GoDown-windows-amd64   -v github.com/Pwed/GoDown


end=`date +%s`

runtime=$((end-start))
echo "Build finished after $runtime seconds."
