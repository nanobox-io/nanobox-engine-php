# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

php_create_php_ini() {
  nos_print_bullet "Generating php.ini"
  nos_template \
    "php/php.ini.mustache" \
    "$(nos_etc_dir)/php/php.ini" \
    "$(php_php_ini_payload)"
}

php_php_ini_payload() {
  _short_open_tag=$(php_short_open_tag)
  _zlib_output_compression=$(php_zlib_output_compression)
  _allow_url_fopen=$(php_allow_url_fopen)
  _disable_functions=$(php_disable_functions)
  _expose_php=$(php_expose_php)
  _max_execution_time=$(php_max_execution_time)
  _max_input_time=$(php_max_input_time)
  _memory_limit=$(php_memory_limit)
  _error_reporting=$(php_error_reporting)
  _display_errors=$(php_display_errors)
  _register_globals=$(php_register_globals)
  _register_argc_argv=$(php_register_argc_argv)
  _post_max_size=$(php_post_max_size)
  _default_mimetype=$(php_default_mimetype)
  _browscap=$(php_browscap)
  _file_uploads=$(php_file_uploads)
  _max_input_vars=$(php_max_input_vars)
  _upload_max_filesize=$(php_upload_max_filesize)
  _max_file_uploads=$(php_max_file_uploads)
  _session_length=$(php_session_length)
  _default_locale=$(php_default_locale)
  _session_autostart=$(php_session_autostart)
  _session_save_path=$(php_session_save_path)
  _session_save_handler=$(php_session_save_handler)
  _date_timezone=$(php_date_timezone)
  _iconv_internal_encoding=$(php_iconv_internal_encoding)
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
  "extensions": $(php_extensions),
  "zend_extensions": $(php_zend_extensions),
  "extension_dir": "$(php_extension_dir)",
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

php_php53() {
  # boxfile php_version = 5.3
  version=$(nos_validate "$(nos_payload boxfile_php_version)" "string" "5.6")
  [[ ${version} = "5.3" ]] && echo "true" && return
  echo "false"
}

php_iconv_internal_encoding() {
  # boxfile php_iconv_internal_encoding
  _php_iconv_internal_encoding=$(nos_validate "$(nos_payload boxfile_php_iconv_internal_encoding)" "string" "UTF-8")
  echo "$_php_iconv_internal_encoding"
}

php_timeout() {
  # boxfile php_max_execution_time + boxfile php_max_input_time + 30
  _php_max_execution_time=$(nos_validate "$(nos_payload boxfile_php_max_execution_time)" "integer" "30")
  _php_max_input_time=$(nos_validate "$(nos_payload boxfile_php_max_input)" "integer" "60")
  echo $((_php_max_execution_time + _php_max_input_time + 30))
}

php_short_open_tag() {
  # boxfile php_short_open_tag
  _php_short_open_tag=$(nos_validate "$(nos_payload boxfile_php_short_open_tag)" "boolean" "On")
  echo "$_php_short_open_tag"
}

php_zlib_output_compression() {
  # boxfile php_zlib_output_compression
  _php_zlib_output_compression=$(nos_validate "$(nos_payload boxfile_php_zlib_output_compression)" "boolean" "Off")
  echo "$_php_zlib_output_compression"
}

php_allow_url_fopen() {
  # boxfile php_allow_url_fopen
  _php_allow_url_fopen=$(nos_validate "$(nos_payload boxfile_php_allow_url_fopen)" "boolean" "On")
  echo "$_php_allow_url_fopen"
}

php_disable_functions() {
  # boxfile php_disable_functions
  _php_disable_functions=$(nos_validate "$(nos_payload boxfile_php_disable_functions)" "string" "")
  echo "$_php_disable_functions"
}

php_expose_php() {
  # boxfile php_expose_php
  _php_expose_php=$(nos_validate "$(nos_payload boxfile_php_expose_php)" "boolean" "Off")
  echo "$_php_expose_php"
}

php_max_execution_time() {
  # boxfile php_max_execution_time
  _php_max_execution_time=$(nos_validate "$(nos_payload boxfile_php_max_execution_time)" "integer" "30")
  echo "$_php_max_execution_time"
}

php_max_input_time() {
  # boxfile php_max_input_time
  _php_max_input_time=$(nos_validate "$(nos_payload boxfile_php_max_input_time)" "integer" "60")
  echo "$_php_max_input_time"
}

php_memory_limit() {
  # boxfile php_memory_limit
  _php_memory_limit=$(nos_validate "$(nos_payload boxfile_php_memory_limit)" "byte" "512M")
  echo "$_php_memory_limit"
}

php_error_reporting() {
  # boxfile php_error_reporting
  _php_error_reporting=$(nos_validate "$(nos_payload boxfile_php_error_reporting)" "string" "E_ALL")
  echo "$_php_error_reporting"
}

php_display_errors() {
  # boxfile php_display_errors
  _php_display_errors=$(nos_validate "$(nos_payload boxfile_php_display_errors)" "boolean" "On")
  echo "$_php_display_errors"
}

php_register_globals() {
  # boxfile php_register_globals
  _php_register_globals=$(nos_validate "$(nos_payload boxfile_php_register_globals)" "boolean" "Off")
  echo "$_php_register_globals"
}

php_register_argc_argv() {
  # boxfile php_register_argc_argv
  _php_register_argc_argv=$(nos_validate "$(nos_payload boxfile_php_register_argc_argv)" "boolean" "Off")
  echo "$_php_register_argc_argv"
}

php_post_max_size() {
  # boxfile php_post_max_size
  _php_post_max_size=$(nos_validate "$(nos_payload boxfile_php_post_max_size)" "byte" "8M")
  echo "$_php_post_max_size"
}

php_default_mimetype() {
  # boxfile php_default_mimetype
  _php_default_mimetype=$(nos_validate "$(nos_payload boxfile_php_default_mimetype)" "string" "text/html")
  echo "$_php_default_mimetype"
}

php_browscap() {
  # boxfile php_browscap
  _php_browscap=$(nos_validate "$(nos_payload boxfile_php_browscap)" "string" "")
  if [[ -z "${_php_browscap}" ]]; then
    echo "false"
  else
    echo "\"$_php_browscap\""
  fi
}

php_file_uploads() {
  # boxfile php_file_uploads
  _php_file_uploads=$(nos_validate "$(nos_payload boxfile_php_file_uploads)" "boolean" "On")
  echo "$_php_file_uploads"
}

php_max_input_vars() {
  # boxfile php_max_input_vars
  _php_max_input_vars=$(nos_validate "$(nos_payload boxfile_php_max_input_vars)" "integer" "1000")
  echo "$_php_max_input_vars"
}

php_upload_max_filesize() {
  # boxfile php_upload_max_filesize
  _php_upload_max_filesize=$(nos_validate "$(nos_payload boxfile_php_upload_max_filesize)" "byte" "2M")
  echo "$_php_upload_max_filesize"
}

php_max_file_uploads() {
  # boxfile php_max_file_uploads
  _php_max_file_uploads=$(nos_validate "$(nos_payload boxfile_php_max_file_uploads)" "integer" "20")
  echo "$_php_max_file_uploads"
}

php_extension_dir() {
  # folder in lib/php/???
  for i in $(nos_deploy_dir)/lib/php/*; do [[ "$i" =~ /[0-9]+$ ]] && echo $i && return; done
}

php_extensions() {
  # boxfile php_extensions
  extension_dir=$(php_extension_dir)
  declare -a php_extensions_list
  if [[ "${PL_boxfile_php_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_php_extensions_length ; i++)); do
      type=PL_boxfile_php_extensions_${i}_type
      value=PL_boxfile_php_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ${extension_dir}/${!value}.so ]]; then
          php_extensions_list+=(${!value})
        else
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
    echo "[ \"$(nos_join '","' ${php_extensions_list[@]})\" ]"
  fi
}

php_zend_extensions() {
  # boxfile php_zend_extensions
  extension_dir=$(php_extension_dir)
  declare -a php_zend_extensions_list
  if [[ "${PL_boxfile_php_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_php_zend_extensions_length ; i++)); do
      type=PL_boxfile_php_zend_extensions_${i}_type
      value=PL_boxfile_php_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ${extension_dir}/${!value}.so ]]; then
          php_zend_extensions_list+=(${!value})
        else
          exit 1
        fi
      fi
    done
  fi
  if [[ -z "${php_zend_extensions_list[@]}" ]]; then
    echo "[]"
  else
    echo "[ \"$(nos_join '","' ${php_zend_extensions_list[@]})\" ]"
  fi
}

php_session_length() {
  # boxfile php_session_length
  _php_session_length=$(nos_validate "$(nos_payload boxfile_php_session_length)" "integer" "3600")
  echo "$_php_session_length"
}

php_default_locale() {
  # boxfile php_default_locale
  _php_default_locale=$(nos_validate "$(nos_payload boxfile_php_default_locale)" "string" "")
  echo "$_php_default_locale"
}

php_session_autostart() {
  # boxfile php_session_autostart
  _php_session_autostart=$(nos_validate "$(nos_payload boxfile_php_session_autostart)" "boolean" "Off")
  echo "$_php_session_autostart"
}

php_session_save_path() {
  # boxfile php_session_save_path
  _php_session_save_path=$(nos_validate "$(nos_payload boxfile_php_session_save_path)" "string" "$(nos_deploy_dir)/var/php/sessions")
  echo "$_php_session_save_path"
}

php_session_save_handler() {
  # boxfile php_session_save_handler
  _php_session_save_handler=$(nos_validate "$(nos_payload boxfile_php_session_save_handler)" "string" "files")
  echo "$_php_session_save_handler"
}

php_date_timezone() {
  # boxfile php_date_timezone
  _php_date_timezone=$(nos_validate "$(nos_payload boxfile_php_date_timezone)" "string" "Etc/UTC")
  echo "$_php_date_timezone"
}

php_runtime() {
  version=$(nos_validate "$(nos_payload boxfile_php_runtime)" "string" "php-5.6")
  echo "${version}"
}

php_condensed_runtime() {
  version="$(php_runtime)"
  echo "${version//[.-]/}"
}

php_install_runtime() {
  nos_install "$(php_runtime)"
}

php_install_php_extensions() {
  if [[ "${PL_boxfile_php_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_php_extensions_length ; i++)); do
      type=PL_boxfile_php_extensions_${i}_type
      value=PL_boxfile_php_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        nos_install $(php_condensed_runtime)-${!value}
      fi
    done
  fi

  if [[ "${PL_boxfile_php_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_php_zend_extensions_length ; i++)); do
      type=PL_boxfile_php_zend_extensions_${i}_type
      value=PL_boxfile_php_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        nos_install $(php_condensed_runtime)-${!value}
      fi
    done
  fi
}

php_configure_php() {
  nos_print_process_start "Configuring PHP"
  mkdir -p $(nos_etc_dir)/php
  mkdir -p $(nos_deploy_dir)/var/log/php
  mkdir -p $(nos_deploy_dir)/var/run
  mkdir -p $(nos_deploy_dir)/var/tmp
  php_create_php_ini
}

php_configure_php_extensions() {
  mkdir -p $(etc_dir)/php.d
  if [[ "${PL_boxfile_php_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_php_extensions_length ; i++)); do
      type=PL_boxfile_php_extensions_${i}_type
      value=PL_boxfile_php_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        [[ -f ../templates/php/php.d/${!value}.ini.mustache ]] && nos_print_bullet_info "configuring PHP extension ${!value}" && eval php_create_php_${!value}_ini
      fi
    done
  fi

  if [[ "${PL_boxfile_php_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_php_zend_extensions_length ; i++)); do
      type=PL_boxfile_php_zend_extensions_${i}_type
      value=PL_boxfile_php_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        [[ -f ../templates/php/php.d/${!value}.ini.mustache ]] && nos_print_bullet_info && nos_print_bullet_info "configuring PHP Zend extension ${!value}" && eval php_create_php_${!value}_ini
      fi
    done
  fi
}