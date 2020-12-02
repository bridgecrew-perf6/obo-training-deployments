#!/bin/sh
RUN_DIR=`pwd`
cd ../email/mail-primary
docker-compose down
docker system prune -f
cd $RUN_DIR
