#!/bin/sh
RUN_DIR=`pwd`
cd ../system/etracs-web
docker-compose down
docker system prune -f
cd $RUN_DIR
