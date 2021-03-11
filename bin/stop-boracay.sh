#!/bin/sh
RUN_DIR=`pwd`
cd ../appserver/boracay
docker-compose down
docker system prune -f
cd $RUN_DIR
