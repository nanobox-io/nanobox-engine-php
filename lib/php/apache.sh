# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

php_create_apache_conf() {
  nos_print_bullet "Generating httpd.conf"
  nos_template \
    "apache/apache.conf.mustache" \
    "$(nos_etc_dir)/httpd/httpd.conf" \
    "$(php_apache_conf_payload)"
}

php_apache_conf_payload() {
  _mod_php=$(php_apache_mod_php)
  _use_fastcgi=$(php_fpm_use_fastcgi)
  _max_spares=$(php_apache_max_spares)
  _max_clients=$(php_apache_max_clients)
  _max_requests_per_child=$(php_apache_max_requests_per_child)
  _server_limit=$(php_apache_server_limit)
  _apache_document_root=$(php_apache_document_root)
  _apache_directory_index=$(php_apache_directory_index)
  _apache_default_gateway=$(php_apache_default_gateway)
  _static_expire=$(php_apache_static_expire)
  _log_level=$(php_apache_log_level)
  _access_log=$(php_apache_access_log)
  [[ "${_mod_php}" = "true" ]] && nos_print_bullet_sub "Enabling mod_php"
  [[ "${_use_fastcgi}" = "true" ]] && nos_print_bullet_sub "Enabling FastCGI"
  nos_print_bullet_sub "Max spare servers: ${_max_spares}"
  nos_print_bullet_sub "Max clients: ${_max_clients}"
  nos_print_bullet_sub "Max requests per child: ${_max_requests_per_child}"
  nos_print_bullet_sub "Server limit: ${_server_limit}"
  nos_print_bullet_sub "Document root: ${_apache_document_root}"
  nos_print_bullet_sub "Directory index: ${_apache_directory_index}"
  nos_print_bullet_sub "Default application gateway: ${_apache_default_gateway}"
  nos_print_bullet_sub "Static expires: ${_static_expire}"
  nos_print_bullet_sub "Log level: ${_log_level}"
  nos_print_bullet_sub "Enable access log: ${_access_log}"

  cat <<-END
{
  "hostname": "$(php_hostname)",
  "deploy_dir": "$(nos_deploy_dir)",
  "timeout": "$(php_timeout)",
  "max_spares": "${_max_spares}",
  "max_clients": "${_max_clients}",
  "max_requests_per_child": "${_max_requests_per_child}",
  "server_limit": "${_server_limit}",
  "mod_php": ${_mod_php},
  "fastcgi": ${_use_fastcgi},
  "modules": $(php_apache_modules),
  "code_dir": "$(nos_code_dir)",
  "document_root": "${_apache_document_root}",
  "directory_index": "${_apache_directory_index}",
  "default_gateway": "${_apache_default_gateway}",
  "etc_dir": "$(nos_etc_dir)",
  "static_expire": "${_static_expire}",
  "log_level": "${_log_level}",
  "access_log": "${_access_log}",
  "env_vars": $(php_env_vars),
  "domains": $(php_domains)
}
END
}

php_apache_max_spares() {
  # boxfile apache_max_spares
  apache_max_spares=$(nos_validate "$(nos_payload boxfile_apache_max_spares)" "integer" "1")
  echo "$apache_max_spares"
}

php_apache_max_clients() {
  # boxfile apache_max_clients
  apache_max_clients=$(nos_validate "$(nos_payload boxfile_apache_max_clients)" "integer" "128")
  echo "$apache_max_clients"
}

php_apache_max_requests_per_child() {
  # boxfile apache_max_requests
  apache_max_requests_per_child=$(nos_validate "$(nos_payload boxfile_apache_max_requests_per_child)" "integer" "768")
  echo "$apache_max_requests_per_child"
}

php_apache_server_limit() {
  # boxfile apache_server_limit
  apache_server_limit=$(nos_validate "$(nos_payload boxfile_apache_server_limit)" "integer" "128")
  echo "$apache_server_limit"
}

php_apache_mod_php() {
  # boxfile apache_php_interpreter = mod_php
  apache_php_interpreter=$(nos_payload boxfile_apache_php_interpreter)
  [[ "$apache_php_interpreter" = "mod_php" ]] && echo "true" && return
  echo "false"
}

php_apache_modules() {
  # boxfile apache_modules
  prefix=$(nos_payload "deploy_dir")
  default_apache_modules="authn_file,authn_dbm,authn_anon,authn_dbd,authn_default,authn_alias,authz_host,authz_groupfile,authz_user,authz_dbm,authz_owner,authnz_ldap,authz_default,auth_basic,auth_digest,isapi,file_cache,cache,disk_cache,mem_cache,dbd,bucketeer,dumpio,echo,example,case_filter,case_filter_in,reqtimeout,ext_filter,include,filter,substitute,charset_lite,ldap,log_config,log_forensic,logio,env,mime_magic,cern_meta,expires,headers,ident,usertrack,setenvif,version,proxy,proxy_connect,proxy_ftp,proxy_http,proxy_scgi,proxy_ajp,proxy_balancer,mime,dav,status,autoindex,asis,info,cgi,cgid,dav_fs,dav_lock,vhost_alias,negotiation,dir,imagemap,actions,speling,userdir,alias,rewrite,deflate,cloudflare,xsendfile"
  apache_modules=$(nos_validate "$(nos_payload boxfile_apache_modules)" "string" "$default_apache_modules")
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

php_apache_document_root() {
  # boxfile apache_document_root
  document_root=$(nos_validate "$(nos_payload boxfile_apache_document_root)" "folder" "$(nos_validate "$(nos_payload boxfile_document_root)" "folder" "/")")
  if [[ ${document_root:0:1} = '/' ]]; then
    echo $document_root
  else
    echo /$document_root
  fi
}

php_apache_directory_index() {
  # boxfile apache_index_list
  index_list=$(nos_validate "$(nos_payload boxfile_apache_index_list)" "string" "index.html index.php")
  for i in $index_list; do
    ignore=$(nos_validate "$i" "file" "")
  done
  echo "$index_list"
}

php_apache_default_gateway() {
  # boxfile apache_default_gateway
  default_gateway=$(nos_validate "$(nos_payload boxfile_apache_default_gateway)" "file" "index.php")
  echo "$default_gateway"
}


php_apache_static_expire() {
  # boxfile apache_static_expire
  apache_static_expire=$(nos_validate "$(nos_payload boxfile_apache_static_expire)" "integer" "3600")
  echo "$apache_static_expire"
}

php_apache_log_level() {
  # boxfile apache_log_level
  apache_log_level=$(nos_validate "$(nos_payload boxfile_apache_log_level)" "string" "warn")
  echo "$apache_log_level"
}

php_apache_access_log() {
  # boxfile apache_access_log
  apache_access_log=$(nos_validate "$(nos_payload boxfile_apache_access_log)" "boolean" "false")
  echo "$apache_access_log"
}

php_install_apache() {
  nos_install "apache-2.2"
  nos_install "ap22-cloudflare"
  nos_install "ap22-xsendfile"
  if [[ "$(php_fpm_use_fastcgi)" = "true" ]]; then
    nos_install "ap22-fastcgi"
  else
    nos_install "ap22-$(php_condensed_runtime)"
  fi
}

php_configure_apache() {
  nos_print_process_start "Configuring Apache"
  mkdir -p $(nos_etc_dir)/httpd
  mkdir -p $(nos_deploy_dir)/var/log/apache
  mkdir -p $(nos_deploy_dir)/libexec/cgi-bin/
  mkdir -p $(nos_deploy_dir)/var/run
  mkdir -p $(nos_deploy_dir)/var/tmp
  php_create_apache_conf
}
