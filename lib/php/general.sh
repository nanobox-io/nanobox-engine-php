# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_boxfile() {
  nos_template \
    "boxfile.mustache" \
    "-" \
    "$(boxfile_json)"
}

boxfile_json() {
  _has_bower=$(nodejs_has_bower)
  _webserver=$(webserver)
  nos_print_bullet "Detecting settings"
  if [[ "$_webserver" = "apache" ]]; then
    nos_print_bullet_sub "Using Apache HTTP Server as the webserver"
    if [[ "$(is_interpreter 'fpm')" = "true" ]]; then
      nos_print_bullet_sub "Using PHP-FPM as PHP interpreter"
    elif [[ "$(is_interpreter 'mod_php')" = "true" ]]; then
      nos_print_bullet_sub "Using mod_php as PHP interpreter"
    fi
  elif [[ "$_webserver" = "nginx" ]]; then
    nos_print_bullet_sub "Using NGINX as the webserver"
    nos_print_bullet_sub "Using PHP-FPM as PHP interpreter"
  elif [[ "$_webserver" = "builtin" ]]; then
    nos_print_bullet_sub "Using the built-in PHP webserver"
  fi
  if [[ "$_has_bower" = "true" ]]; then
    nos_print_bullet_sub "Adding lib_dirs for bower"
  fi
  cat <<-END
{
  "has_bower": ${_has_bower},
  "apache": $(is_webserver 'apache'),
  "fpm": $(is_interpreter 'fpm'),
  "mod_php": $(is_interpreter 'mod_php'),
  "nginx": $(is_webserver 'nginx'),
  "builtin": $(is_webserver 'builtin'),
  "etc_dir": "$(nos_etc_dir)",
  "deploy_dir": "$(nos_deploy_dir)",
  "code_dir": "$(nos_code_dir)",
  "document_root": "$(builtin_document_root)"
}
END
}

is_webserver() {
  # find webserver
  webserver='apache'
  if [[ -n "$(nos_payload 'boxfile_webserver')" ]]; then
    webserver=$(nos_payload 'boxfile_webserver')
  fi
  if [[ "$webserver" = "$1" ]]; then
    echo "true"
  else
    echo "false"
  fi
}

is_interpreter() {
  # extract php interpreter
  interpreter="fpm"
  if [[ -n "$(nos_payload 'boxfile_apache_php_interpreter')" ]]; then
    interpreter=$(nos_payload 'boxfile_apache_php_interpreter')
  fi
  if [[ "${interpreter}" = "$1" ]]; then
    echo "true"
  else
    echo "false"
  fi
}

app_name() {
  # payload app
  echo "$(nos_payload app)"
}

hostname() {
  # app.gonano.io
  echo $(app_name).gonano.io
}

env_vars() {
  # filtered payload env
  declare -a envlist
  if [[ "${PL_env_type}" = "map" ]]; then
    for i in ${PL_env_nodes//,/ }; do
      key=${i}
      value=PL_env_${i}_value
      envlist+=("{\"key\":\"${key}\",\"value\":\"${!value}\"}")
    done
  fi
  if [[ -z "${envlist[@]}" ]]; then
    echo "[]"
  else
    echo "[ $(nos_join "," ${envlist[@]}) ]"
  fi
}

domains() {
  # payload dns
  declare -a dns
  if [[ "${PL_dns_type}" = "array" ]]; then
    for ((i=0; i < PL_dns_length ; i++)); do
      type=PL_dns_${i}_type
      value=PL_dns_${i}_value
      if [[ ${!type} = "string" ]]; then
        dns+=(${!value})
      fi
    done
  else
    dns+=("localhost")
  fi
  if [[ -z "dns[@]" ]]; then
    echo "[]"
  else
    echo "[ \"$(nos_join '","' ${dns[@]})\" ]"
  fi
}

webserver() {
  _webserver=$(nos_validate "$(nos_payload boxfile_webserver)" "string" "apache")
  echo "${_webserver}"
}

install_webserver() {
  if [[ "$(webserver)" = 'apache' ]]; then
    php_install_apache
  elif [[ "$(webserver)" = 'nginx' ]]; then
    php_install_nginx
  fi
}

install_composer() {
  if [[ -f $(nos_code_dir)/composer.json ]]; then
    nos_install "composer"
  fi
}

composer_install() {
  if [[ -f $(nos_code_dir)/composer.json ]]; then
    if [[ ! -f $(nos_code_dir)/composer.lock ]]; then
      nos_print_warning "No 'composer.lock' file detected. This may cause a slow or failed build. To avoid this issue, commit the 'composer.lock' file to your git repo."
    fi
    (cd $(nos_code_dir); run_subprocess "composer install" "composer install --no-interaction --prefer-source")
  fi
}

configure_webserver() {
  if [[ "$(webserver)" = 'apache' ]]; then
    php_configure_apache
  elif [[ "$(webserver)" = 'nginx' ]]; then
    php_configure_nginx
  fi
}