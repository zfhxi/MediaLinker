#!/bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2154
source /scripts/setup.sh
pretty_echo IN "修改constant-mount.js..."
cp /etc/nginx/conf.d/config/constant-mount.js /etc/nginx/conf.d/config/constant-mount.js.ori
# alist内网地址
if test -z "$ALIST_ADDR" ; then 
  pretty_echo WR "ALIST_ADDR为空!"
else
  sed -i.bak 's#^const alistAddr.*#const alistAddr = '"\"${ALIST_ADDR}\";"'#g' /etc/nginx/conf.d/config/constant-mount.js
  cmp_two_files /etc/nginx/conf.d/config/constant-mount.js /etc/nginx/conf.d/config/constant-mount.js.bak "alistAddr => $ALIST_ADDR"
fi

# alist token
if test -z "$ALIST_TOKEN" ; then 
  pretty_echo WR "ALIST_TOKEN为空!"
else
  sed -i.bak 's#^const alistToken.*#const alistToken = '"\"${ALIST_TOKEN}\";"'#g' /etc/nginx/conf.d/config/constant-mount.js
  cmp_two_files /etc/nginx/conf.d/config/constant-mount.js /etc/nginx/conf.d/config/constant-mount.js.bak "alistToken => $ALIST_TOKEN"
fi

# alist 是否签名
if test -z "$ALIST_SIGNENABLE" ; then 
  pretty_echo WR "ALIST_SIGNENABLE为空!"
else
  sed -i.bak 's#^const alistSignEnable.*#const alistSignEnable = '"${ALIST_SIGNENABLE};"'#g' /etc/nginx/conf.d/config/constant-mount.js
  cmp_two_files /etc/nginx/conf.d/config/constant-mount.js /etc/nginx/conf.d/config/constant-mount.js.bak "alistSignEnable => $ALIST_SIGNENABLE"
fi

# alist公网地址
if test -z "$ALIST_PUBLIC_ADDR" ; then 
  pretty_echo WR "ALIST_PUBLIC_ADDR为空!"
else
  sed -i.bak 's#^const alistPublicAddr.*#const alistPublicAddr = '"\"${ALIST_PUBLIC_ADDR}\";"'#g' /etc/nginx/conf.d/config/constant-mount.js
  cmp_two_files /etc/nginx/conf.d/config/constant-mount.js /etc/nginx/conf.d/config/constant-mount.js.bak "alistPublicAddr => $ALIST_PUBLIC_ADDR"
fi

# alist链接处理
if test -z "$ClientSelfAlistRule" ; then 
    pretty_echo WR "ClientSelfAlistRule为空!"
else
    pretty_echo IN "ClientSelfAlistRule is:\n$ClientSelfAlistRule"
    sed -r -i.bak '/const clientSelfAlistRule/,/];/s/(\s+)\[2, strHead\["115"\], alistPublicAddr\]/\1\/\/ [2, strHead["115"], alistPublicAddr]/' /etc/nginx/conf.d/config/constant-mount.js
    # reference: https://unix.stackexchange.com/questions/534755/how-to-append-a-variable-in-a-text-file-after-a-certain-word
    ( set -f; IFS=$'\n'; printf '%s\n' $ClientSelfAlistRule ) | sed -i '/const clientSelfAlistRule/r/dev/stdin' /etc/nginx/conf.d/config/constant-mount.js 
    cmp_two_files /etc/nginx/conf.d/config/constant-mount.js /etc/nginx/conf.d/config/constant-mount.js.bak clientSelfAlistRule
fi
