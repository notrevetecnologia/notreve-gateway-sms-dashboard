# Notreve Gateway SMS — Painel
FROM node:22-alpine AS web

WORKDIR /src/web
COPY web/package.json web/package-lock.json ./
RUN npm ci
COPY web/ ./
RUN npm run build

FROM golang:1.26-alpine AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
COPY --from=web /src/internal/web/static /src/internal/web/static
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags "-s -w" -o /out/app .

FROM alpine:3.21

RUN adduser -D -u 10001 app
WORKDIR /app
COPY --from=build /out/app /app/app

USER app
EXPOSE 3000
ENTRYPOINT ["/app/app"]
