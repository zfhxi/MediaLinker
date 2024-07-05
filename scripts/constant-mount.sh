#!/bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2154
source /config/envs
echo -e "\n=> Modifying the constant-mount.js for ${SERVER}2Alist..."
# alist内网地址
if test -z "$ALIST_ADDR" ; then 
  echo "ALIST_ADDR is empty!"
else
  echo "ALIST_ADDR is $ALIST_ADDR!"
  sed -i 's#^const alistAddr.*#const alistAddr = '"\"${ALIST_ADDR}\";"'#g' /etc/nginx/conf.d/config/constant-mount.js
fi

# alist token
if test -z "$ALIST_TOKEN" ; then 
  echo "ALIST_TOKEN is empty!"
else
  echo "ALIST_TOKEN is $ALIST_TOKEN!"
  sed -i 's#^const alistToken.*#const alistToken = '"\"${ALIST_TOKEN}\";"'#g' /etc/nginx/conf.d/config/constant-mount.js
fi

# alist 是否签名
if test -z "$ALIST_SIGNENABLE" ; then 
  echo "ALIST_SIGNENABLE is empty!"
else
  echo "ALIST_SIGNENABLE is $ALIST_SIGNENABLE!"
  sed -i 's#^const alistSignEnable.*#const alistSignEnable = '"\"${ALIST_SIGNENABLE}\";"'#g' /etc/nginx/conf.d/config/constant-mount.js
fi

# alist公网地址
if test -z "$ALIST_PUBLIC_ADDR" ; then 
  echo "ALIST_PUBLIC_ADDR is empty!"
else
  echo "ALIST_PUBLIC_ADDR is $ALIST_PUBLIC_ADDR!"
  sed -i 's#^const alistPublicAddr.*#const alistPublicAddr = '"\"${ALIST_PUBLIC_ADDR}\";"'#g' /etc/nginx/conf.d/config/constant-mount.js
fi

