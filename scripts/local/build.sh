#!/bin/bash

cd $(dirname "$0")
cd ../../
docker build -t fcomp -f ./docker/local.Dockerfile .