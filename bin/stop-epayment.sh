#!/bin/sh
RUN_DIR=`pwd`
cd ../appserver/epayment
docker-compose down
docker system prune -f
cd $RUN_DIR
