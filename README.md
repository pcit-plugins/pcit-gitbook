# GitBook Docker

[![GitHub stars](https://img.shields.io/github/stars/khs1994-docker/gitbook.svg?style=social&label=Stars)](https://github.com/khs1994-docker/gitbook) [![Docker Stars](https://img.shields.io/docker/stars/khs1994/gitbook.svg)](https://store.docker.com/community/images/khs1994/gitbook/) [![Docker Pulls](https://img.shields.io/docker/pulls/khs1994/gitbook.svg)](https://store.docker.com/community/images/khs1994/gitbook/)

# Supported tags and respective `Dockerfile` links

* [`latest` (*alpine/Dockerfile*)](https://github.com/khs1994-docker/gitbook/tree/master/alpine/Dockerfile)

# 目的

在 CI 环境中使用 GitBook 构建文档，大部分时间用在了安装 GitBook 环境上，将环境打包到 Docker，大大节约了时间。

# Overview

* [`Node.js`](https://github.com/docker-library/docs/tree/master/node) `GitBook` 均为最新版

* 本镜像主要完成 `GitBook` 及其插件的安装，具体请查看 `alpine/book.json` 文件

* 基于 `alpine/book.json` 可以构建自己的镜像

# Usage

进入 gitbook 源文件夹

## Build

```bash
$ docker run -it --rm \
    -v $PWD:/srv/gitbook-src \
    khs1994/gitbook
```

## Server

```bash
$ docker run -it --rm \
    -v $PWD:/srv/gitbook-src \
    -p 4000:4000 \
    khs1994/gitbook \
    server
```

## Deploy

```bash
$ docker run -it --rm \
    -v $PWD:/srv/gitbook-src \
    -v ~/.ssh:/root/.ssh \
    -e GIT_USERNAME=username \
    -e GIT_USEREMAIL=username@domain.com \
    -e GIT_REPO=git@github.com:username/repo \
    -e GIT_BRANCH=master \
    khs1994/gitbook \
    deploy
```

有两种验证方式，第一种像上面一样挂载 ssh 文件，使用 `ssh` 方式验证，第二种方式你可以通过 `TOKEN` 验证。

```bash
$ docker run -it --rm \
    -v $PWD:/srv/gitbook-src \
    -e GIT_USERNAME=username \
    -e GIT_USEREMAIL=username@domain.com \
    -e GIT_TOKEN=mytoken \
    -e GIT_REPO=github.com/username/repo \
    -e GIT_BRANCH=master \
    khs1994/gitbook \
    deploy
```

## [GitHub Actions](https://help.github.com/en/categories/automating-your-workflow-with-github-actions)

```yaml
- name: GitBook Build
  uses: docker://khs1994/gitbook
- name: GitBook Deploy
  uses: docker://khs1994/gitbook
  if: github.event_name == 'push'
  with:
    args: deploy
  env:
    GIT_USERNAME: "khs1994"
    GIT_USEREMAIL: "khs1994@khs1994.com"
    GIT_BRANCH: "gh-pages"
    GITHUB_TOKEN: ${{ secrets.PCIT_GIT_TOKEN }}
    # 如果使用默认的 ${{ secrets.GITHUB_TOKEN }} 推送之后，pages 服务不会自动构建
    # 造成 pages 服务不能使用
    # 故请使用自己的 Token，请自行到 GitHub 页面生成 Token

    # GIT_REPO: github.com/username/repo
    # 这个变量在 GitHub Actions 中自动识别，无需传入。
    # 如果你需要将 gitbook 生成的页面推送到别的仓库，你可以传入该变量
    # GIT_TOKEN:
    # 传入了 GIT_REPO 变量，必须传入 GIT_TOKEN 变量
```

* More Examples: https://github.com/khs1994-website/composer-docs.zh-cn/blob/master/.github/workflows/gitbook.yaml

# Who use this image ?

* [PCIT](https://github.com/pcit-ce/pcit/blob/master/pcit_examples/gitbook.yml)
