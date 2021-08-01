#!/bin/bash

cd $(dirname "$0")
cd ../../
find ./testing -name '*.sh' | xargs sed -i 's/\\r$//' && \
docker build -t fcomp -f ./docker/RISE.local.Dockerfile . && \
docker run \
	--rm \
	--net dataspread \
	--name fcomp-container \
	--mount type=bind,src="$(pwd)"/.m2,dst=/.m2,bind-propagation=shared \
	--mount type=bind,src="$(pwd)"/dataspread-web,dst=/FormulaCompressionTesting/dataspread-web,bind-propagation=shared \
	-it fcomp