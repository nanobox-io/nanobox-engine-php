
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
  echo $(validate "$(payload "boxfile_js_runtime")" "string" "nodejs-0.12")
}

install_js_runtime() {
  install "$(js_runtime)"
}

webserver() {
  echo $(validate "$(payload boxfile_webserver)" "string" "apache")
}

install_webserver() {
  if [[ "$(webserver)" = 'apache' ]]; then
    install_apache
  elif [[ "$(webserver)" = 'nginx' ]]; then
    install_nginx
  fi
}

install_composer() {
  if [[ -f $(code_dir)/composer.json ]]; then
    install "composer"
  fi
}

composer_install() {
  if [[ -f $(code_dir)/composer.json ]]; then
    if [[ ! -f $(code_dir)/composer.lock ]]; then
      print_warning "No 'composer.lock' file detected. This may cause a slow or failed build. To avoid this issue, commit the 'composer.lock' file to your git repo."
    fi
    (cd $(payload 'code_dir'); run_process "composer install" "composer install --no-interaction --prefer-source")
  fi
}

configure_webserver() {
  if [[ "$(webserver)" = 'apache' ]]; then
    configure_apache
  elif [[ "$(webserver)" = 'nginx' ]]; then
    configure_nginx
  fi
}