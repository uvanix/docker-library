#!/bin/sh

echo "mkdir -p conf logs data"
mkdir -p conf logs data

echo "docker run --detach --hostname 104.171.174.26 --publish 8080:80 --publish 2222:22 --name gitlab --restart ... gitlab/gitlab-ce:latest"
docker run --detach \
    --hostname 104.171.174.26 \
    --publish 8080:80 \
    --publish 2222:22 \
    --name gitlab \
    --restart always \
    --volume /Users/uvans/software/docker-library/gitlab/gitlab-ce/conf:/etc/gitlab \
    --volume /Users/uvans/software/docker-library/gitlab/gitlab-ce/logs:/var/log/gitlab \
    --volume /Users/uvans/software/docker-library/gitlab/gitlab-ce/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest
