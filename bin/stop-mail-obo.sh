#!/bin/sh
RUN_DIR=`pwd`
cd ../email/mail-obo
docker-compose down
docker system prune -f
cd $RUN_DIR
