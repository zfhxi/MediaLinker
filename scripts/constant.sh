#!/bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2154
source /config/envs
echo -e "\n=> Modifying the constant.js for ${SERVER}2Alist..."
# host
if test -z "$SERVER_HOST" ; then 
  echo "SERVER_HOST is empty!"
else
  echo "SERVER_HOST is $SERVER_HOST!"
  sed -i 's#^const '"${SERVER}"'Host.*#const '"${SERVER}"'Host = '"\"${SERVER_HOST}\";"'#g' /etc/nginx/conf.d/constant.js
fi
# apikey only for emby
if [ "${SERVER}" = "emby" ] &&  test -n "$EMBY_API_KEY" ; then 
  echo "EMBY_API_KEY is $EMBY_API_KEY!"
  sed -i 's#^const embyApiKey.*#const embyApiKey = '"\"${EMBY_API_KEY}\";"'#g' /etc/nginx/conf.d/constant.js
elif [ "${SERVER}" = "emby" ] &&  test -z "$EMBY_API_KEY" ; then
  echo "EMBY_API_KEY is empty!"
fi
# MountPath
if test -z "$MOUNT_PATH" ; then 
  echo "MOUNT_PATH is empty!"
else
  echo "MOUNT_PATH is $MOUNT_PATH!"
  sed -i 's#^const mediaMountPath.*#const mediaMountPath = '"[\"${MOUNT_PATH}\"];"'#g' /etc/nginx/conf.d/constant.js
fi