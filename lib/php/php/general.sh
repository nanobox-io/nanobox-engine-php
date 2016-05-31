# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_php_ini() {
  nos_print_bullet "Generating php.ini"
  nos_template \
    "php/php.ini.mustache" \
    "$(nos_etc_dir)/php/php.ini" \
    "$(php_ini_payload)"
}

php_ini_payload() {
  _short_open_tag=$(short_open_tag)
  _zlib_output_compression=$(zlib_output_compression)
  _allow_url_fopen=$(allow_url_fopen)
  _disable_functions=$(disable_functions)
  _expose_php=$(expose_php)
  _max_execution_time=$(max_execution_time)
  _max_input_time=$(max_input_time)
  _memory_limit=$(memory_limit)
  _error_reporting=$(error_reporting)
  _display_errors=$(display_errors)
  _register_globals=$(register_globals)
  _register_argc_argv=$(register_argc_argv)
  _post_max_size=$(post_max_size)
  _default_mimetype=$(default_mimetype)
  _browscap=$(browscap)
  _file_uploads=$(file_uploads)
  _max_input_vars=$(max_input_vars)
  _upload_max_filesize=$(upload_max_filesize)
  _max_file_uploads=$(max_file_uploads)
  _session_length=$(session_length)
  _default_locale=$(default_locale)
  _session_autostart=$(session_autostart)
  _session_save_path=$(session_save_path)
  _session_save_handler=$(session_save_handler)
  _date_timezone=$(date_timezone)
  _iconv_internal_encoding=$(iconv_internal_encoding)
  nos_print_bullet_sub "Short open tag: ${_short_open_tag}"
  nos_print_bullet_sub "zlib output compressiong: ${_zlib_output_compression}"
  nos_print_bullet_sub "Allow url fopen: ${_allow_url_fopen}"
  nos_print_bullet_sub "Disable functions: ${_disable_functions}"
  nos_print_bullet_sub "Expose php: ${_expose_php}"
  nos_print_bullet_sub "Max execution time: ${_max_execution_time}"
  nos_print_bullet_sub "Max input time: ${_max_input_time}"
  nos_print_bullet_sub "Memory limit: ${_memory_limit}"
  nos_print_bullet_sub "Error reporting: ${_error_reporting}"
  nos_print_bullet_sub "Display errors: ${_display_errors}"
  nos_print_bullet_sub "Register globals: ${_register_globals}"
  nos_print_bullet_sub "Register argc argv: ${_register_argc_argv}"
  nos_print_bullet_sub "Post max size: ${_post_max_size}"
  nos_print_bullet_sub "Default mimetype: ${_default_mimetype}"
  nos_print_bullet_sub "Browscap: ${_browscap}"
  nos_print_bullet_sub "File uploads: ${_file_uploads}"
  nos_print_bullet_sub "Max input vars: ${_max_input_vars}"
  nos_print_bullet_sub "Upload max filesize: ${_upload_max_filesize}"
  nos_print_bullet_sub "Max file uploads: ${_max_file_uploads}"
  nos_print_bullet_sub "Session length: ${_session_length}"
  nos_print_bullet_sub "Default locale: ${_default_locale}"
  nos_print_bullet_sub "Session autostart: ${_session_autostart}"
  nos_print_bullet_sub "Session save path: ${_session_save_path}"
  nos_print_bullet_sub "Session save handler: ${_session_save_handler}"
  nos_print_bullet_sub "Date timezone: ${_date_timezone}"
  nos_print_bullet_sub "Iconv internal encoding: ${_iconv_internal_encoding}"
  cat <<-END
{
  "short_open_tag": "${_short_open_tag}",
  "zlib_output_compression": "${_zlib_output_compression}",
  "allow_url_fopen": "${_allow_url_fopen}",
  "disable_functions": "${_disable_functions}",
  "expose_php": "${_expose_php}",
  "max_execution_time": "${_max_execution_time}",
  "max_input_time": "${_max_input_time}",
  "memory_limit": "${_memory_limit}",
  "error_reporting": "${_error_reporting}",
  "display_errors": "${_display_errors}",
  "register_globals": "${_register_globals}",
  "register_argc_argv": "${_register_argc_argv}",
  "post_max_size": "${_post_max_size}",
  "default_mimetype": "${_default_mimetype}",
  "live_dir": "$(nos_live_dir)",
  "deploy_dir": "$(nos_deploy_dir)",
  "browscap": ${_browscap},
  "file_uploads": "${_file_uploads}",
  "max_input_vars": "${_max_input_vars}",
  "upload_max_filesize": "${_upload_max_filesize}",
  "max_file_uploads": "${_max_file_uploads}",
  "extensions": $(extensions),
  "zend_extensions": $(zend_extensions),
  "extension_dir": "$(extension_dir)",
  "session_length": "${_session_length}",
  "default_locale": "${_default_locale}",
  "session_autostart": "${_session_autostart}",
  "session_save_path": "${_session_save_path}",
  "session_save_handler": "${_session_save_handler}",
  "date_timezone": "${_date_timezone}",
  "iconv_internal_encoding": "${_iconv_internal_encoding}"
}
END
}

