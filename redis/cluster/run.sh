#!/bin/sh

echo "mkdir -p logs data and copy redis.conf"
mkdir -p data/7000 data/7001 data/7002 data/7003 data/7004 data/7005 logs
#cp -rf redis.conf conf/7000
#sed -i '' 's/6379/7000/g' redis.conf

echo "docker run --name redis-cluster ... -d redis-cluster"
docker run \
  --name redis-cluster \
  --privileged \
  --network=host \
  -e "IP=0.0.0.0" \
  -v $PWD/conf:/etc/redis-cluster \
  -v $PWD/data:/data \
  -v $PWD/logs:/var/log/redis \
  -d uvans/redis-cluster:1.0.0
