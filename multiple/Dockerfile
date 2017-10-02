# Version 1.0.0

FROM node:8-alpine

LABEL maintainer="khs1994@khs1994.com" \
      version="1.0.0"

RUN apk add --no-cache tzdata git \
      && npm install -g gitbook-cli

ENV TZ=Asia/Shanghai

WORKDIR /tmp/gitbook

COPY book.json /tmp/gitbook

RUN gitbook install

WORKDIR /tmp/gitbook-src

COPY docker-entrypoint.sh /usr/local/bin/

RUN ln -s usr/local/bin/docker-entrypoint.sh /

ENTRYPOINT ["docker-entrypoint.sh"]
