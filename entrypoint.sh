#!/usr/bin/env bash
set -e

mkdir -p /opt/conf.d/templates/http \
         /opt/conf.d/templates/rtmp
mkdir -p /opt/conf.d/http \
         /opt/conf.d/rtmp

FILTER_ENV="$(env | sed -e 's/=.*//' -e 's/^/\$/g')"

# http
for f in $(ls /opt/conf.d/templates/http)
do
    envsubst "$FILTER_ENV" < \
      /opt/conf.d/templates/http/$f > /opt/conf.d/http/$f
done;

# rtmp
for f in $(ls /opt/conf.d/templates/rtmp)
do
    envsubst "$FILTER_ENV" < \
      /opt/conf.d/templates/rtmp/$f > /opt/conf.d/rtmp/$f
done;

# nginx
envsubst "$FILTER_ENV" < \
  /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

nginx
