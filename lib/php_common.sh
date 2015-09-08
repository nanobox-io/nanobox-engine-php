#!/bin/bash

join(){
  local IFS=$'\014'
  delimeter=$1
  shift
  temp=$(echo "${*}")
  echo ${temp//$'\014'/$delimeter}
}

valid_integer(){
  [[ "$1" =~ ^[0-9]+$ ]] && return 1
  return 0
}

valid_file(){
  [[ "$1" =~ ^\/?[^\/]+(\/[^\/]+)*$ ]] && return 1
  return 0
}

valid_folder(){
  [[ "$1" =~ ^\/?[^\/]+(\/[^\/]+)*\/?$ ]] && return 1
  return 0
}

valid_boolean(){
  [[ "$1" = 'true' ]] && return 1
  [[ "$1" = 'false' ]] && return 1
  [[ "$1" =~ ^[Oo]n$ ]] && return 1
  [[ "$1" =~ ^[Oo]ff$ ]] && return 1
  [[ $1 -eq 1 ]] && return 1
  [[ $1 -eq 0 ]] && return 1
  return 0
}

valid_byte(){
  [[ "$1" =~ ^[0-9]+[BbKkMmGgTt]?$ ]] && return 1
  return 0
}

valid_string(){
  return 1
}

validate(){
  # $1 value
  # $2 type
  # $3 default
  [[ -z $1 ]] && echo $3 && return
  $(eval valid_$2 $1)
  [[ $? -eq 1 ]] && echo $1 && return
  >&2 echo "Error: value \"$1\" is invalid $2"
  exit 1
}

hostname(){
  # app.gonano.io
  echo $(payload "app").gonano.io
}

deploy_dir(){
  # payload deploy_dir
  echo $(payload "deploy_dir")
}

timeout(){
  # boxfile php_max_execution_time + boxfile php_max_input_time + 30
  php_max_execution_time=$(validate "$(payload boxfile_php_max_execution_time)" "integer" "30")
  php_max_input_time=$(validate "$(payload boxfile_php_max_input)" "integer" "60")
  echo $((php_max_execution_time + php_max_input_time + 30))
}

max_spares(){
  # boxfile httpd_max_spares
  httpd_max_spares=$(validate "$(payload boxfile_httpd_max_spares)" "integer" "1")
  echo "$httpd_max_spares"
}

max_clients(){
  # boxfile httpd_max_clients
  httpd_max_clients=$(validate "$(payload boxfile_httpd_max_clients)" "integer" "128")
  echo "$httpd_max_clients"
}

max_requests_per_child(){
  # boxfile httpd_max_requests
  httpd_max_requests_per_child=$(validate "$(payload boxfile_httpd_max_requests_per_child)" "integer" "768")
  echo "$httpd_max_requests_per_child"
}

server_limit(){
  # boxfile httpd_server_limit
  httpd_server_limit=$(validate "$(payload boxfile_httpd_server_limit)" "integer" "128")
  echo "$httpd_server_limit"
}

port(){
  # payload port
  echo $(payload "port")
}

mod_php(){
  # boxfile httpd_php_interpreter = mod_php
  httpd_php_interpreter=$(payload boxfile_httpd_php_interpreter)
  [[ "$httpd_php_interpreter" = "mod_php" ]] && echo "true" && return
  echo "false"
}

fastcgi(){
  # boxfile httpd_php_interpreter = fastcgi
  httpd_php_interpreter=$(payload boxfile_httpd_php_interpreter)
  [[ -z "$httpd_php_interpreter" ]] && echo "true" && return
  [[ "$httpd_php_interpreter" = "fastcgi" ]] && echo "true" && return
  echo "false"
}

modules(){
  # boxfile httpd_modules
  prefix=$(payload "deploy_dir")
  default_httpd_modules="authn_file,authn_dbm,authn_anon,authn_dbd,authn_default,authn_alias,authz_host,authz_groupfile,authz_user,authz_dbm,authz_owner,authnz_ldap,authz_default,auth_basic,auth_digest,isapi,file_cache,cache,disk_cache,mem_cache,dbd,bucketeer,dumpio,echo,example,case_filter,case_filter_in,reqtimeout,ext_filter,include,filter,substitute,charset_lite,ldap,log_config,log_forensic,logio,env,mime_magic,cern_meta,expires,headers,ident,usertrack,setenvif,version,proxy,proxy_connect,proxy_ftp,proxy_http,proxy_scgi,proxy_ajp,proxy_balancer,mime,dav,status,autoindex,asis,info,cgi,cgid,dav_fs,dav_lock,vhost_alias,negotiation,dir,imagemap,actions,speling,userdir,alias,rewrite,deflate,cloudflare,xsendfile"
  httpd_modules=$(validate "$(payload boxfile_httpd_modules)" "string" "$default_httpd_modules")
  if [[ -z "$httpd_modules" ]]; then
    echo "[]"
  else
    modules_list=(${httpd_modules//,/ })
    for i in ${modules_list[@]}; do
      [[ ! -f ${prefix}/lib/httpd/mod_${i}.so ]] && >&2 echo "Error: Can't find file for module ${i}." && exit 1
    done
    echo "[ \"$(join '","' ${modules_list[@]})\" ]"

  fi
}

live_dir(){
  # payload live_dir
  echo $(payload "live_dir")
}

document_root(){
  # boxfile httpd_document_root
  httpd_document_root=$(validate "$(payload boxfile_httpd_document_root)" "folder" "/")
  if [[ ${httpd_document_root:0:1} = '/' ]]; then
    echo $httpd_document_root
  else
    echo /$httpd_document_root
  fi
}

directory_index(){
  # boxfile httpd_index_list
  httpd_index_list=$(validate "$(payload boxfile_httpd_default_gateway)" "string" "index.html index.php")
  for i in $httpd_index_list; do
    ignore=$(validate "$i" "file" "")
  done
  echo "$httpd_index_list"
}

default_gateway(){
  # boxfile httpd_default_gateway
  httpd_default_gateway=$(validate "$(payload boxfile_httpd_default_gateway)" "file" "index.php")
  echo "$httpd_default_gateway"
}

etc_dir(){
  echo $(payload "etc_dir")
}

static_expire(){
  # boxfile httpd_static_expire
  httpd_static_expire=$(validate "$(payload boxfile_httpd_static_expire)" "integer" "3600")
  echo "$httpd_static_expire"
}

log_level(){
  # boxfile httpd_log_level
  httpd_log_level=$(validate "$(payload boxfile_httpd_log_level)" "string" "warn")
  echo "$httpd_log_level"
}

access_log(){
  # boxfile httpd_access_log
  httpd_access_log=$(validate "$(payload boxfile_httpd_access_log)" "boolean" "false")
  echo "$httpd_access_log"
}

env_vars(){
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

domains(){
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

events_mechanism(){
  # boxfile php_fpm_events_mechanism
  uname=$(uname)
  [[ "$uname" =~ "Linux" ]] && default=epoll
  php_fpm_events_mechanism=$(validate "$(payload php_fpm_events_mechanism)" "string" "$default")
  echo $php_fpm_events_mechanism
}

max_children(){
  # boxfile php_fpm_max_children
  php_fpm_max_children=$(validate "$(payload boxfile_php_fpm_max_children)" "integer" "20")
  echo "$php_fpm_max_children"
}

max_spare_servers(){
  # boxfile php_fpm_max_spare_servers
  php_fpm_max_spare_servers=$(validate "$(payload boxfile_php_fpm_max_spare_servers)" "integer" "1")
  echo "$php_fpm_max_spare_servers"
}

max_requests(){
  # boxfile php_fpm_max_requests
  php_fpm_max_requests=$(validate "$(payload boxfile_php_fpm_max_requests)" "integer" "128")
  echo "$php_fpm_max_requests"
}

php53(){
  # boxfile php_version = 5.3
  version=$(validate "$(payload boxfile_php_version)" "string" "5.6")
  [[ ${version} = "5.3" ]] && echo "true" && return
  echo "false"
}

short_open_tag(){
  # boxfile php_short_open_tag
  php_short_open_tag=$(validate "$(payload boxfile_php_short_open_tag)" "boolean" "On")
  echo "$php_short_open_tag"
}

zlib_output_compression(){
  # boxfile php_zlib_output_compression
  php_zlib_output_compression=$(validate "$(payload boxfile_php_zlib_output_compression)" "boolean" "Off")
  echo "$php_zlib_output_compression"
}

allow_url_fopen(){
  # boxfile php_allow_url_fopen
  php_allow_url_fopen=$(validate "$(payload boxfile_php_allow_url_fopen)" "boolean" "On")
  echo "$php_allow_url_fopen"
}

disable_functions(){
  # boxfile php_disable_functions
  php_disable_functions=$(validate "$(payload boxfile_php_disable_functions)" "string" "")
  echo "$php_disable_functions"
}

expose_php(){
  # boxfile php_expose_php
  php_expose_php=$(validate "$(payload boxfile_php_expose_php)" "boolean" "Off")
  echo "$php_expose_php"
}

max_execution_time(){
  # boxfile php_max_execution_time
  php_max_execution_time=$(validate "$(payload boxfile_php_max_execution_time)" "integer" "30")
  echo "$php_max_execution_time"
}

max_input_time(){
  # boxfile php_max_input_time
  php_max_input_time=$(validate "$(payload boxfile_php_max_input_time)" "integer" "60")
  echo "$php_max_input_time"
}

memory_limit(){
  # boxfile php_memory_limit
  php_memory_limit=$(validate "$(payload boxfile_php_memory_limit)" "byte" "512M")
  echo "$php_memory_limit"
}

error_reporting(){
  # boxfile php_error_reporting
  php_error_reporting=$(validate "$(payload boxfile_php_error_reporting)" "string" "E_ALL")
  echo "$php_error_reporting"
}

display_errors(){
  # boxfile php_display_errors
  php_display_errors=$(validate "$(payload boxfile_php_display_errors)" "boolean" "On")
  echo "$php_display_errors"
}

register_globals(){
  # boxfile php_register_globals
  php_register_globals=$(validate "$(payload boxfile_php_register_globals)" "boolean" "Off")
  echo "$php_register_globals"
}

register_argc_argv(){
  # boxfile php_register_argc_argv
  php_register_argc_argv=$(validate "$(payload boxfile_php_register_argc_argv)" "boolean" "Off")
  echo "$php_register_argc_argv"
}

post_max_size(){
  # boxfile php_post_max_size
  php_post_max_size=$(validate "$(payload boxfile_php_post_max_size)" "byte" "8M")
  echo "$php_post_max_size"
}

default_mimetype(){
  # boxfile php_default_mimetype
  php_default_mimetype=$(validate "$(payload boxfile_php_default_mimetype)" "string" "text/html")
  echo "$php_default_mimetype"
}

browscap(){
  # boxfile php_browscap
  php_browscap=$(validate "$(payload boxfile_php_browscap)" "string" "")
  echo "$php_browscap"
}

file_uploads(){
  # boxfile php_file_uploads
  php_file_uploads=$(validate "$(payload boxfile_php_file_uploads)" "boolean" "On")
  echo "$php_file_uploads"
}

max_input_vars(){
  # boxfile php_max_input_vars
  php_max_input_vars=$(validate "$(payload boxfile_php_max_input_vars)" "integer" "1000")
  echo "$php_max_input_vars"
}

upload_max_filesize(){
  # boxfile php_upload_max_filesize
  php_upload_max_filesize=$(validate "$(payload boxfile_php_upload_max_filesize)" "byte" "2M")
  echo "$php_upload_max_filesize"
}

max_file_uploads(){
  # boxfile php_max_file_uploads
  php_max_file_uploads=$(validate "$(payload boxfile_php_max_file_uploads)" "integer" "20")
  echo "$php_max_file_uploads"
}

extension_folder(){
  # folder in lib/php/???
  for i in $(payload deploy_dir)/lib/php/*; do [[ "$i" =~ /[0-9]+$ ]] && echo $i && return; done
}

extensions(){
  # boxfile php_extensions
  extension_dir=$(extension_folder)
  declare -a php_extensions_list
  if [[ "${PL_boxfile_php_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_php_extensions_length ; i++)); do
      type=PL_boxfile_php_extensions_${i}_type
      value=PL_boxfile_php_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ${extension_dir}/${!value}.so ]]; then
          php_extensions_list+=(${!value})
        else
          >&2 echo "Error: Can't find extension ${!value}"
          exit 1
        fi
      fi
    done
  else
    php_extensions_list+=("mysql")
  fi
  if [[ -z "php_extensions_list[@]" ]]; then
    echo "[]"
  else
    echo "[ \"$(join '","' ${php_extensions_list[@]})\" ]"
  fi
}

zend_extensions(){
  # boxfile php_zend_extensions
  extension_dir=$(extension_folder)
  declare -a php_zend_extensions_list
  if [[ "${PL_boxfile_php_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_php_zend_extensions_length ; i++)); do
      type=PL_boxfile_php_zend_extensions_${i}_type
      value=PL_boxfile_php_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ${extension_dir}/${!value}.so ]]; then
          php_zend_extensions_list+=(${!value})
        else
          >&2 echo "Error: Can't find extension ${!value}"
          exit 1
        fi
      fi
    done
  fi
  if [[ -z "${php_zend_extensions_list[@]}" ]]; then
    echo "[]"
  else
    echo "[ \"$(join '","' ${php_zend_extensions_list[@]})\" ]"
  fi
}

session_length(){
  # boxfile php_session_length
  php_session_length=$(validate "$(payload boxfile_php_session_length)" "integer" "3600")
  echo "$php_session_length"
}

default_locale(){
  # boxfile php_default_locale
  php_default_locale=$(validate "$(payload boxfile_php_default_locale)" "string" "")
  echo "$php_default_locale"
}

session_autostart(){
  # boxfile php_session_autostart
  php_session_autostart=$(validate "$(payload boxfile_php_session_autostart)" "boolean" "Off")
  echo "$php_session_autostart"
}

session_save_path(){
  # boxfile php_session_save_path
  php_session_save_path=$(validate "$(payload boxfile_php_session_save_path)" "string" "/var/php/sessions")
  echo "$php_session_save_path"
}

session_save_handler(){
  # boxfile php_session_save_handler
  php_session_save_handler=$(validate "$(payload boxfile_php_session_save_handler)" "string" "files")
  echo "$php_session_save_handler"
}

date_timezone(){
  # boxfile php_date_timezone
  php_date_timezone=$(validate "$(payload boxfile_php_date_timezone)" "string" "Etc/UTC")
  echo "$php_date_timezone"
}

iconv_internal_encoding(){
  # boxfile php_iconv_internal_encoding
  php_iconv_internal_encoding=$(validate "$(payload boxfile_php_iconv_internal_encoding)" "string" "UTF-8")
  echo "$php_iconv_internal_encoding"
}

apc_shm_size(){
  # boxfile php_apc_shm_size
  php_apc_shm_size=$(validate "$(payload boxfile_php_apc_shm_size)" "byte" "128M")
  echo "$php_apc_shm_size"
}

apc_num_files_hint(){
  # boxfile php_apc_num_files_hint
  php_apc_num_files_hint=$(validate "$(payload boxfile_php_apc_num_files_hint)" "integer" "0")
  echo "$php_apc_num_files_hint"
}

apc_user_entries_hint(){
  # boxfile php_apc_user_entries_hint
  php_apc_user_entries_hint=$(validate "$(payload boxfile_php_apc_user_entries_hint)" "integer" "0")
  echo "$php_apc_user_entries_hint"
}

apc_filters(){
  # boxfile php_apc_filters
  php_apc_filters=$(validate "$(payload boxfile_php_apc_filters)" "string" "")
  echo "$php_apc_filters"
}

eaccelerator_shm_max(){
  # boxfile php_eaccelerator_shm_max
  php_eaccelerator_shm_max=$(validate "$(payload boxfile_php_eaccelerator_shm_max)" "integer" "128")
  echo "$php_eaccelerator_shm_max"
}

eaccelerator_shm_size(){
  # boxfile php_eaccelerator_shm_size
  php_eaccelerator_shm_size=$(validate "$(payload boxfile_php_eaccelerator_shm_size)" "integer" "128")
  echo "$php_eaccelerator_shm_size"
}

eaccelerator_filter(){
  # boxfile php_eaccelerator_filter
  php_eaccelerator_filter=$(validate "$(payload boxfile_php_eaccelerator_filter)" "string" "")
  echo "$php_eaccelerator_filter"
}

geoip_custom_directory(){
  # boxfile php_geoip_custom_directory
  php_geoip_custom_directory=$(validate "$(payload boxfile_php_geoip_custom_directory)" "folder" "")
  echo "$php_geoip_custom_directory"
}

memcache_chunk_size(){
  # boxfile php_memcache_chunk_size
  php_memcache_chunk_size=$(validate "$(payload boxfile_php_memcache_chunk_size)" "integer" "32768")
  echo "$php_memcache_chunk_size"
}

memcache_hash_strategy(){
  # boxfile php_memcache_hash_strategy
  php_memcache_hash_strategy=$(validate "$(payload boxfile_php_memcache_hash_strategy)" "string" "standard")
  echo "$php_memcache_hash_strategy"
}

mongo_native_long(){
  # boxfile php_mongo_native_long
  php_mongo_native_long=$(validate "$(payload boxfile_php_mongo_native_long)" "integer" "1")
  echo "$php_mongo_native_long"
}

mongo_allow_empty_keys(){
  # boxfile php_mongo_allow_empty_keys
  php_mongo_allow_empty_keys=$(validate "$(payload boxfile_php_mongo_allow_empty_keys)" "integer" "0")
  echo "$php_mongo_allow_empty_keys"
}

mongo_cmd(){
  # boxfile php_mongo_cmd
  php_mongo_cmd=$(validate "$(payload boxfile_php_mongo_cmd)" "string" "\$")
  echo "$php_mongo_cmd"
}

mongo_long_as_object(){
  # boxfile php_mongo_long_as_object
  php_mongo_long_as_object=$(validate "$(payload boxfile_php_mongo_long_as_object)" "integer" "0")
  echo "$php_mongo_long_as_object"
}

app_name(){
  # payload app
  echo "$(payload app)"
}

newrelic_license(){
  # payload newrelic_license
  echo "$(payload newrelic_license)"
}

newrelic_capture_params(){
  # boxfile php_newrelic_capture_params
  php_newrelic_capture_params=$(validate "$(payload boxfile_php_newrelic_capture_params)" "boolean" "Off")
  echo "$php_newrelic_capture_params"
}

newrelic_ignored_params(){
  # boxfile php_newrelic_ignored_params
  php_newrelic_ignored_params=$(validate "$(payload boxfile_php_newrelic_ignored_params)" "string" "")
  echo "$php_newrelic_ignored_params"
}

newrelic_loglevel(){
  # boxfile php_newrelic_loglevel
  php_newrelic_loglevel=$(validate "$(payload boxfile_php_newrelic_loglevel)" "string" "info")
  [[ "$php_newrelic_loglevel" = 'error' ]] && echo "$php_newrelic_loglevel" && return
  [[ "$php_newrelic_loglevel" = 'warning' ]] && echo "$php_newrelic_loglevel" && return
  [[ "$php_newrelic_loglevel" = 'info' ]] && echo "$php_newrelic_loglevel" && return
  [[ "$php_newrelic_loglevel" = 'verbose' ]] && echo "$php_newrelic_loglevel" && return
  [[ "$php_newrelic_loglevel" = 'debug' ]] && echo "$php_newrelic_loglevel" && return
  [[ "$php_newrelic_loglevel" = 'verbosedebug' ]] && echo "$php_newrelic_loglevel" && return
  >&2 echo "Error: Invalid Newrelic Log Level \"$php_newrelic_loglevel\""
  exit 1
}

newrelic_framework(){
  # boxfile php_newrelic_framework
  php_newrelic_framework=$(validate "$(payload boxfile_php_newrelic_framework)" "string" "")
  echo "$php_newrelic_framework"
}

newrelic_browser_monitoring_auto_instrument(){
  # boxfile php_newrelic_browser_monitoring_auto_instrument
  php_newrelic_browser_monitoring_auto_instrument=$(validate "$(payload boxfile_php_newrelic_browser_monitoring_auto_instrument)" "boolean" "On")
  echo "$php_newrelic_browser_monitoring_auto_instrument"
}

newrelic_framework_drupal_modules(){
  # boxfile php_newrelic_framework_drupal_modules
  php_newrelic_framework_drupal_modules=$(validate "$(payload boxfile_php_newrelic_framework_drupal_modules)" "boolean" "On")
  echo "$php_newrelic_framework_drupal_modules"
}

newrelic_transaction_tracer_detail(){
  # boxfile php_newrelic_transaction_tracer_detail
  php_newrelic_transaction_tracer_detail=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_detail)" "integer" "1")
  echo "$php_newrelic_transaction_tracer_detail"
}

newrelic_transaction_tracer_enabled(){
  # boxfile php_newrelic_transaction_tracer_enabled
  php_newrelic_transaction_tracer_enabled=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_enabled)" "boolean" "On")
  echo "$php_newrelic_transaction_tracer_enabled"
}

newrelic_transaction_tracer_record_sql(){
  # boxfile php_newrelic_transaction_tracer_record_sql
  php_newrelic_transaction_tracer_record_sql=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_record_sql)" "string" "obfuscated")
  [[ "$php_newrelic_transaction_tracer_record_sql" = "off" ]] && echo "$php_newrelic_transaction_tracer_record_sql" && return
  [[ "$php_newrelic_transaction_tracer_record_sql" = "raw" ]] && echo "$php_newrelic_transaction_tracer_record_sql" && return
  [[ "$php_newrelic_transaction_tracer_record_sql" = "obfuscated" ]] && echo "$php_newrelic_transaction_tracer_record_sql" && return
  >&2 echo "Error: Invalid Newrelic transaction tracer record sql value \"$php_newrelic_transaction_tracer_record_sql\""
  exit 1
}

newrelic_transaction_tracer_threshold(){
  # boxfile php_newrelic_transaction_tracer_threshold
  php_newrelic_transaction_tracer_threshold=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_threshold)" "string" "apdex_f")
  echo "$php_newrelic_transaction_tracer_threshold"
}

newrelic_transaction_tracer_stack_trace_threshold(){
  # boxfile php_newrelic_transaction_tracer_stack_trace_threshold
  php_newrelic_transaction_tracer_stack_trace_threshold=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_stack_trace_threshold)" "integer" "500")
  echo "$php_newrelic_transaction_tracer_stack_trace_threshold"
}

newrelic_transaction_tracer_explain_threshold(){
  # boxfile php_newrelic_transaction_tracer_explain_threshold
  php_newrelic_transaction_tracer_explain_threshold=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_explain_threshold)" "integer" "500")
  echo "$php_newrelic_transaction_tracer_explain_threshold"
}

newrelic_transaction_tracer_slow_sql(){
  # boxfile php_newrelic_transaction_tracer_slow_sql
  php_newrelic_transaction_tracer_slow_sql=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_slow_sql)" "boolean" "On")
  echo "$php_newrelic_transaction_tracer_slow_sql"
}

newrelic_transaction_tracer_custom(){
  # boxfile php_newrelic_transaction_tracer_custom
  php_newrelic_transaction_tracer_custom=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_custom)" "string" "")
  echo "$php_newrelic_transaction_tracer_custom"
}

newrelic_error_collector_enabled(){
  # boxfile php_newrelic_error_collector_enabled
  php_newrelic_error_collector_enabled=$(validate "$(payload boxfile_php_newrelic_error_collector_enabled)" "boolean" "On")
  echo "$php_newrelic_error_collector_enabled"
}

newrelic_error_collector_record_database_errors(){
  # boxfile php_newrelic_error_collector_record_database_errors
  php_newrelic_error_collector_record_database_errors=$(validate "$(payload boxfile_php_newrelic_error_collector_record_database_errors)" "boolean" "On")
  echo "$php_newrelic_error_collector_record_database_errors"
}

newrelic_webtransaction_name_functions(){
  # boxfile php_newrelic_webtransaction_name_functions
  php_newrelic_webtransaction_name_functions=$(validate "$(payload boxfile_php_newrelic_webtransaction_name_functions)" "string" "")
  echo "$php_newrelic_webtransaction_name_functions"
}

newrelic_webtransaction_name_files(){
  # boxfile php_newrelic_webtransaction_name_files
  php_newrelic_webtransaction_name_files=$(validate "$(payload boxfile_php_newrelic_webtransaction_name_files)" "string" "")
  echo "$php_newrelic_webtransaction_name_files"
}

newrelic_webtransaction_name_remove_trailing_path(){
  # boxfile php_newrelic_webtransaction_name_remove_trailing_path
  php_newrelic_webtransaction_name_remove_trailing_path=$(validate "$(payload boxfile_php_newrelic_webtransaction_name_remove_trailing_path)" "boolean" "Off")
  echo "$php_newrelic_webtransaction_name_remove_trailing_path"
}

opcache_memory_consumption(){
  # boxfile php_opcache_memory_consumption
  php_opcache_memory_consumption=$(validate "$(payload boxfile_php_opcache_memory_consumption)" "integer" "128")
  echo "$php_opcache_memory_consumption"
}

opcache_validate_timestamps(){
  # boxfile php_opcache_validate_timestamps
  php_opcache_validate_timestamps=$(validate "$(payload boxfile_php_opcache_validate_timestamps)" "boolean" "0")
  echo "$php_opcache_validate_timestamps"
}

opcache_revalidate_freq(){
  # boxfile php_opcache_revalidate_freq
  php_opcache_revalidate_freq=$(validate "$(payload boxfile_php_opcache_revalidate_freq)" "integer" "0")
  echo "$php_opcache_revalidate_freq"
}

opcache_revalidate_path(){
  # boxfile php_opcache_revalidate_path
  php_opcache_revalidate_path=$(validate "$(payload boxfile_php_opcache_revalidate_path)" "integer" "0")
  echo "$php_opcache_revalidate_path"
}

opcache_save_comments(){
  # boxfile php_opcache_save_comments
  php_opcache_save_comments=$(validate "$(payload boxfile_php_opcache_save_comments)" "boolean" "1")
  echo "$php_opcache_save_comments"
}

opcache_load_comments(){
  # boxfile php_opcache_load_comments
  php_opcache_load_comments=$(validate "$(payload boxfile_php_opcache_load_comments)" "boolean" "1")
  echo "$php_opcache_load_comments"
}

opcache_enable_file_override(){
  # boxfile php_opcache_enable_file_override
  php_opcache_enable_file_override=$(validate "$(payload boxfile_php_opcache_enable_file_override)" "boolean" "0")
  echo "$php_opcache_enable_file_override"
}

opcache_optimization_level(){
  # boxfile php_opcache_optimization_level
  php_opcache_optimization_level=$(validate "$(payload boxfile_php_opcache_optimization_level)" "string" "0xffffffff")
  echo "$php_opcache_optimization_level"
}

opcache_dups_fix(){
  # boxfile php_opcache_dups_fix
  php_opcache_dups_fix=$(validate "$(payload boxfile_php_opcache_dups_fix)" "boolean" "0")
  echo "$php_opcache_dups_fix"
}

opcache_blacklist_filename(){
  # boxfile php_opcache_blacklist_filename
  php_opcache_blacklist_filename=$(validate "$(payload boxfile_php_opcache_blacklist_filename)" "string" "")
  echo "$php_opcache_blacklist_filename"
}

xcache_size(){
  # boxfile php_xcache_size
  php_xcache_size=$(validate "$(payload boxfile_php_xcache_size)" "byte" "64M")
  echo "$php_xcache_size"
}

xcache_var_size(){
  # boxfile php_xcache_var_size
  php_xcache_var_size=$(validate "$(payload boxfile_php_xcache_var_size)" "byte" "64M")
  echo "$php_xcache_var_size"
}

xcache_admin_user(){
  # boxfile php_xcache_admin_user
  php_xcache_admin_user=$(validate "$(payload boxfile_php_xcache_admin_user)" "string" "")
  echo "$php_xcache_admin_user"
}

xcache_admin_pass(){
  # boxfile php_xcache_admin_pass
  php_xcache_admin_pass=$(validate "$(payload boxfile_php_xcache_admin_pass)" "string" "e0817d5307b3e779a428ea10b50f4441")
  echo "$php_xcache_admin_pass"
}

generate_apache_conf_json(){
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
  "document_root": "$(document_root)",
  "directory_index": "$(directory_index)",
  "default_gateway": "$(default_gateway)",
  "etc_dir": "$(etc_dir)",
  "static_expire": "$(static_expire)",
  "log_level": "$(log_level)",
  "access_log": "$(access_log)",
  "env_vars": $(env_vars),
  "domains": $(domains)
}
END
}

generate_php_fpm_conf_json(){
  cat <<-END
{
  "deploy_dir": "$(deploy_dir)",
  "events_mechanism": "$(events_mechanism)",
  "max_children": "$(max_children)",
  "max_spare_servers": "$(max_spare_servers)",
  "max_requests": "$(max_requests)",
  "php53": "$(php53)"
}
END
}

generate_php_ini_json(){
  cat <<-END
{
  "short_open_tag": "$(short_open_tag)",
  "zlib_output_compression": "$(zlib_output_compression)",
  "allow_url_fopen": "$(allow_url_fopen)",
  "disable_functions": "$(disable_functions)",
  "expose_php": "$(expose_php)",
  "max_execution_time": "$(max_execution_time)",
  "max_input_time": "$(max_input_time)",
  "memory_limit": "$(memory_limit)",
  "error_reporting": "$(error_reporting)",
  "display_errors": "$(display_errors)",
  "register_globals": "$(register_globals)",
  "register_argc_argv": "$(register_argc_argv)",
  "post_max_size": "$(post_max_size)",
  "default_mimetype": "$(default_mimetype)",
  "live_dir": "$(live_dir)",
  "browscap": "$(browscap)",
  "file_uploads": "$(file_uploads)",
  "max_input_vars": "$(max_input_vars)",
  "upload_max_filesize": "$(upload_max_filesize)",
  "max_file_uploads": "$(max_file_uploads)",
  "extensions": $(extensions),
  "zend_extensions": $(zend_extensions),
  "extension_folder": "$(extension_folder)",
  "session_length": "$(session_length)",
  "default_locale": "$(default_locale)",
  "session_autostart": "$(session_autostart)",
  "session_save_path": "$(session_save_path)",
  "session_save_handler": "$(session_save_handler)",
  "date_timezone": "$(date_timezone)",
  "iconv_internal_encoding": "$(iconv_internal_encoding)"
}
END
}

generate_php_apc_ini_json(){
  cat <<-END
{
  "apc_shm_size": "$(apc_shm_size)",
  "apc_num_files_hint": "$(apc_num_files_hint)",
  "apc_user_entries_hint": "$(apc_user_entries_hint)",
  "apc_filters": "$(apc_filters)"
}
END
}

generate_php_eaccelerator_ini_json(){
  cat <<-END
{
  "eaccelerator_shm_max": "$(eaccelerator_shm_max)",
  "eaccelerator_shm_size": "$(eaccelerator_shm_size)",
  "eaccelerator_filter": "$(eaccelerator_filter)"
}
END
}

generate_php_geoip_ini_json(){
  cat <<-END
{
  "geoip_custom_directory": "$(geoip_custom_directory)"
}
END
}

generate_php_memcache_ini_json(){
  cat <<-END
{
  "memcache_chunk_size": "$(memcache_chunk_size)",
  "memcache_hash_strategy": "$(memcache_hash_strategy)"
}
END
}

generate_php_mongo_ini_json(){
  cat <<-END
{
  "mongo_native_long": "$(mongo_native_long)",
  "mongo_allow_empty_keys": "$(mongo_allow_empty_keys)",
  "mongo_cmd": "$(mongo_cmd)",
  "mongo_long_as_object": "$(mongo_long_as_object)"
}
END
}

generate_php_newrelic_ini_json(){
  cat <<-END
{
  "app_name": "$(app_name)",
  "newrelic_license": "$(newrelic_license)",
  "newrelic_capture_params": "$(newrelic_capture_params)",
  "newrelic_ignored_params": "$(newrelic_ignored_params)",
  "newrelic_loglevel": "$(newrelic_loglevel)",
  "newrelic_framework": "$(newrelic_framework)",
  "newrelic_browser_monitoring_auto_instrument": "$(newrelic_browser_monitoring_auto_instrument)",
  "newrelic_framework_drupal_modules": "$(newrelic_framework_drupal_modules)",
  "newrelic_transaction_tracer_detail": "$(newrelic_transaction_tracer_detail)",
  "newrelic_transaction_tracer_enabled": "$(newrelic_transaction_tracer_enabled)",
  "newrelic_transaction_tracer_record_sql": "$(newrelic_transaction_tracer_record_sql)",
  "newrelic_transaction_tracer_threshold": "$(newrelic_transaction_tracer_threshold)",
  "newrelic_transaction_tracer_stack_trace_threshold": "$(newrelic_transaction_tracer_stack_trace_threshold)",
  "newrelic_transaction_tracer_explain_threshold": "$(newrelic_transaction_tracer_explain_threshold)",
  "newrelic_transaction_tracer_slow_sql": "$(newrelic_transaction_tracer_slow_sql)",
  "newrelic_transaction_tracer_custom": "$(newrelic_transaction_tracer_custom)",
  "newrelic_error_collector_enabled": "$(newrelic_error_collector_enabled)",
  "newrelic_error_collector_record_database_errors": "$(newrelic_error_collector_record_database_errors)",
  "newrelic_webtransaction_name_functions": "$(newrelic_webtransaction_name_functions)",
  "newrelic_webtransaction_name_files": "$(newrelic_webtransaction_name_files)",
  "newrelic_webtransaction_name_remove_trailing_path": "$(newrelic_webtransaction_name_remove_trailing_path)"
}
END
}

generate_php_opcache_ini_json(){
  cat <<-END
{
  "opcache_memory_consumption": "$(opcache_memory_consumption)",
  "opcache_validate_timestamps": "$(opcache_validate_timestamps)",
  "opcache_revalidate_freq": "$(opcache_revalidate_freq)",
  "opcache_revalidate_path": "$(opcache_revalidate_path)",
  "opcache_save_comments": "$(opcache_save_comments)",
  "opcache_load_comments": "$(opcache_load_comments)",
  "opcache_enable_file_override": "$(opcache_enable_file_override)",
  "opcache_optimization_level": "$(opcache_optimization_level)",
  "opcache_dups_fix": "$(opcache_dups_fix)",
  "opcache_blacklist_filename": "$(opcache_blacklist_filename)"
}
END
}

generate_php_xcache_ini_json(){
  cat <<-END
{
  "xcache_size": "$(xcache_size)",
  "xcache_var_size": "$(xcache_var_size)",
  "xcache_admin_user": "$(xcache_admin_user)",
  "xcache_admin_pass": "$(xcache_admin_pass)"
}
END
}

create_apache_conf(){
  template \
    "apache/apache.conf.mustache" \
    "$(payload 'deploy_dir')/etc/httpd/httpd.conf" \
    "$(generate_apache_conf_json)"
}

create_php_fpm_conf(){
  template \
    "php/php-fpm.conf.mustache" \
    "$(payload 'deploy_dir')/etc/php/php-fpm.conf" \
    "$(generate_php_fpm_conf_json)"
}

create_php_ini(){
  template \
    "php/php.ini.mustache" \
    "$(payload 'deploy_dir')/etc/php/php.ini" \
    "$(generate_php_ini_json)"
}

create_php_apc_ini(){
  template \
    "php/php.d/apc.ini.mustache" \
    "$(payload 'deploy_dir')/etc/php.d/apc.ini" \
    "$(generate_php_apc_ini_json)"
}

create_php_eaccelerator_ini(){
  template \
    "php/php.d/eaccelerator.ini.mustache" \
    "$(payload 'deploy_dir')/etc/php.d/eaccelerator.ini" \
    "$(generate_php_eaccelerator_ini_json)"
}

create_php_geoip_ini(){
  template \
    "php/php.d/geoip.ini.mustache" \
    "$(payload 'deploy_dir')/etc/php.d/geoip.ini" \
    "$(generate_php_geoip_ini_json)"
}

create_php_memcache_ini(){
  template \
    "php/php.d/memcache.ini.mustache" \
    "$(payload 'deploy_dir')/etc/php.d/memcache.ini" \
    "$(generate_php_memcache_ini_json)"
}

create_php_mongo_ini(){
  template \
    "php/php.d/mongo.ini.mustache" \
    "$(payload 'deploy_dir')/etc/php.d/mongo.ini" \
    "$(generate_php_mongo_ini_json)"
}

create_php_newrelic_ini(){
  template \
    "php/php.d/newrelic.ini.mustache" \
    "$(payload 'deploy_dir')/etc/php.d/newrelic.ini" \
    "$(generate_php_newrelic_ini_json)"
}

create_php_opcache_ini(){
  template \
    "php/php.d/opcache.ini.mustache" \
    "$(payload 'deploy_dir')/etc/php.d/opcache.ini" \
    "$(generate_php_opcache_ini_json)"
}

create_php_xcache_ini(){
  template \
    "php/php.d/xcache.ini.mustache" \
    "$(payload 'deploy_dir')/etc/php.d/xcache.ini" \
    "$(generate_php_xcache_ini_json)"
}
