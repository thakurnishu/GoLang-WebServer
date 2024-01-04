FROM golang:alpine3.19 AS build

WORKDIR /app

COPY . /app

RUN go build -o WebServerApp .

FROM scratch

COPY --from=build /app/WebServerApp /app/WebServerApp
COPY --from=build /app/static /app/static

WORKDIR /app

EXPOSE 8000
CMD [ "./WebServerApp" ]