php53() {
  # boxfile php_version = 5.3
  version=$(nos_validate "$(nos_payload boxfile_version)" "string" "5.6")
  [[ ${version} = "5.3" ]] && echo "true" && return
  echo "false"
}

iconv_internal_encoding() {
  # boxfile php_iconv_internal_encoding
  _iconv_internal_encoding=$(nos_validate "$(nos_payload boxfile_iconv_internal_encoding)" "string" "UTF-8")
  echo "$_iconv_internal_encoding"
}

timeout() {
  # boxfile max_execution_time + boxfile max_input_time + 30
  _max_execution_time=$(nos_validate "$(nos_payload boxfile_max_execution_time)" "integer" "30")
  _max_input_time=$(nos_validate "$(nos_payload boxfile_max_input)" "integer" "60")
  echo $((_max_execution_time + _max_input_time + 30))
}

short_open_tag() {
  # boxfile short_open_tag
  _short_open_tag=$(nos_validate "$(nos_payload boxfile_short_open_tag)" "boolean" "On")
  echo "$_short_open_tag"
}

zlib_output_compression() {
  # boxfile zlib_output_compression
  _zlib_output_compression=$(nos_validate "$(nos_payload boxfile_zlib_output_compression)" "boolean" "Off")
  echo "$_zlib_output_compression"
}

allow_url_fopen() {
  # boxfile allow_url_fopen
  _allow_url_fopen=$(nos_validate "$(nos_payload boxfile_allow_url_fopen)" "boolean" "On")
  echo "$_allow_url_fopen"
}

disable_functions() {
  # boxfile disable_functions
  _disable_functions=$(nos_validate "$(nos_payload boxfile_disable_functions)" "string" "")
  echo "$_disable_functions"
}

expose_php() {
  # boxfile expose_php
  _expose_php=$(nos_validate "$(nos_payload boxfile_expose_php)" "boolean" "Off")
  echo "$_expose_php"
}

max_execution_time() {
  # boxfile max_execution_time
  _max_execution_time=$(nos_validate "$(nos_payload boxfile_max_execution_time)" "integer" "30")
  echo "$_max_execution_time"
}

max_input_time() {
  # boxfile max_input_time
  _max_input_time=$(nos_validate "$(nos_payload boxfile_max_input_time)" "integer" "60")
  echo "$_max_input_time"
}

memory_limit() {
  # boxfile memory_limit
  _memory_limit=$(nos_validate "$(nos_payload boxfile_memory_limit)" "byte" "512M")
  echo "$_memory_limit"
}

error_reporting() {
  # boxfile error_reporting
  _error_reporting=$(nos_validate "$(nos_payload boxfile_error_reporting)" "string" "E_ALL")
  echo "$_error_reporting"
}

display_errors() {
  # boxfile display_errors
  _display_errors=$(nos_validate "$(nos_payload boxfile_display_errors)" "boolean" "On")
  echo "$_display_errors"
}

register_globals() {
  # boxfile register_globals
  _register_globals=$(nos_validate "$(nos_payload boxfile_register_globals)" "boolean" "Off")
  echo "$_register_globals"
}

register_argc_argv() {
  # boxfile register_argc_argv
  _register_argc_argv=$(nos_validate "$(nos_payload boxfile_register_argc_argv)" "boolean" "Off")
  echo "$_register_argc_argv"
}

post_max_size() {
  # boxfile post_max_size
  _post_max_size=$(nos_validate "$(nos_payload boxfile_post_max_size)" "byte" "8M")
  echo "$_post_max_size"
}

default_mimetype() {
  # boxfile default_mimetype
  _default_mimetype=$(nos_validate "$(nos_payload boxfile_default_mimetype)" "string" "text/html")
  echo "$_default_mimetype"
}

browscap() {
  # boxfile browscap
  _browscap=$(nos_validate "$(nos_payload boxfile_browscap)" "string" "")
  if [[ -z "${_browscap}" ]]; then
    echo "false"
  else
    echo "\"$_browscap\""
  fi
}

file_uploads() {
  # boxfile file_uploads
  _file_uploads=$(nos_validate "$(nos_payload boxfile_file_uploads)" "boolean" "On")
  echo "$_file_uploads"
}

max_input_vars() {
  # boxfile max_input_vars
  _max_input_vars=$(nos_validate "$(nos_payload boxfile_max_input_vars)" "integer" "1000")
  echo "$_max_input_vars"
}

upload_max_filesize() {
  # boxfile upload_max_filesize
  _upload_max_filesize=$(nos_validate "$(nos_payload boxfile_upload_max_filesize)" "byte" "2M")
  echo "$_upload_max_filesize"
}

