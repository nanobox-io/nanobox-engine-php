# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

generate_apache_conf() {
  
  # Report back to the user
  report_apache_settings
  
  nos_template \
    "apache/apache.conf.mustache" \
    "$(nos_etc_dir)/httpd/httpd.conf" \
    "$(apache_conf_payload)"
}

report_apache_settings() {
  if [[ "$(apache_mod_php)" = "true" ]]; then
    nos_print_bullet_sub "Enabling mod_php"
  fi
  
  if [[ "$(php_fpm_use_fastcgi)" = "true" ]]; then
    nos_print_bullet_sub "Enabling FastCGI"
  fi
  
  nos_print_bullet_sub "Max spare servers: $(apache_max_spares)"
  nos_print_bullet_sub "Max clients: $(apache_max_clients)"
  nos_print_bullet_sub "Max requests per child: $(apache_max_requests_per_child)"
  nos_print_bullet_sub "Server limit: $(apache_server_limit)"
  nos_print_bullet_sub "Document root: $(apache_document_root)"
  nos_print_bullet_sub "Directory index: $(apache_directory_index)"
  nos_print_bullet_sub "Default application gateway: $(apache_default_gateway)"
  nos_print_bullet_sub "Static expires: $(apache_static_expire)"
  nos_print_bullet_sub "Log level: $(apache_log_level)"
  nos_print_bullet_sub "Enable access log: $(apache_access_log)"
}

apache_conf_payload() {
  cat <<-END
{
  "data_dir": "$(nos_data_dir)",
  "timeout": "$(timeout)",
  "max_spares": "$(apache_max_spares)",
  "max_clients": "$(apache_max_clients)",
  "max_requests_per_child": "$(apache_max_requests_per_child)",
  "server_limit": "$(apache_server_limit)",
  "mod_php": $(apache_mod_php),
  "fastcgi": $(php_fpm_use_fastcgi),
  "modules": $(apache_modules),
  "code_dir": "$(nos_code_dir)",
  "document_root": "$(apache_document_root)",
  "directory_index": "$(apache_directory_index)",
  "default_gateway": "$(apache_default_gateway)",
  "etc_dir": "$(nos_etc_dir)",
  "static_expire": "$(apache_static_expire)",
  "log_level": "$(apache_log_level)",
  "access_log": "$(apache_access_log)",
  "apache24": $(apache24),
  "php7": $(php7)
}
END
}

apache_version() {
  # boxfile apache_version
  apache_version=$(nos_validate "$(nos_payload config_apache_version)" "string" "2.2")
  echo "$apache_version"
}

apache24() {
  # boxfile php_version = 7
  [[ $(apache_version) =~ "2.4" ]] && echo "true" && return
  echo "false"
}

apache_max_spares() {
  # boxfile apache_max_spares
  apache_max_spares=$(nos_validate "$(nos_payload config_apache_max_spares)" "integer" "1")
  echo "$apache_max_spares"
}

apache_max_clients() {
  # boxfile apache_max_clients
  apache_max_clients=$(nos_validate "$(nos_payload config_apache_max_clients)" "integer" "128")
  echo "$apache_max_clients"
}

apache_max_requests_per_child() {
  # boxfile apache_max_requests
  apache_max_requests_per_child=$(nos_validate "$(nos_payload config_apache_max_requests_per_child)" "integer" "768")
  echo "$apache_max_requests_per_child"
}

apache_server_limit() {
  # boxfile apache_server_limit
  apache_server_limit=$(nos_validate "$(nos_payload config_apache_server_limit)" "integer" "128")
  echo "$apache_server_limit"
}

apache_mod_php() {
  # boxfile apache_php_interpreter = mod_php
  apache_php_interpreter=$(nos_payload config_apache_php_interpreter)
  [[ "$apache_php_interpreter" = "mod_php" ]] && echo "true" && return
  echo "false"
}

