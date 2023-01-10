FROM alpine:3.17.1

RUN apk update && apk upgrade && \
    apk add util-linux && \
    rm -rf /var/cache/apk/*

LABEL org.opencontainers.image.source https://github.com/BitProcessor/nsenter

ENTRYPOINT ["/usr/bin/nsenter"]
