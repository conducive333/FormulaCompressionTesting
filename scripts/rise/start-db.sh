#!/bin/bash

cd $(dirname "$0")
cd ../../
docker build -t dataspread-db -f ./docker/RISE.db.Dockerfile . && \
docker network create dataspread;
docker run --rm --net dataspread --name fcomp-db -dp 5432:5432 dataspread-db 
