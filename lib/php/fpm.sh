# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

php_fpm_create_php_fpm_conf() {
  nos_print_bullet "Generating php-fpm.conf"
  nos_template \
    "php/php-fpm.conf.mustache" \
    "$(nos_etc_dir)/php/php-fpm.conf" \
    "$(php_fpm_conf_payload)"
}

php_fpm_conf_payload() {
  _events_mechanism=$(php_fpm_events_mechanism)
  _max_children=$(php_fpm_max_children)
  _max_spare_servers=$(php_fpm_max_spare_servers)
  _max_requests=$(php_fpm_max_requests)
  nos_print_bullet_sub "Events mechanism: ${_events_mechanism}"
  nos_print_bullet_sub "Max children: ${_max_children}"
  nos_print_bullet_sub "Max spare servers: ${_max_spare_servers}"
  nos_print_bullet_sub "Max requests: ${_max_requests}"
  cat <<-END
{
  "deploy_dir": "$(nos_deploy_dir)",
  "events_mechanism": "${_events_mechanism}",
  "max_children": "${_max_children}",
  "max_spare_servers": "${_max_spare_servers}",
  "max_requests": "${_max_requests}",
  "php53": "$(php_php53)"
}
END
}

php_fpm_events_mechanism() {
  # boxfile php_fpm_events_mechanism
  uname=$(uname)
  [[ "$uname" =~ "Linux" ]] && default=epoll
  _php_fpm_events_mechanism=$(nos_validate "$(nos_payload php_fpm_events_mechanism)" "string" "$default")
  echo "$_php_fpm_events_mechanism"
}

php_fpm_max_children() {
  # boxfile php_fpm_max_children
  _php_fpm_max_children=$(nos_validate "$(nos_payload boxfile_php_fpm_max_children)" "integer" "20")
  echo "$_php_fpm_max_children"
}

php_fpm_max_spare_servers() {
  # boxfile php_fpm_max_spare_servers
  _php_fpm_max_spare_servers=$(nos_validate "$(nos_payload boxfile_php_fpm_max_spare_servers)" "integer" "1")
  echo "$_php_fpm_max_spare_servers"
}

php_fpm_max_requests() {
  # boxfile php_fpm_max_requests
  _php_fpm_max_requests=$(nos_validate "$(nos_payload boxfile_php_fpm_max_requests)" "integer" "128")
  echo "$_php_fpm_max_requests"
}

php_fpm_use_fastcgi() {
  # use fastcgi when apache is configured to use it
  # use fastcgi when the webserver is nginx
  # don't use fastcgi if webserver is builtin
  # don't use fastcgi if apache is using mod_php
  [[ "$(php_webserver)" = 'nginx' ]] && echo 'true' && return
  [[ "$(php_webserver)" = 'builtin' ]] && echo 'false' && return
  [[ "$(php_webserver)" = 'apache' && "$(nos_validate "$(nos_payload boxfile_apache_php_interpreter)" "string" "fpm")" = 'fpm' ]] && echo "true" && return
  [[ "$(php_webserver)" = 'apache' && "$(nos_validate "$(nos_payload boxfile_apache_php_interpreter)" "string" "fpm")" = 'mod_php' ]] && echo "false" && return
  echo "false"
}

php_configure_php_fpm() {
  if [[ "$(php_fpm_use_fastcgi)" = "true" ]]; then
    nos_print_bullet "Configuring PHP-FPM"
    mkdir -p $(nos_etc_dir)/php
    mkdir -p $(nos_deploy_dir)/var/run
    mkdir -p $(nos_deploy_dir)/var/tmp
    php_fpm_create_php_fpm_conf
  fi
}