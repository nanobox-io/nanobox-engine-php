# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_boxfile() {
  template \
    "boxfile.mustache" \
    "-" \
    "$(boxfile_json)"
}

boxfile_json() {
  cat <<-END
{
  "has_bower": $(has_bower),
  "apache": $(is_webserver 'apache'),
  "fpm": $(is_interpreter 'fpm'),
  "mod_php": $(is_interpreter 'mod_php'),
  "nginx": $(is_webserver 'nginx'),
  "builtin": $(is_webserver 'builtin'),
  "etc_dir": "$(payload 'etc_dir')",
  "deploy_dir": "$(payload 'deploy_dir')",
  "port": "$(payload 'port')",
  "live_dir": "$(payload 'live_dir')",
  "document_root": "$(builtin_document_root)"
}
END
}

is_webserver() {
  # find webserver
  webserver='apache'
  if [[ -n "$(payload 'boxfile_webserver')" ]]; then
    webserver=$(payload 'boxfile_webserver')
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
  if [[ -n "$(payload 'boxfile_apache_php_interpreter')" ]]; then
    interpreter=$(payload 'boxfile_apache_php_interpreter')
  fi
  if [[ "${interpreter}" = "$1" ]]; then
    echo "true"
  else
    echo "false"
  fi
}

app_name() {
  # payload app
  echo "$(payload app)"
}

hostname() {
  # app.gonano.io
  echo $(payload "app").gonano.io
}

deploy_dir() {
  # payload deploy_dir
  echo $(payload "deploy_dir")
}

port() {
  # payload port
  echo $(payload "port")
}

code_dir() {
  # payload code_dir
  echo $(payload "code_dir")
}

live_dir() {
  # payload live_dir
  echo $(payload "live_dir")
}

etc_dir() {
  echo $(payload "etc_dir")
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
    echo "[ $(join "," ${envlist[@]}) ]"
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
    echo "[ \"$(join '","' ${dns[@]})\" ]"
  fi
}

js_runtime() {
  _js_runtime=$(validate "$(payload "boxfile_js_runtime")" "string" "nodejs-0.12")
  >&2 echo "Using ${_js_runtime} as Node.js runtime"
  echo ${_js_runtime}
}

install_js_runtime() {
  install "$(js_runtime)"
}

webserver() {
  _webserver=$(validate "$(payload boxfile_webserver)" "string" "apache")
  >&2 echo "Using ${_webserver} as the webserver"
  echo "${_webserver}"
}

install_webserver() {
  if [[ "$(webserver)" = 'apache' ]]; then
    install_apache
  elif [[ "$(webserver)" = 'nginx' ]]; then
    install_nginx
  fi
}

set_js_runtime() {
  [[ -d $(code_dir)/node_modules ]] && echo "$(js_runtime)" > $(code_dir)/node_modules/runtime
}

check_js_runtime() {
  [[ ! -d $(code_dir)/node_modules ]] && echo "true" && return
  [[ "$(cat $(code_dir)/node_modules/runtime)" =~ ^$(js_runtime)$ ]] && echo "true" || echo "false"
}

npm_rebuild() {
  [[ "$(check_js_runtime)" = "false" ]] && (cd $(code_dir); run_process "npm rebuild" "npm rebuild")
}

install_composer() {
  if [[ -f $(code_dir)/composer.json ]]; then
    install "composer"
  else
    print_bullet_info "No composer.json found, skipping installation of composer"
  fi
}

composer_install() {
  if [[ -f $(code_dir)/composer.json ]]; then
    if [[ ! -f $(code_dir)/composer.lock ]]; then
      print_warning "No 'composer.lock' file detected. This may cause a slow or failed build. To avoid this issue, commit the 'composer.lock' file to your git repo."
    fi
    (cd $(payload 'code_dir'); run_subprocess "composer install" "composer install --no-interaction --prefer-source")
  else
    print_bullet_info "No composer.json found, skipping 'composer install'"
  fi
}

configure_webserver() {
  if [[ "$(webserver)" = 'apache' ]]; then
    configure_apache
  elif [[ "$(webserver)" = 'nginx' ]]; then
    configure_nginx
  fi
}