#!/bin/sh

export CGO_ENABLED=0
export GOFLAGS=-buildvcs=false
export BUILD_PATH=./$2
mkdir -p ${BUILD_PATH}
chmod 777 ${BUILD_PATH}
echo "Building using builder --config $1"
builder --config $1 --output-path ${BUILD_PATH}
chmod 755 ${BUILD_PATH}

CONFIG_PATH=$1
DIST_NAME=$(cat $CONFIG_PATH | yq '.dist.name')

echo "collector-file='${BUILD_PATH}/${DIST_NAME}'" >> $GITHUB_OUTPUT
