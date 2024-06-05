FROM golang:1.22.4-alpine3.19 as build

ARG TARGETARCH
ARG BUILDER_VERSION=v0.100.0

RUN apk add git curl yq ca-certificates && rm -rf /var/cache/apk/*
RUN curl https://www.cisco.com/security/pki/certs/ciscoumbrellaroot.pem -o /usr/local/share/ca-certificates/Cisco_Umbrella_Root_CA.crt && \
    update-ca-certificates

RUN mkdir -p /opt/app-root
RUN go install go.opentelemetry.io/collector/cmd/builder@${BUILDER_VERSION}

WORKDIR /opt/app-root

# Copies your code file from your action repository to the workdir
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]