#!/bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2154
source /config/envs
if [ "${SERVER}" = "emby" ]; then
  echo -e "\n=> Modifying the constant-ext.js for ${SERVER}2Alist..."
  # imageCachePolicy for emby
  if test -z "$EMBY_IMAGE_CACHE_POLICY" ; then 
    echo "EMBY_IMAGE_CACHE_POLICY is empty!"
  else
    echo "EMBY_IMAGE_CACHE_POLICY is $EMBY_IMAGE_CACHE_POLICY!"
    sed -i 's#^const imageCachePolicy.*#const imageCachePolicy = '"${EMBY_IMAGE_CACHE_POLICY};"'#g' /etc/nginx/conf.d/config/constant-mount.js
  fi
fi