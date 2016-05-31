# Integration test for a simple go app

# source environment helpers
. util/env.sh

payload() {
  cat <<-END
{
  "code_dir": "/tmp/code",
  "data_dir": "/data",
  "app_dir": "/tmp/app",
  "cache_dir": "/tmp/cache",
  "etc_dir": "/data/etc",
  "env_dir": "/data/etc/env.d",
  "config": {}
}
END
}

setup() {
  # cd into the engine bin dir
  cd /engine/bin
}

@test "setup" {
  # prepare environment (create directories etc)
  prepare_environment

  # prepare pkgsrc
  run prepare_pkgsrc

  # create the code_dir
  mkdir -p /tmp/code

  # copy the app into place
  cp -ar /test/apps/phpinfo/* /tmp/code

  run pwd

  [ "$output" = "/engine/bin" ]
}

@test "boxfile" {
  run /engine/bin/boxfile "$(payload)"

  echo "$output"

  [ "$status" -eq 0 ]
}

@test "prepare" {
  run /engine/bin/prepare "$(payload)"

  echo "$output"

  [ "$status" -eq 0 ]
}

@test "compile" {
  run /engine/bin/compile "$(payload)"

  echo "$output"

  [ "$status" -eq 0 ]
}

@test "cleanup" {
  run /engine/bin/cleanup "$(payload)"

  echo "$output"

  [ "$status" -eq 0 ]
}

@test "release" {
  run /engine/bin/release "$(payload)"

  echo "$output"

  [ "$status" -eq 0 ]
}

# @test "verify" {
  # # remove the code dir
  # rm -rf /tmp/code

  # # mv the app_dir to code_dir
  # mv /tmp/app /tmp/code

  # # cd into the app code_dir
  # cd /tmp/code

  # # start the server in the background
  # ./simple-go &

  # # grab the pid
  # pid=$!

  # # sleep a few seconds so the server can start
  # sleep 3

  # # curl the index
  # run curl -s 127.0.0.1:8080 2>/dev/null

  # expected="Hello world!"

  # # kill the server
  # kill -9 $pid > /dev/null 2>&1

  # echo "$output"

  # [ "$output" = "$expected" ]
# }
