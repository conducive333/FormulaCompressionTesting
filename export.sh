#!/bin/bash

cd $(dirname "$0") && \
docker cp fcomp-container:/home/cdeleon/FormulaCompressionTesting/testing/reports $(pwd)/reports