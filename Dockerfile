# Stage 1: build the Go binary
FROM golang:1.24-alpine AS builder

LABEL maintainer="student"
LABEL version="1.0"
LABEL description="ASCII Art Web Application"

WORKDIR /app

COPY go.mod .
RUN go mod download

COPY . .
RUN go build -o server .

# Stage 2: minimal runtime image
FROM alpine:3.19

WORKDIR /app

COPY --from=builder /app/server .
COPY --from=builder /app/templates ./templates
COPY --from=builder /app/banners ./banners

EXPOSE 8080

CMD ["./server"]
