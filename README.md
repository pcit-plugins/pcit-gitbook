# GitBook Docker

[![GitHub stars](https://img.shields.io/github/stars/khs1994-docker/gitbook.svg?style=social&label=Stars)](https://github.com/khs1994-docker/gitbook) [![Docker Stars](https://img.shields.io/docker/stars/khs1994/gitbook.svg)](https://store.docker.com/community/images/khs1994/gitbook/) [![Docker Pulls](https://img.shields.io/docker/pulls/khs1994/gitbook.svg)](https://store.docker.com/community/images/khs1994/gitbook/)

# Supported tags and respective `Dockerfile` links

* [`latest` (*alpine/Dockerfile*)](https://github.com/khs1994-docker/gitbook/tree/master/alpine/Dockerfile)

# 目的

在 Travis CI 使用 GitBook 构建文档，大部分时间用在了安装 GitBook 环境上，将环境打包到 Docker，大大节约了时间。

# Overview

* [`Node.js`](https://github.com/docker-library/docs/tree/master/node) `GitBook` 均为最新版

* 本镜像主要完成 `GitBook` 及其插件的安装，具体请查看 `book.json` 文件

* 基于 `book.json` 完全可以构建自己的镜像

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
    -v ~/.gitconfig:/root/.gitconfig \
    -e GIT_REPO=git@github.com:username/repo.git \
    -e BRANCH=master \
    khs1994/gitbook \
    deploy
```

# More Information

* [Changelog](https://github.com/khs1994-docker/gitbook/blob/master/Changelog.md)
