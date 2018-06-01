#!/bin/sh

echo "mkdir -p conf logs data and copy my.cnf"
mkdir -p conf logs data
cp -rf my.cnf conf

echo "docker run --name mariadb ... -d mariadb:latest"
docker run \
  --name mariadb \
  -p 3306:3306 \
  -v $PWD/conf/my.cnf:/etc/mysql/mariadb.conf.d/mysqld.cnf \
  -v $PWD/logs:/var/log/mysql \
  -v $PWD/data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -d mariadb:latest
