#!/bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2154
source /config/envs
if [ "${SERVER}" = "emby" ] && test -n "$EMBY_PUBLIC_ADDR" ; then
  echo "\n=> Adding the embyAddExternalUrl for emby..."
  cp /embyExternalUrl/embyAddExternalUrl/nginx/conf.d/externalUrl.js /etc/nginx/conf.d/
  sed -i '/js_path \/etc\/nginx\/conf.d.*$/a js_import addExternalUrl from externalUrl.js;' /etc/nginx/conf.d/emby.conf
  tmp_str=$(cat /embyExternalUrl/embyAddExternalUrl/nginx/conf.d/emby.conf | grep -Pzo ".*## addExternalUrl SETTINGS ##(\n|.)*## addExternalUrl SETTINGS ##")
  # awk -v var="$tmp_str" '{if(/^.*location\s*\/\s*{\s*$/)printf("%s\n%s",var,$0);else print $0}' /etc/nginx/conf.d/emby.conf > /etc/nginx/conf.d/emby.conf
  cp /etc/nginx/conf.d/emby.conf /etc/nginx/conf.d/emby.conf.bak
  awk -v var="$tmp_str" '{if(/location \/ \{/)printf("%s\n\n%s\n",var,$0);else print $0}' /etc/nginx/conf.d/emby.conf > /etc/nginx/conf.d/emby.conf.tmp
  mv /etc/nginx/conf.d/emby.conf.tmp /etc/nginx/conf.d/emby.conf
  # emby公网地址替换
  echo "EMBY_PUBLIC_ADDR is $EMBY_PUBLIC_ADDR!"
  sed -i 's#^let serverAddr.*#let serverAddr = '"\'${EMBY_PUBLIC_ADDR}\';"'#g' /etc/nginx/conf.d/externalUrl.js
fi