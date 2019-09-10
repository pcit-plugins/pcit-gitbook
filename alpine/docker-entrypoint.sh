#!/bin/sh

set -x

START=`date "+%F %T"`

if [ $1 = "sh" ];then sh ; exit 0 ; fi
if [ $1 = "version" ];then exec gitbook --version ; fi

git config --global user.name ${GIT_USERNAME:-CI}
git config --global user.email ${GIT_USEREMAIL:-ci@khs1994.com}

rm -rf node_modules

WORKDIR=$PWD

cp -a . /srv/gitbook

cd /srv/gitbook

print_info(){
  set +x
  echo ""
  echo "==> $@"
  echo ""
  set -x
}

main(){
  gitbook build || (print_info "Build error, retry" ; gitbook install && gitbook build )

  cp -a _book $WORKDIR

  case $1 in
    server )
      exec gitbook serve
      ;;
    deploy )
      set +x

      if [ -z "$GIT_REPO" ];then
      # check github actions
      test -n "$GITHUB_ACTION" && \
      print_info "RUN on GitHub Actions" && set +x && \
      GIT_REPO="https://${GIT_USERNAME}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}"
      fi

      if [ -z "$GIT_REPO" ];then
        print_info "miss \$GIT_REPO"
        exit 1
      fi

      test -n "$GIT_TOKEN" && \
      print_info "Auth by token" && set +x && \
      GIT_REPO="https://${GIT_USERNAME}:${GIT_TOKEN}@${GIT_REPO}"

      set -x
      cd _book || exit 1

      if [ -d .git ];then
        git remote set-url origin ${GIT_REPO}
      else
        rm -rf .git
        git init
        git remote add origin ${GIT_REPO}
      fi

      git add .
      COMMIT_DATE=`date "+%F %T"`
      git commit -m "${GIT_COMMIT_MESSAGE:-Gitbook updated:} ${COMMIT_DATE}" -s
      git push -f origin master:${GIT_BRANCH:-gh-pages}
      ;;
    esac
    print_info $START
    print_info $(date "+%F %T")
}

main $@
