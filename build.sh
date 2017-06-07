#!/bin/bash
VERSION=v1
#
#Because we are pulling from source repositories we don't want to use any cache
#
docker build --no-cache=true -t spark-pivot:${VERSION} .
