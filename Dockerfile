# Use a multi-stage build to compile the Go application
FROM golang:1.17 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go modules and build files
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go application for the target architecture
RUN GOARCH=amd64 GOOS=linux go build -o app .

# Use a minimal base image for the final container
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /root/

# Copy the built binary from the builder stage to the final image
COPY --from=builder /app/app .

# Expose the port the application listens on
EXPOSE 8080

# Command to run the executable
CMD ["./app"]
