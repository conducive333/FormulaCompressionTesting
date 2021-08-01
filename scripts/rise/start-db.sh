#!/bin/bash

cd $(dirname "$0")
cd ../../
uid=$(id -u $(whoami))
docker build -t dataspread-db -f ./docker/db.Dockerfile . && \
docker network create dataspread;
docker run -d \
	--rm \
	--net dataspread \
	--name fcomp-db \
	--user $uid:$uid \
	-p 5432:5432 \
	dataspread-db 
