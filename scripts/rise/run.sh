#!/bin/bash

# $1 = name of container
# $2 = cpus

cd $(dirname "$0")
cd ../../
docker run \
	--rm \
	--net dataspread \
	--name $1 \
	--cpus $2 \
	--user $uid:$uid \
	--mount type=bind,src="$(pwd)"/.m2,dst=/home/cdeleon/.m2 \
	--mount type=bind,src="$(pwd)"/testing,dst=/home/cdeleon/FormulaCompressionTesting/testing \
	--mount type=bind,src="$(pwd)"/dataspread-web,dst=/home/cdeleon/FormulaCompressionTesting/dataspread-web \
	-it fcomp-rise
