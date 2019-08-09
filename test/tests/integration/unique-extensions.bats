# Integration test for a simple php app

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
  "config": {"runtime": "php-5.6", "extensions": ["json","json","json","json","json","xmlwriter","xml"],"zend_extensions":["xcache","xcache"],"dev_extensions":{"add":["geoip", "geoip"],"rm":["mongo"]},"dev_zend_extensions":{"add":["xdebug", "xdebug"],"rm":["xcache"]}, "apache_version": "2.2"}
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
  if [[ ! -f /engine/bin/boxfile ]]; then
    skip "No boxfile script"
  fi
  run /engine/bin/boxfile "$(payload)"

  echo "$output"

  [ "$status" -eq 0 ]
}

@test "build" {
  if [[ ! -f /engine/bin/build ]]; then
    skip "No build script"
  fi
  run /engine/bin/build "$(payload)"

  echo "$output"
  echo "$(grep -c json.so /data/etc/php/prod_php.ini)"
  echo "$(grep -c xcache.so /data/etc/php/prod_php.ini)"
  echo "$(grep -c xml.so /data/etc/php/prod_php.ini)"
  echo "$(grep -c xmlwriter.so /data/etc/php/prod_php.ini)"
  echo "$(grep -c json.so /data/etc/php/dev_php.ini)"
  echo "$(grep -c xcache.so /data/etc/php/dev_php.ini)"
  echo "$(grep -c geoip.so /data/etc/php/dev_php.ini)"
  echo "$(grep -c xdebug.so /data/etc/php/dev_php.ini)"
  echo "$(grep -c xml.so /data/etc/php/dev_php.ini)"
  echo "$(grep -c xmlwriter.so /data/etc/php/dev_php.ini)"

  [ "$status" -eq 0 ]
  [ "$(grep -c json.so /data/etc/php/prod_php.ini)" = "1" ]
  [ "$(grep -c xcache.so /data/etc/php/prod_php.ini)" = "1" ]
  [ "$(grep -c xml.so /data/etc/php/prod_php.ini)" = "1" ]
  [ "$(grep -c xmlwriter.so /data/etc/php/prod_php.ini)" = "1" ]
  [ "$(grep -c json.so /data/etc/php/dev_php.ini)" = "1" ]
  [ "$(grep -c xcache.so /data/etc/php/dev_php.ini)" = "0" ]
  [ "$(grep -c geoip.so /data/etc/php/dev_php.ini)" = "1" ]
  [ "$(grep -c xdebug.so /data/etc/php/dev_php.ini)" = "1" ]
  [ "$(grep -c xml.so /data/etc/php/dev_php.ini)" = "1" ]
  [ "$(grep -c xmlwriter.so /data/etc/php/dev_php.ini)" = "1" ]
}

@test "compile" {
  if [[ ! -f /engine/bin/compile ]]; then
    skip "No compile script"
  fi
  run /engine/bin/compile "$(payload)"

  echo "$output"

  [ "$status" -eq 0 ]
}

@test "cleanup" {
  if [[ ! -f /engine/bin/cleanup ]]; then
    skip "No cleanup script"
  fi
  run /engine/bin/cleanup "$(payload)"

  echo "$output"

  [ "$status" -eq 0 ]
}

@test "release" {
  if [[ ! -f /engine/bin/release ]]; then
    skip "No release script"
  fi
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
  # /data/bin/start-php &

  # start apache
  # /data/bin/start-apache &
  php-server &

  # sleep a few seconds so the server can start
  sleep 3

  # curl the index
  run curl -s 127.0.0.1:8080 2>/dev/null

  # kill the server
  # pkill php-fpm

  # pkill httpd
  pkill php-server
}