max_file_uploads() {
  # boxfile max_file_uploads
  _max_file_uploads=$(nos_validate "$(nos_payload boxfile_max_file_uploads)" "integer" "20")
  echo "$_max_file_uploads"
}

extension_dir() {
  # folder in lib/php/???
  for i in $(nos_deploy_dir)/lib/php/*; do [[ "$i" =~ /[0-9]+$ ]] && echo $i && return; done
}

extensions() {
  # boxfile extensions
  extension_dir=$(extension_dir)
  declare -a extensions_list
  if [[ "${PL_boxfile_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_extensions_length ; i++)); do
      type=PL_boxfile_extensions_${i}_type
      value=PL_boxfile_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ${extension_dir}/${!value}.so ]]; then
          extensions_list+=(${!value})
        else
          exit 1
        fi
      fi
    done
  else
    extensions_list+=("mysql")
  fi
  if [[ -z "extensions_list[@]" ]]; then
    echo "[]"
  else
    echo "[ \"$(nos_join '","' ${extensions_list[@]})\" ]"
  fi
}

zend_extensions() {
  # boxfile zend_extensions
  extension_dir=$(extension_dir)
  declare -a zend_extensions_list
  if [[ "${PL_boxfile_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_zend_extensions_length ; i++)); do
      type=PL_boxfile_zend_extensions_${i}_type
      value=PL_boxfile_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ${extension_dir}/${!value}.so ]]; then
          zend_extensions_list+=(${!value})
        else
          exit 1
        fi
      fi
    done
  fi
  if [[ -z "${zend_extensions_list[@]}" ]]; then
    echo "[]"
  else
    echo "[ \"$(nos_join '","' ${zend_extensions_list[@]})\" ]"
  fi
}

session_length() {
  # boxfile session_length
  _session_length=$(nos_validate "$(nos_payload boxfile_session_length)" "integer" "3600")
  echo "$_session_length"
}

default_locale() {
  # boxfile default_locale
  _default_locale=$(nos_validate "$(nos_payload boxfile_default_locale)" "string" "")
  echo "$_default_locale"
}

session_autostart() {
  # boxfile session_autostart
  _session_autostart=$(nos_validate "$(nos_payload boxfile_session_autostart)" "boolean" "Off")
  echo "$_session_autostart"
}

session_save_path() {
  # boxfile session_save_path
  _session_save_path=$(nos_validate "$(nos_payload boxfile_session_save_path)" "string" "$(nos_deploy_dir)/var/php/sessions")
  echo "$_session_save_path"
}

session_save_handler() {
  # boxfile session_save_handler
  _session_save_handler=$(nos_validate "$(nos_payload boxfile_session_save_handler)" "string" "files")
  echo "$_session_save_handler"
}

date_timezone() {
  # boxfile date_timezone
  _date_timezone=$(nos_validate "$(nos_payload boxfile_date_timezone)" "string" "Etc/UTC")
  echo "$_date_timezone"
}

runtime() {
  version=$(nos_validate "$(nos_payload boxfile_runtime)" "string" "php-5.6")
  echo "${version}"
}

condensed_runtime() {
  version="$(runtime)"
  echo "${version//[.-]/}"
}

install_runtime() {
  nos_install "$(runtime)"
}

install_extensions() {
  if [[ "${PL_boxfile_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_extensions_length ; i++)); do
      type=PL_boxfile_extensions_${i}_type
      value=PL_boxfile_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        nos_install $(condensed_runtime)-${!value}
      fi
    done
  fi

  if [[ "${PL_boxfile_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_zend_extensions_length ; i++)); do
      type=PL_boxfile_zend_extensions_${i}_type
      value=PL_boxfile_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        nos_install $(condensed_runtime)-${!value}
      fi
    done
  fi
}

configure_php() {
  nos_print_process_start "Configuring PHP"
  mkdir -p $(nos_etc_dir)/php
  mkdir -p $(nos_deploy_dir)/var/log/php
  mkdir -p $(nos_deploy_dir)/var/run
  mkdir -p $(nos_deploy_dir)/var/tmp
  create_php_ini
}

configure_extensions() {
  mkdir -p $(etc_dir)/php.d
  if [[ "${PL_boxfile_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_extensions_length ; i++)); do
      type=PL_boxfile_extensions_${i}_type
      value=PL_boxfile_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        [[ -f ../templates/php/php.d/${!value}.ini.mustache ]] && nos_print_bullet_info "configuring PHP extension ${!value}" && eval create_${!value}_ini
      fi
    done
  fi

  if [[ "${PL_boxfile_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_zend_extensions_length ; i++)); do
      type=PL_boxfile_zend_extensions_${i}_type
      value=PL_boxfile_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        [[ -f ../templates/php/php.d/${!value}.ini.mustache ]] && nos_print_bullet_info && nos_print_bullet_info "configuring PHP Zend extension ${!value}" && eval create_${!value}_ini
      fi
    done
  fi
}