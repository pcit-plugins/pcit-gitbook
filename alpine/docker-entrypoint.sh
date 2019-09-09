#!/bin/sh

set -x

START=`date "+%F %T"`

if [ $1 = "sh" ];then sh ; exit 0 ; fi
if [ $1 = "version" ];then exec gitbook --version ; fi

git config --global user.name ${GIT_USERNAME:-none}

git config --global user.email ${GIT_USEREMAIL:-none@none.com}

rm -rf node_modules _book

cp -a . /srv/gitbook

cd /srv/gitbook

main(){
  gitbook build || ( gitbook install ; gitbook build )

  cp -a _book ../gitbook-src
  case $1 in
    server )
      exec gitbook serve
      exit 0
      ;;
    deploy )
      set +x

      echo ""
      echo "==> check github actions ..."
      echo ""

      test -n "$GITHUB_ACTION" && \
      GIT_REPO="https://${GIT_USERNAME}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
      set -x

      cd _book
      git init
      git remote add origin ${GIT_REPO}
      git add .
      COMMIT_DATE=`date "+%F %T"`
      git commit -m "${GIT_COMMIT_MESSAGE:-Gitbook updated:} ${COMMIT_DATE}"
      git push -f origin master:${GIT_BRANCH:-gh-pages}
      ;;
    esac
    echo $START
    date "+%F %T"
}

main $@
