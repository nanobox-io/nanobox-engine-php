#!/bin/bash
#
# Run an individual test.
#
# $1 = test
#
# Example: ./run.sh lib/general_test.bats

file=$1
test_dir="$(dirname $(readlink -f $BASH_SOURCE))"
tests_dir="${test_dir}/tests"
engine_dir="$(dirname ${test_dir})"

# source the env helper
. $test_dir/util/env.sh

# Ensure an argument was provided
if [[ $# -lt 1 ]]; then
  echo "Fatal: Must provide a test file as an argument"
  exit 1
fi

# Ensure the argument provided is a path to a file
if [[ ! -f ${tests_dir}/${file} ]]; then
  echo "Fatal: Test provided does not exist in tests (${file})"
  exit 1
fi

# Ensure the test is a .bats test file
filename=$(basename "${file}")
extension="${filename##*.}"

if [[ ! "$extension" = "bats" ]]; then
  echo "Fatal: Test provided is not a bats file (${file})"
  exit 1
fi

echo "+> Running test ${file}:"

tty_opts=""

if [[ ! $TRAVIS ]]; then
  tty_opts="-t"
fi

# Run the test directly in a docker container
docker run \
  $tty_opts \
  -u=gonano \
  --privileged=true \
  --workdir=/test \
  -e "PATH=$(path)" \
  --volume=${test_dir}/:/test \
  --volume=${engine_dir}/:/engine \
  --volume=/home/vagrant/ssh:/home/gonano/.ssh \
  --volume=/tmp/pkgsrc:/data/var/db/pkgin/cache \
  --rm \
  nanobox/build \
  /test/util/bats/bin/bats \
    /test/tests/${file} \
      2>&1 \
        | (grep '\S' || echo "") \
          | sed -e 's/\r//g;s/^/   /'

# test the exit code
if [[ "${PIPESTATUS[0]}" != "0" ]]; then
  echo "   [!] FAILED"
  exit 1
else
  echo "   [√] SUCCESS"
fi
