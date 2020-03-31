#!/bin/bash

set -o nounset errexit pipefail

# Collect the API Proxy and Hosted Target (Sandbox server)
# files into build/apiproxy/ and deploy to Apigee

mkdir -p build
rm -rf build/apiproxy
cp -R apiproxy/ build/
sed -i "s/PROXY_BASE_PATH/$APIGEE_BASE_PATH/g" build/apiproxy/proxies/default.xml
mkdir -p build/apiproxy/resources/hosted
rsync -av --copy-links --exclude="node_modules" sandbox/ build/apiproxy/resources/hosted
node_modules/.bin/apigeetool deployproxy --environments "$APIGEE_ENVIRONMENTS" --api "$APIGEE_APIPROXY" --directory build/ --verbose
