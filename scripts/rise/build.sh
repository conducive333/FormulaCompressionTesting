#!/bin/bash

cd $(dirname "$0")
cd ../../
docker build -t fcomp-rise -f ./docker/RISE.Dockerfile .