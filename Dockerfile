FROM golang:1.14.4-alpine3.12 AS builder

# Add Maintainer Info
LABEL maintainer="Christian Giacomi"

RUN apk add --no-cache --update git

WORKDIR /app

# Copy go mod and sum files
COPY ./go.mod ./go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY ./ .

# Build the Go app for linux
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o server .


## END builder STAGE
##############################################


FROM alpine:3.12

# Add Maintainer Info
LABEL maintainer="Christian Giacomi"

RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/server .

EXPOSE 8000
CMD ["./server"]

## END slim image STAGE
##############################################
