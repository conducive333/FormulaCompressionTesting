#!/bin/bash

# To run this script on the RISE servers:
# 	bash main.sh RISE
#
# To run this script on a local dev environment:
#	bash main.sh

cd $(dirname "$0") && \
if [ "$1" == "RISE" ]; then
	bash ./scripts/rise/start-db.sh
	bash ./scripts/rise/start.sh
else
	bash ./scripts/local/start-db.sh
	bash ./scripts/local/start.sh
fi
