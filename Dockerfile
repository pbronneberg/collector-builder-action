FROM golang:1.22.3-alpine3.19 as build

ARG TARGETARCH
ARG BUILDER_VERSION=v0.100.0

RUN apk add git curl ca-certificates && rm -rf /var/cache/apk/*
RUN curl https://www.cisco.com/security/pki/certs/ciscoumbrellaroot.pem -o /usr/local/share/ca-certificates/Cisco_Umbrella_Root_CA.crt && \
    update-ca-certificates

RUN mkdir -p /opt/app-root
RUN go install go.opentelemetry.io/collector/cmd/builder@${BUILDER_VERSION}

WORKDIR /opt/app-root

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh .

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["entrypoint.sh"]
