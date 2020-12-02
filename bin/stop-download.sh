#!/bin/sh
RUN_DIR=`pwd`
cd ../system/download
docker-compose down
docker system prune -f
cd $RUN_DIR
