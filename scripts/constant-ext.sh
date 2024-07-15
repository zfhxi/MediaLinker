#!/bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2154
source /scripts/setup.sh
if [ "${SERVER}" = "emby" ]; then
  pretty_echo IN "修改constant-ext.js..."
  # imageCachePolicy for emby
  if test -z "$EMBY_IMAGE_CACHE_POLICY" ; then 
    pretty_echo WR "EMBY_IMAGE_CACHE_POLICY为空!"
  else
    sed -i.bak 's#^const imageCachePolicy.*#const imageCachePolicy = '"${EMBY_IMAGE_CACHE_POLICY};"'#g' /etc/nginx/conf.d/config/constant-mount.js
    cmp_two_files /etc/nginx/conf.d/config/constant-ext.js /etc/nginx/conf.d/config/constant-mount.js "imageCachePolicy => $EMBY_IMAGE_CACHE_POLICY"
  fi
fi