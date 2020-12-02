#!/bin/sh
RUN_DIR=`pwd`
cd ../system/etracs-web
docker-compose down
docker system prune -f
docker-compose up -d
docker-compose logs -f
cd $RUN_DIR
