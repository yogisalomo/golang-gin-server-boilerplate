FROM golang:1.18

RUN mkdir /app
WORKDIR /app

# Download the dependencies
ADD go.mod .
ADD go.sum .
RUN go mod download

# Add the source code to the container
ADD . .

# Install compile daemon for live reloading of code for more convenient development
RUN go get github.com/githubnemo/CompileDaemon
RUN go install github.com/githubnemo/CompileDaemon

EXPOSE 8000

ENTRYPOINT "$GOPATH/bin/CompileDaemon" -exclude-dir=bin -exclude-dir=.git -exclude-dir=docs --directory="/app" --build="make build-dev" --command=./bin/app