#!/bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2154
source /scripts/setup.sh
pretty_echo IN "修改constant.js..."
cp /etc/nginx/conf.d/constant.js /etc/nginx/conf.d/constant.js.ori
# host
if test -z "$SERVER_HOST" ; then 
  pretty_echo WR "SERVER_HOST为空!"
else
  sed -i.bak 's#^const '"${SERVER}"'Host.*#const '"${SERVER}"'Host = '"\"${SERVER_HOST}\";"'#g' /etc/nginx/conf.d/constant.js
  cmp_two_files /etc/nginx/conf.d/constant.js /etc/nginx/conf.d/constant.js.bak "Host => $SERVER_HOST"
fi
# apikey only for emby
if [ "${SERVER}" = "emby" ] &&  test -n "$EMBY_API_KEY" ; then 
  sed -i.bak 's#^const embyApiKey.*#const embyApiKey = '"\"${EMBY_API_KEY}\";"'#g' /etc/nginx/conf.d/constant.js
  cmp_two_files /etc/nginx/conf.d/constant.js /etc/nginx/conf.d/constant.js.bak "embyApiKey => $EMBY_API_KEY"
elif [ "${SERVER}" = "emby" ] &&  test -z "$EMBY_API_KEY" ; then
  pretty_echo WR "EMBY_API_KEY为空!"
fi
# MountPath
if test -z "$MOUNT_PATH" ; then 
  pretty_echo WR "MOUNT_PATH为空!"
else
  sed -i.bak 's#^const mediaMountPath.*#const mediaMountPath = '"[\"${MOUNT_PATH}\"];"'#g' /etc/nginx/conf.d/constant.js
  cmp_two_files /etc/nginx/conf.d/constant.js /etc/nginx/conf.d/constant.js.bak "mediaMountPath => $MOUNT_PATH"
fi