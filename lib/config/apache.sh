
create_apache_conf() {
  template \
    "apache/apache.conf.mustache" \
    "$(payload 'etc_dir')/httpd/httpd.conf" \
    "$(apache_conf_payload)"
}

apache_conf_payload() {
  cat <<-END
{
  "hostname": "$(hostname)",
  "deploy_dir": "$(deploy_dir)",
  "timeout": "$(timeout)",
  "max_spares": "$(max_spares)",
  "max_clients": "$(max_clients)",
  "max_requests_per_child": "$(max_requests_per_child)",
  "server_limit": "$(server_limit)",
  "port": "$(port)",
  "mod_php": $(mod_php),
  "fastcgi": $(fastcgi),
  "modules": $(modules),
  "live_dir": "$(live_dir)",
  "document_root": "$(apache_document_root)",
  "directory_index": "$(apache_directory_index)",
  "default_gateway": "$(apache_default_gateway)",
  "etc_dir": "$(etc_dir)",
  "static_expire": "$(static_expire)",
  "log_level": "$(log_level)",
  "access_log": "$(access_log)",
  "env_vars": $(env_vars),
  "domains": $(domains)
}
END
}

max_spares() {
  # boxfile apache_max_spares
  apache_max_spares=$(validate "$(payload boxfile_apache_max_spares)" "integer" "1")
  echo "$apache_max_spares"
}

max_clients() {
  # boxfile apache_max_clients
  apache_max_clients=$(validate "$(payload boxfile_apache_max_clients)" "integer" "128")
  echo "$apache_max_clients"
}

max_requests_per_child() {
  # boxfile apache_max_requests
  apache_max_requests_per_child=$(validate "$(payload boxfile_apache_max_requests_per_child)" "integer" "768")
  echo "$apache_max_requests_per_child"
}

server_limit() {
  # boxfile apache_server_limit
  apache_server_limit=$(validate "$(payload boxfile_apache_server_limit)" "integer" "128")
  echo "$apache_server_limit"
}

mod_php() {
  # boxfile apache_php_interpreter = mod_php
  apache_php_interpreter=$(payload boxfile_apache_php_interpreter)
  [[ "$apache_php_interpreter" = "mod_php" ]] && echo "true" && return
  echo "false"
}

fastcgi() {
  # boxfile apache_php_interpreter = fastcgi
  apache_php_interpreter=$(payload boxfile_apache_php_interpreter)
  [[ -z "$apache_php_interpreter" ]] && echo "true" && return
  [[ "$apache_php_interpreter" = "fpm" ]] && echo "true" && return
  echo "false"
}

modules() {
  # boxfile apache_modules
  prefix=$(payload "deploy_dir")
  default_apache_modules="authn_file,authn_dbm,authn_anon,authn_dbd,authn_default,authn_alias,authz_host,authz_groupfile,authz_user,authz_dbm,authz_owner,authnz_ldap,authz_default,auth_basic,auth_digest,isapi,file_cache,cache,disk_cache,mem_cache,dbd,bucketeer,dumpio,echo,example,case_filter,case_filter_in,reqtimeout,ext_filter,include,filter,substitute,charset_lite,ldap,log_config,log_forensic,logio,env,mime_magic,cern_meta,expires,headers,ident,usertrack,setenvif,version,proxy,proxy_connect,proxy_ftp,proxy_http,proxy_scgi,proxy_ajp,proxy_balancer,mime,dav,status,autoindex,asis,info,cgi,cgid,dav_fs,dav_lock,vhost_alias,negotiation,dir,imagemap,actions,speling,userdir,alias,rewrite,deflate,cloudflare,xsendfile"
  apache_modules=$(validate "$(payload boxfile_apache_modules)" "string" "$default_apache_modules")
  if [[ -z "$apache_modules" ]]; then
    echo "[]"
  else
    modules_list=(${apache_modules//,/ })
    for i in ${modules_list[@]}; do
      [[ ! -f ${prefix}/lib/httpd/mod_${i}.so ]] && >&2 echo "Error: Can't find file for module ${i}." && exit 1
    done
    echo "[ \"$(join '","' ${modules_list[@]})\" ]"

  fi
}

apache_document_root() {
  # boxfile apache_document_root
  document_root=$(validate "$(payload boxfile_apache_document_root)" "folder" "$(validate "$(payload boxfile_document_root)" "folder" "/")")
  if [[ ${document_root:0:1} = '/' ]]; then
    echo $document_root
  else
    echo /$document_root
  fi
}

apache_directory_index() {
  # boxfile apache_index_list
  index_list=$(validate "$(payload boxfile_apache_index_list)" "string" "index.html index.php")
  for i in $index_list; do
    ignore=$(validate "$i" "file" "")
  done
  echo "$index_list"
}

apache_default_gateway() {
  # boxfile apache_default_gateway
  default_gateway=$(validate "$(payload boxfile_apache_default_gateway)" "file" "index.php")
  echo "$default_gateway"
}


static_expire() {
  # boxfile apache_static_expire
  apache_static_expire=$(validate "$(payload boxfile_apache_static_expire)" "integer" "3600")
  echo "$apache_static_expire"
}

log_level() {
  # boxfile apache_log_level
  apache_log_level=$(validate "$(payload boxfile_apache_log_level)" "string" "warn")
  echo "$apache_log_level"
}

access_log() {
  # boxfile apache_access_log
  apache_access_log=$(validate "$(payload boxfile_apache_access_log)" "boolean" "false")
  echo "$apache_access_log"
}

