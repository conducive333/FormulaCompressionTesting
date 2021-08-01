#!/bin/bash

cd $(dirname "$0")
cd ../../
uid=$(id -u $(whoami))
find ./testing -name '*.sh' | xargs sed -i 's/\\r$//' && \
docker build -t fcomp -f ./docker/RISE.local.Dockerfile . && \
docker run \
	--rm \
	--net dataspread \
	--name fcomp-container \
	--user $uid:$uid \
	--mount type=bind,src="$(pwd)"/.m2,dst=/home/cdeleon/.m2 \
	--mount type=bind,src="$(pwd)"/testing,dst=/home/cdeleon/FormulaCompressionTesting/testing \
	--mount type=bind,src="$(pwd)"/dataspread-web,dst=/home/cdeleon/FormulaCompressionTesting/dataspread-web \
	-it fcomp