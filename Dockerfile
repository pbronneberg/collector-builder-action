FROM golang:1.24.4-alpine3.22 AS build

ARG TARGETARCH
ARG BUILDER_VERSION=v0.127.0

RUN mkdir -p /opt/app-root
RUN apk add --no-cache git yq
RUN go install go.opentelemetry.io/collector/cmd/builder@${BUILDER_VERSION}

WORKDIR /opt/app-root

# Copies your code file from your action repository to the workdir
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]