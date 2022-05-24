FROM alpine:3.16.0

RUN apk update && apk upgrade && \
    apk add util-linux && \
    rm -rf /var/cache/apk/*

LABEL org.opencontainers.image.source https://github.com/BitProcessor/nsenter

ENTRYPOINT ["/usr/bin/nsenter"]
