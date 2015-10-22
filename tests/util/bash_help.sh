#!/bin/bash

CLEAN=""
function defer() {
  if [ "$CLEAN" == "" ]; then
    CLEAN="$@;"
  else
    CLEAN="$CLEAN $@;"
  fi
}

function pass() {
  msg=$1
  shift
  if ! "$@"; then
    echo $msg
    exit 1
  fi
}

function fail() {
  msg=$1
  shift
  if "$@"; then
    echo $msg
    exit 1
  fi
}

function payload() {
  cat tests/payloads/${1}.json
}

function finish {
  ## I don't like eval, but its the only good way to do this right now.
  eval $CLEAN
}

trap finish EXIT