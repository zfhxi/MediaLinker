#!/bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2154

source /config/envs


function pretty_echo()
{
    # 参考：https://stackoverflow.com/questions/19572811/color-most-of-all-terminals-for-different-syntax-messages-in-logs
    local typ="$1"
    local msg="${@:2}"

    if [ $typ == "ER" ]; then
        echo -e "\033[0;31m[ ERROR ]  ${msg}\033[0m"
    elif [ $typ == "OK" ]; then
        echo -e "\033[0;32m[ OKAY  ]  ${msg}\033[0m"
    elif [ $typ == "WR" ]; then
        echo -e "\033[0;33m[ WARN  ]  ${msg}\033[0m"
    elif [ $typ == "IN" ]; then
        echo -e "\033[0;34m[ INFO  ]  ${msg}\033[0m"
    else
        echo -en "\033[1;33m[ WARN  ]  Wrong message type: "
        echo -e "${typ}\033[0m\n\t   ${msg}"
    fi
}

function cmp_two_files(){
    if ! cmp -s "$1" "$2"; then
        pretty_echo OK "$1已更改$3!"
    else
        pretty_echo WR "$1未更改$3!"
    fi
}