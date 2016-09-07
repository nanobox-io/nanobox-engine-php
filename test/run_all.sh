#!/bin/bash
#
# Run all tests within the tests directory
#

test_dir="$(dirname $(readlink -f $BASH_SOURCE))"
tests_dir="${test_dir}/tests/"

for file in `find ${tests_dir} -type f -name '*.bats'`; do
  file="$(echo $file | sed "s:${tests_dir}::")"
  $test_dir/run.sh $file

  if [[ "$?" -ne "0" ]]; then
    echo
    echo "! TEST FAILED !"
    echo
    echo "$file exited with a non-zero exit code."
    echo

    exit 1
  fi

done
