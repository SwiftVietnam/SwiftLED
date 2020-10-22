#!/bin/sh

docker run \
     --rm \
     --volume "$(pwd)/:/src" \
     --workdir "/src/" \
     swift-lambda-builder \
     swift build --product SwiftLED -c release