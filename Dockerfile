FROM golang:1.12 as build
WORKDIR /go/src/rtlamr-collect
COPY . .
RUN go install -v ./...

FROM bemasher/rtlamr@sha256:373f6034abdafbdbb8aa2420d3fa8802de77db94b34bd6e28178feba170fa940
ENV RTLAMR_FORMAT=json
COPY --from=build /go/bin/rtlamr-collect /
CMD ["/bin/sh", "-c", "rtlamr | /rtlamr-collect"]
