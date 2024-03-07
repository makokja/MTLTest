# Use the official Golang image 
FROM golang:latest AS builder

# Set the working directory 
WORKDIR /app

# Copy the Go modules and build files to the working directory
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the source code to the working directory
COPY . .

# Build the Go app
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

# Use the official apline for light weight container
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /root/

# Copy the binary from the builder stage to the new stage
COPY --from=builder /app/app .

# Expose 8080 to outside
EXPOSE 8080

# Command to run the executable on startup
CMD ["./app"]
