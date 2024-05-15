#!/bin/sh

export CGO_ENABLED=0
export GOFLAGS=-buildvcs=false
export BUILD_PATH=./$2
CONFIG_PATH=$1
DIST_NAME=$(cat $CONFIG_PATH | yq '.dist.name')

#Override the output_path of the configuration to the provided build_path
yq -i ".dist.output_path = \"${BUILD_PATH}\"" ${CONFIG_PATH} 

mkdir -p ${BUILD_PATH}
chmod 777 ${BUILD_PATH}
echo "Building using config: ${CONFIG_PATH}"
builder --config ${CONFIG_PATH}
chmod 755 ${BUILD_PATH}

echo "collector-file='${BUILD_PATH}/${DIST_NAME}'" >> $GITHUB_OUTPUT
