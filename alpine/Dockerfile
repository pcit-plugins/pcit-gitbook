FROM node:9-alpine

ENV TZ=Asia/Shanghai

LABEL maintainer="khs1994@khs1994.com" \
      version="latest"

WORKDIR /srv/gitbook

COPY book.json book.json

COPY docker-entrypoint.sh /usr/local/bin/

RUN apk add --no-cache \
          tzdata \
          git \
      && npm install -g gitbook-cli \
      && gitbook install \
      && ln -s /usr/local/bin/docker-entrypoint.sh / \
      && rm -rf /root/.npm /tmp/*

EXPOSE 4000

VOLUME /srv/gitbook-src

WORKDIR /srv/gitbook-src

ENTRYPOINT ["docker-entrypoint.sh"]

CMD build
