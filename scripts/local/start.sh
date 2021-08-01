#!/bin/bash

cd $(dirname "$0")
cd ../../
find ./testing -name '*.sh' | xargs sed -i 's/\\r$//' && \
docker build -t fcomp -f ./docker/local.Dockerfile . && \
docker run \
	--rm \
	--net dataspread \
	--name fcomp-container \
	--mount type=bind,src="$(pwd)"/.m2,dst=/home/cdeleon/.m2,bind-propagation=shared \
	--mount type=bind,src="$(pwd)"/dataspread-web,dst=/home/cdeleon/FormulaCompressionTesting/dataspread-web,bind-propagation=shared \
	-it fcomp

