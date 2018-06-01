FROM redis:alpine

LABEL "maintainer"="uvans5233@gmail.com"

WORKDIR /root

RUN apk update \
    && apk --update add ruby ruby-rdoc ruby-irb \
    && /usr/bin/gem install redis

EXPOSE 7000 7001 7002 7003 7004 7005

CMD ["/bin/sh", "/etc/redis-cluster/start.sh"]
