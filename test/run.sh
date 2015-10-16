#!/bin/bash
FAILED=0
VERSION=$1
for file in `find . -type f -name '*_test.*'`; do
  echo running $file
  FOLDER=`dirname $0`
  read -r -d '' TEST <<EOF
. $FOLDER/util/bash_help.sh
. $file $VERSION 2>&1 
EOF
  bash -c "$TEST" | awk '{print " "$0}'
  if [ "${PIPESTATUS[0]}" != "0" ]; then
    echo test "$file" failed to run correctly
    let FAILED=FAILED+1
  fi
done

if [ "$FAILED" == "0" ]; then
  echo "all tests passed"
  exit 0
else
  echo "$FAILED test failed to run"
  exit 1
fi