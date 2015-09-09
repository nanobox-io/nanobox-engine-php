#!/bin/bash

join() {
  local IFS=$'\014'
  delimeter=$1
  shift
  temp=$(echo "${*}")
  echo ${temp//$'\014'/$delimeter}
}

valid_integer() {
  [[ "$1" =~ ^[0-9]+$ ]] && return 1
  return 0
}

valid_file() {
  [[ "$1" =~ ^\/?[^\/]+(\/[^\/]+)*$ ]] && return 1
  return 0
}

valid_folder() {
  [[ "$1" =~ ^\/?[^\/]+(\/[^\/]+)*\/?$ ]] && return 1
  return 0
}

valid_boolean() {
  [[ "$1" = 'true' ]] && return 1
  [[ "$1" = 'false' ]] && return 1
  [[ "$1" =~ ^[Oo]n$ ]] && return 1
  [[ "$1" =~ ^[Oo]ff$ ]] && return 1
  [[ $1 -eq 1 ]] && return 1
  [[ $1 -eq 0 ]] && return 1
  return 0
}

valid_byte() {
  [[ "$1" =~ ^[0-9]+[BbKkMmGgTt]?$ ]] && return 1
  return 0
}

valid_string() {
  return 1
}

validate() {
  # $1 value
  # $2 type
  # $3 default
  [[ -z $1 ]] && echo $3 && return
  $(eval valid_$2 $1)
  [[ $? -eq 1 ]] && echo $1 && return
  >&2 echo "Error: value \"$1\" is invalid $2"
  exit 1
}
