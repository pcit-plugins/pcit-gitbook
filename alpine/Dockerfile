FROM node:11-alpine

LABEL maintainer="khs1994@khs1994.com"
LABEL repository="https://github.com/khs1994-docker/gitbook"
LABEL homepage="https://ci.khs1994.com"

LABEL com.github.actions.name="pcit-gitbook"
LABEL com.github.actions.description="build or deplay your gitbook"
LABEL com.github.actions.icon="book-open"
LABEL com.github.actions.color="white"

ENV TZ=Asia/Shanghai

ENV GIT_USERNAME="" \
    GIT_USEREMAIL="" \
    GIT_REPO="" \
    GIT_BRANCH="gh-pages" \
    GIT_COMMIT_MESSAGE="Gitbook updated:"

WORKDIR /srv/gitbook

COPY book.json book.json

RUN set -x && apk add --no-cache \
          tzdata \
          git \
          openssl \
          openssh-client \
      && mkdir -p ~/.ssh \
      && echo -e "StrictHostKeyChecking no\nUserKnownHostsFile /dev/null" > ~/.ssh/config \
      && npm install -g gitbook-cli \
      && gitbook install \
      && rm -rf /root/.npm /tmp/* \
      && gitbook ls

EXPOSE 4000

VOLUME /srv/gitbook-src

WORKDIR /srv/gitbook-src

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD build
