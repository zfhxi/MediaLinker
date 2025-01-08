#!/bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2154
source /scripts/setup.sh
cp /etc/nginx/conf.d/config/constant-pro.js /etc/nginx/conf.d/config/constant-pro.js.ori
pretty_echo IN "修改constant-pro.js..."
if test -z "$MediaPathMapping" ; then 
    pretty_echo WR "MediaPathMapping为空!"
else
    pretty_echo IN "MediaPathMapping:\n$MediaPathMapping"
    # reference: https://unix.stackexchange.com/questions/534755/how-to-append-a-variable-in-a-text-file-after-a-certain-word
    ( set -f; IFS=$'\n'; printf '%s\n' $MediaPathMapping ) | sed -i.bak '/const mediaPathMapping/r/dev/stdin' /etc/nginx/conf.d/config/constant-pro.js 
    cmp_two_files /etc/nginx/conf.d/config/constant-pro.js /etc/nginx/conf.d/config/constant-pro.js.bak mediaPathMapping
fi

if test -z "$RouteRule" ; then 
    pretty_echo WR "RouteRule为空!"
else
    pretty_echo IN "RouteRule is:\n$RouteRule"
    # reference: https://unix.stackexchange.com/questions/534755/how-to-append-a-variable-in-a-text-file-after-a-certain-word
    ( set -f; IFS=$'\n'; printf '%s\n' $RouteRule ) | sed -i.bak '/const routeRule/r/dev/stdin' /etc/nginx/conf.d/config/constant-pro.js 
    cmp_two_files /etc/nginx/conf.d/config/constant-pro.js /etc/nginx/conf.d/config/constant-pro.js.bak routeRule
fi