FROM golang:alpine AS builder

WORKDIR /app

COPY go.* ./
RUN go mod download

COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM scratch

WORKDIR /app

COPY --from=builder /app/main .

CMD ["./main"]