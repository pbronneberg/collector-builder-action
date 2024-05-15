FROM golang:1.22.3-alpine3.19 as build

ARG TARGETARCH
ARG BUILDER_VERSION=v0.100.0

RUN apk add git curl && rm -rf /var/cache/apk/*

RUN mkdir -p /opt/app-data
RUN go install go.opentelemetry.io/collector/cmd/builder@${BUILDER_VERSION}

WORKDIR /opt/app-data

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
