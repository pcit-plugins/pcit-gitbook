#!/bin/sh
date
du -sh /tmp/gitbook/node_modules
cp -r /tmp/gitbook/node_modules .
echo $PWD
gitbook build
