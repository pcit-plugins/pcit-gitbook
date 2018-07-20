FROM node:9-alpine@sha256:5aa0756284c7f0222c2c16988fb58d6446427ac7ae8891aa50a2de721ef4191c

LABEL maintainer="khs1994@khs1994.com" \
      version="latest"

ENV TZ=Asia/Shanghai

ENV GIT_USERNAME \
    GIT_USEREMAIL

WORKDIR /srv/gitbook

COPY book.json book.json

RUN apk add --no-cache \
          tzdata \
          git \
          openssl \
          openssh-client \
      && mkdir -p ~/.ssh \
      && echo -e "StrictHostKeyChecking no\nUserKnownHostsFile /dev/null" > ~/.ssh/config \
      && npm install -g gitbook-cli \
      && gitbook install \
      && ln -s /usr/local/bin/docker-entrypoint.sh / \
      && rm -rf /root/.npm /tmp/*

EXPOSE 4000

VOLUME /srv/gitbook-src

WORKDIR /srv/gitbook-src

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD build
