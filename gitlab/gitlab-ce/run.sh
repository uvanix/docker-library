#!/bin/sh

echo "mkdir -p conf logs data"
mkdir -p conf logs data

echo "docker-compose up -d"
docker-compose up -d