apache_modules() {
  # boxfile apache_modules
  prefix=$(nos_payload "data_dir")
  apache_modules=$(nos_validate "$(nos_payload config_apache_modules)" "string" "")
  if [[ -z "$apache_modules" ]]; then
    echo "[]"
  else
    modules_list=(${apache_modules//,/ })
    for i in ${modules_list[@]}; do
      [[ ! -f ${prefix}/lib/httpd/mod_${i}.so ]] &
    done
    echo "[ \"$(nos_join '","' ${modules_list[@]})\" ]"
  fi
}

apache_document_root() {
  # boxfile apache_document_root
  document_root=$(nos_validate "$(nos_payload config_apache_document_root)" "folder" "$(nos_validate "$(nos_payload config_document_root)" "folder" "/")")
  if [[ ${document_root:0:1} = '/' ]]; then
    echo $document_root
  else
    echo /$document_root
  fi
}

apache_directory_index() {
  # boxfile apache_index_list
  index_list=$(nos_validate "$(nos_payload config_apache_index_list)" "string" "index.html index.php")
  for i in $index_list; do
    ignore=$(nos_validate "$i" "file" "")
  done
  echo "$index_list"
}

apache_default_gateway() {
  # boxfile apache_default_gateway
  default_gateway=$(nos_validate "$(nos_payload config_apache_default_gateway)" "file" "index.php")
  echo "$default_gateway"
}


apache_static_expire() {
  # boxfile apache_static_expire
  apache_static_expire=$(nos_validate "$(nos_payload config_apache_static_expire)" "integer" "3600")
  echo "$apache_static_expire"
}

apache_log_level() {
  # boxfile apache_log_level
  apache_log_level=$(nos_validate "$(nos_payload config_apache_log_level)" "string" "warn")
  echo "$apache_log_level"
}

apache_access_log() {
  # boxfile apache_access_log
  apache_access_log=$(nos_validate "$(nos_payload config_apache_access_log)" "boolean" "false")
  echo "$apache_access_log"
}

apache_packages() {
  apv=$(apache_version)
  pkgs=("apache-${apv}" "ap${apv//[.-]/}-cloudflare" "ap${apv//[.-]/}-xsendfile")
  
  if [[ "$(php_fpm_use_fastcgi)" = "true" ]]; then
    if [[ "${apv}" = "2.2" ]]; then
      pkgs+=("ap${apv//[.-]/}-fastcgi")
    fi
  else
    pkgs+=("ap${apv//[.-]/}-$(condensed_runtime)")
  fi
  
  echo "${pkgs[@]}"
}

generate_apache_php_fpm_script() {
  nos_template \
  "bin/start-apache-php-fpm.mustache" \
  "$(nos_data_dir)/bin/start-apache" \
  "$(apache_php_fpm_script_payload)"
  chmod 755 $(nos_data_dir)/bin/start-apache
}

apache_php_fpm_script_payload() {
  cat <<-END
{
  "data_dir": "$(nos_data_dir)"
}
END
}

generate_apache_mod_php_script() {
  nos_template \
  "bin/start-apache-mod-php.mustache" \
  "$(nos_data_dir)/bin/start-apache" \
  "$(apache_mod_php_script_payload)"
  chmod 755 $(nos_data_dir)/bin/start-apache
}

apache_mod_php_script_payload() {
  cat <<-END
{
  "data_dir": "$(nos_data_dir)",
  "etc_dir": "$(nos_etc_dir)"
}
END
}

configure_apache() {
  nos_print_bullet "Configuring Apache webserver..."
  mkdir -p $(nos_etc_dir)/httpd
  mkdir -p $(nos_data_dir)/var/log/apache
  mkdir -p $(nos_data_dir)/libexec/cgi-bin/
  mkdir -p $(nos_data_dir)/var/run
  mkdir -p $(nos_data_dir)/var/tmp
  generate_apache_conf
  if [[ "$(apache_mod_php)" = "true" ]]; then
    generate_apache_mod_php_script
  fi
  if [[ "$(php_fpm_use_fastcgi)" = "true" ]]; then
    generate_apache_php_fpm_script
  fi
}
