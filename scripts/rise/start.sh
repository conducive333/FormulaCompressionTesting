#!/bin/bash

cd $(dirname "$0")
cd ../../
find ./testing -name '*.sh' | xargs sed -i 's/\\r$//' && \
docker build -t fcomp -f ./docker/RISE.local.Dockerfile . && \
docker run --rm --net dataspread --name fcomp-container -it fcomp
