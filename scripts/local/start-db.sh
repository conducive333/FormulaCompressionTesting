#!/bin/bash

cd $(dirname "$0")
cd ../../
docker build -t dataspread-db -f ./docker/db.Dockerfile . && \
docker network create dataspread;
docker run -d \
	--rm \
	--net dataspread \
	--name fcomp-db \
	-p 5432:5432 \
	dataspread-db 
