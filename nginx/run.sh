#!/bin/sh

echo "mkdir -p conf html logs"
mkdir -p conf html logs

echo "docker run --name tmp-nginx -d nginx:latest and copy nginxconf & html then rm -f tmp-nginx"
docker run --name tmp-nginx -d nginx:latest
docker cp tmp-nginx:/etc/nginx/nginx.conf conf/nginx.conf
docker cp tmp-nginx:/etc/nginx/conf.d conf
docker cp tmp-nginx:/usr/share/nginx/html ./
docker rm -f tmp-nginx

echo "docker run --name nginx ... -d nginx:latest"
docker run \
  --name nginx \
  -p 80:80 \
  -v $PWD/html:/usr/share/nginx/html:ro \
  -v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
  -v $PWD/conf/conf.d:/etc/nginx/conf.d \
  -v $PWD/logs:/var/log/nginx \
  -d nginx:latest
