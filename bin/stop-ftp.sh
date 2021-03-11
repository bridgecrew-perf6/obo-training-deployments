#!/bin/sh
RUN_DIR=`pwd`
cd ../system/ftp
docker-compose down
docker system prune -f
cd $RUN_DIR
