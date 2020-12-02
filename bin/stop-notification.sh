#!/bin/sh
RUN_DIR=`pwd`
cd ../system/notification
docker-compose down
docker system prune -f
cd $RUN_DIR
