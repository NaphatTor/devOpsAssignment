FROM golang:1.21.4-alpine AS build
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o myapp .

FROM alpine:3.20
WORKDIR /app
COPY --from=build /app/myapp .
EXPOSE 8080
CMD ["./myapp"]