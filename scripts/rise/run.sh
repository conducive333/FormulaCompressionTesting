#!/bin/bash

# $1 = name of container

cd $(dirname "$0")
cd ../../
docker run \
	--rm \
	--net dataspread \
	--name $1 \
	--user $uid:$uid \
	--mount type=bind,src="$(pwd)"/testing,dst=/home/cdeleon/FormulaCompressionTesting/testing \
	--mount type=bind,src="$(pwd)"/sheets,dst=/home/cdeleon/FormulaCompressionTesting/testing/sheets \
	--mount type=bind,src="$(pwd)"/testing/dataspread-web.jar,dst=/home/cdeleon/FormulaCompressionTesting/testing/dataspread-web.jar \
	-it fcomp-rise
