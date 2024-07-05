#!/bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2154
source /config/envs
echo -e "\n=> Modifying the constant-pro.js for ${SERVER}2Alist..."
if test -z "$MediaPathMapping" ; then 
    echo "MediaPathMapping is empty!"
else
    echo -e "MediaPathMapping is:\n$MediaPathMapping"
    # reference: https://unix.stackexchange.com/questions/534755/how-to-append-a-variable-in-a-text-file-after-a-certain-word
    # sed -i '/const mediaPathMapping/r/dev/stdin' /etc/nginx/conf.d/config/constant-pro.js <<<"$MediaPathMapping"
    ( set -f; IFS=$'\n'; printf '%s\n' $MediaPathMapping ) | sed -i '/const mediaPathMapping/r/dev/stdin' /etc/nginx/conf.d/config/constant-pro.js 
fi

if test -z "$RouteRule" ; then 
    echo "RouteRule is empty!"
else
    echo -e "RouteRule is:\n$RouteRule"
    # reference: https://unix.stackexchange.com/questions/534755/how-to-append-a-variable-in-a-text-file-after-a-certain-word
    # sed -i '/const mediaPathMapping/r/dev/stdin' /etc/nginx/conf.d/config/constant-pro.js <<<"$MediaPathMapping"
    ( set -f; IFS=$'\n'; printf '%s\n' $RouteRule ) | sed -i '/const routeRule/r/dev/stdin' /etc/nginx/conf.d/config/constant-pro.js 
fi