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
  "config": {"extensions": ["phar","json","filter","hash","mongo"],"zend_extensions":["xcache"],"dev_extensions":{"add":["geoip", "session"],"rm":["mongo"]},"dev_zend_extensions":{"add":["xdebug", "memcache"],"rm":["xcache"]}}
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

  echo "prod"
  ls /data/etc/php.prod.d
  echo "dev"
  ls /data/etc/php.dev.d

  [ -f "/data/etc/php.prod.d/mongo.ini" ]
  [ ! -f "/data/etc/php.dev.d/mongo.ini" ]
  [ ! -f "/data/etc/php.prod.d/geoip.ini" ]
  [ -f "/data/etc/php.dev.d/geoip.ini" ]
  [ -f "/data/etc/php.prod.d/xcache.ini" ]
  [ ! -f "/data/etc/php.dev.d/xcache.ini" ]
  [ ! -f "/data/etc/php.prod.d/memcache.ini" ]
  [ -f "/data/etc/php.dev.d/memcache.ini" ]
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

@test "verify" {
  # remove the code dir
  rm -rf /tmp/code

  # mv the app_dir to code_dir
  mv /tmp/app /tmp/code

  # cd into the app code_dir
  cd /tmp/code

  # start php-fpm
  /data/bin/start-php &

  # start apache
  /data/bin/start-apache &

  # sleep a few seconds so the server can start
  sleep 3

  # curl the index
  run curl -s 127.0.0.1:8080 2>/dev/null

  # kill the server
  pkill php-fpm


  echo "$output"

  [[ "$output" =~ "phpinfo()" ]]
  [[ "$output" =~ "mongo" ]]
  [[ "$output" =~ "xcache" ]]

  # start php-fpm
  APP_NAME=dev /data/bin/start-php &

  sleep 3

  # curl the index
  run curl -s 127.0.0.1:8080 2>/dev/null

  # kill the server
  pkill php-fpm

  pkill httpd

  echo "$output"

  [[ "$output" =~ "phpinfo()" ]]
  [[ "$output" =~ "geoip" ]]
  [[ "$output" =~ "xdebug" ]]
}
