#!/usr/bin/env bash


info() {
     local green="\033[1;32m"
     local normal="\033[0m"
     echo -e "[${green}INFO${normal}] $1"
}

error() {
     local red="\033[1;31m"
     local normal="\033[0m"
     echo -e "[${red}ERROR${normal}] $1"
}

dif=$*

while [[ x"${dif}" = x ]];
do
  info "请输入提交内容!"
  read  dif
done


git add .
git commit -m "${dif}"
git push

