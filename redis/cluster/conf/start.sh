#!/bin/sh

redis-server /etc/redis-cluster/7000/redis.conf &
sleep 1
redis-server /etc/redis-cluster/7001/redis.conf &
sleep 1
redis-server /etc/redis-cluster/7002/redis.conf &
sleep 1
redis-server /etc/redis-cluster/7003/redis.conf &
sleep 1
redis-server /etc/redis-cluster/7004/redis.conf &
sleep 1
redis-server /etc/redis-cluster/7005/redis.conf &
sleep 1

CLIENT=`find / -name client.rb`
echo $CLIENT

STATUS=$(echo "CLUSTER INFO" | redis-cli  -p 7000 | grep "cluster_state:ok"| wc -l)
if [ $STATUS -eq 1 ];
then
    exit
fi

IP=`ifconfig | grep "inet addr:17" | cut -f2 -d ":" | cut -f1 -d " "`
IP=127.0.0.1
echo "yes" | ruby /etc/redis-cluster/redis-trib.rb create --replicas 1 ${IP}:7000 ${IP}:7001 ${IP}:7002 ${IP}:7003 ${IP}:7004 ${IP}:7005
