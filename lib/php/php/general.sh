# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

generate_php_ini() {
  # Report back to the user
  report_php_settings
  
  nos_template \
    "php/php.ini.mustache" \
    "$(nos_etc_dir)/php/prod_php.ini" \
    "$(php_ini_payload)"

  cp $(nos_etc_dir)/php/prod_php.ini $(nos_etc_dir)/php/php.ini
}

report_php_settings() {
  nos_print_bullet_sub "Short open tag: $(short_open_tag)"
  nos_print_bullet_sub "Zlib output compression: $(zlib_output_compression)"
  nos_print_bullet_sub "Allow url fopen: $(allow_url_fopen)"
  nos_print_bullet_sub "Disable functions: $(disable_functions)"
  nos_print_bullet_sub "Expose php: $(expose_php)"
  nos_print_bullet_sub "Max execution time: $(max_execution_time)"
  nos_print_bullet_sub "Max input time: $(max_input_time)"
  nos_print_bullet_sub "Memory limit: $(memory_limit)"
  nos_print_bullet_sub "Error reporting: $(error_reporting)"
  nos_print_bullet_sub "Display errors: $(display_errors)"
  nos_print_bullet_sub "Register globals: $(register_globals)"
  nos_print_bullet_sub "Register argc argv: $(register_argc_argv)"
  nos_print_bullet_sub "Post max size: $(post_max_size)"
  nos_print_bullet_sub "Default mimetype: $(default_mimetype)"
  nos_print_bullet_sub "Browscap: $(browscap)"
  nos_print_bullet_sub "File uploads: $(file_uploads)"
  nos_print_bullet_sub "Max input vars: $(max_input_vars)"
  nos_print_bullet_sub "Upload max filesize: $(upload_max_filesize)"
  nos_print_bullet_sub "Max file uploads: $(max_file_uploads)"
  nos_print_bullet_sub "Session length: $(session_length)"
  nos_print_bullet_sub "Default locale: $(default_locale)"
  nos_print_bullet_sub "Session autostart: $(session_autostart)"
  nos_print_bullet_sub "Session save path: $(session_save_path)"
  nos_print_bullet_sub "Session save handler: $(session_save_handler)"
  nos_print_bullet_sub "Date timezone: $(date_timezone)"
  nos_print_bullet_sub "Iconv internal encoding: $(iconv_internal_encoding)"
}

php_ini_payload() {
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
  "app_dir": "$(nos_app_dir)",
  "data_dir": "$(nos_data_dir)",
  "browscap": $(browscap),
  "file_uploads": "$(file_uploads)",
  "max_input_vars": "$(max_input_vars)",
  "upload_max_filesize": "$(upload_max_filesize)",
  "max_file_uploads": "$(max_file_uploads)",
  "extensions": $(extensions),
  "zend_extensions": $(zend_extensions),
  "extension_dir": "$(extension_dir)",
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

generate_dev_php_ini() {
  nos_template \
    "php/php.ini.mustache" \
    "$(nos_etc_dir)/php/dev_php.ini" \
    "$(dev_php_ini_payload)"
}

dev_php_ini_payload() {
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
  "app_dir": "$(nos_app_dir)",
  "data_dir": "$(nos_data_dir)",
  "browscap": $(browscap),
  "file_uploads": "$(file_uploads)",
  "max_input_vars": "$(max_input_vars)",
  "upload_max_filesize": "$(upload_max_filesize)",
  "max_file_uploads": "$(max_file_uploads)",
  "extensions": $(dev_extensions),
  "zend_extensions": $(dev_zend_extensions),
  "extension_dir": "$(extension_dir)",
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

php53() {
  # boxfile php_version = 5.3
  [[ $(runtime) = "php-5.3" ]] && echo "true" && return
  echo "false"
}

iconv_internal_encoding() {
  # boxfile php_iconv_internal_encoding
  _iconv_internal_encoding=$(nos_validate "$(nos_payload config_iconv_internal_encoding)" "string" "UTF-8")
  echo "$_iconv_internal_encoding"
}

timeout() {
  # boxfile max_execution_time + boxfile max_input_time + 30
  _max_execution_time=$(nos_validate "$(nos_payload config_max_execution_time)" "integer" "30")
  _max_input_time=$(nos_validate "$(nos_payload config_max_input)" "integer" "60")
  echo $((_max_execution_time + _max_input_time + 30))
}

short_open_tag() {
  # boxfile short_open_tag
  _short_open_tag=$(nos_validate "$(nos_payload config_short_open_tag)" "boolean" "On")
  echo "$_short_open_tag"
}

zlib_output_compression() {
  # boxfile zlib_output_compression
  _zlib_output_compression=$(nos_validate "$(nos_payload config_zlib_output_compression)" "boolean" "Off")
  echo "$_zlib_output_compression"
}

allow_url_fopen() {
  # boxfile allow_url_fopen
  _allow_url_fopen=$(nos_validate "$(nos_payload config_allow_url_fopen)" "boolean" "On")
  echo "$_allow_url_fopen"
}

disable_functions() {
  # boxfile disable_functions
  _disable_functions=$(nos_validate "$(nos_payload config_disable_functions)" "string" "")
  echo "$_disable_functions"
}

expose_php() {
  # boxfile expose_php
  _expose_php=$(nos_validate "$(nos_payload config_expose_php)" "boolean" "Off")
  echo "$_expose_php"
}

max_execution_time() {
  # boxfile max_execution_time
  _max_execution_time=$(nos_validate "$(nos_payload config_max_execution_time)" "integer" "30")
  echo "$_max_execution_time"
}

max_input_time() {
  # boxfile max_input_time
  _max_input_time=$(nos_validate "$(nos_payload config_max_input_time)" "integer" "60")
  echo "$_max_input_time"
}

memory_limit() {
  # boxfile memory_limit
  _memory_limit=$(nos_validate "$(nos_payload config_memory_limit)" "byte" "512M")
  echo "$_memory_limit"
}

error_reporting() {
  # boxfile error_reporting
  _error_reporting=$(nos_validate "$(nos_payload config_error_reporting)" "string" "E_ALL")
  echo "$_error_reporting"
}

display_errors() {
  # boxfile display_errors
  _display_errors=$(nos_validate "$(nos_payload config_display_errors)" "boolean" "On")
  echo "$_display_errors"
}

register_globals() {
  # boxfile register_globals
  _register_globals=$(nos_validate "$(nos_payload config_register_globals)" "boolean" "Off")
  echo "$_register_globals"
}

register_argc_argv() {
  # boxfile register_argc_argv
  _register_argc_argv=$(nos_validate "$(nos_payload config_register_argc_argv)" "boolean" "Off")
  echo "$_register_argc_argv"
}

post_max_size() {
  # boxfile post_max_size
  _post_max_size=$(nos_validate "$(nos_payload config_post_max_size)" "byte" "8M")
  echo "$_post_max_size"
}

default_mimetype() {
  # boxfile default_mimetype
  _default_mimetype=$(nos_validate "$(nos_payload config_default_mimetype)" "string" "text/html")
  echo "$_default_mimetype"
}

browscap() {
  # boxfile browscap
  _browscap=$(nos_validate "$(nos_payload config_browscap)" "string" "")
  if [[ -z "${_browscap}" ]]; then
    echo "false"
  else
    echo "\"$_browscap\""
  fi
}

file_uploads() {
  # boxfile file_uploads
  _file_uploads=$(nos_validate "$(nos_payload config_file_uploads)" "boolean" "On")
  echo "$_file_uploads"
}

max_input_vars() {
  # boxfile max_input_vars
  _max_input_vars=$(nos_validate "$(nos_payload config_max_input_vars)" "integer" "1000")
  echo "$_max_input_vars"
}

upload_max_filesize() {
  # boxfile upload_max_filesize
  _upload_max_filesize=$(nos_validate "$(nos_payload config_upload_max_filesize)" "byte" "2M")
  echo "$_upload_max_filesize"
}

max_file_uploads() {
  # boxfile max_file_uploads
  _max_file_uploads=$(nos_validate "$(nos_payload config_max_file_uploads)" "integer" "20")
  echo "$_max_file_uploads"
}

extension_dir() {
  # folder in lib/php/???
  for i in $(nos_data_dir)/lib/php/*; do [[ "$i" =~ /[0-9]+$ ]] && echo $i && return; done
}

extensions() {
  # boxfile extensions
  extension_dir=$(extension_dir)
  declare -a extensions_list
  extensions_list+=($(composer_required_extensions))
  if [[ "${PL_config_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_config_extensions_length ; i++)); do
      type=PL_config_extensions_${i}_type
      value=PL_config_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ${extension_dir}/${!value}.so ]]; then
          add="true"
          for j in "${extensions_list[@]}"; do
            if [[ "$j" = "${!value}" ]]; then
              add="false"
              break;
            fi
          done
          if [[ "$add" = "true" ]]; then
            extensions_list+=(${!value})
          fi
        else
          exit 1
        fi
      fi
    done
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
  if [[ "${PL_config_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_config_zend_extensions_length ; i++)); do
      type=PL_config_zend_extensions_${i}_type
      value=PL_config_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ${extension_dir}/${!value}.so ]]; then
          add="true"
          for j in "${zend_extensions_list[@]}"; do
            if [[ "$j" = "${!value}" ]]; then
              add="false"
              break;
            fi
          done
          if [[ "$add" = "true" ]]; then
            zend_extensions_list+=(${!value})
          fi
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

dev_extensions() {
  # boxfile extensions
  extension_dir=$(extension_dir)
  declare -a extensions_list
  extensions_list+=($(composer_required_extensions))
  if [[ "${PL_config_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_config_extensions_length ; i++)); do
      type=PL_config_extensions_${i}_type
      value=PL_config_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ${extension_dir}/${!value}.so ]]; then
          add="true"
          for j in "${extensions_list[@]}"; do
            if [[ "$j" = "${!value}" ]]; then
              add="false"
              break;
            fi
          done
          if [[ "$add" = "true" ]]; then
            extensions_list+=(${!value})
          fi
        else
          exit 1
        fi
      fi
    done
  fi
  if [[ "${PL_config_dev_extensions_add_type}" = "array" ]]; then
    for ((i=0; i < PL_config_dev_extensions_add_length ; i++)); do
      type=PL_config_dev_extensions_add_${i}_type
      value=PL_config_dev_extensions_add_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ${extension_dir}/${!value}.so ]]; then
          add="true"
          for j in "${extensions_list[@]}"; do
            if [[ "$j" = "${!value}" ]]; then
              add="false"
              break;
            fi
          done
          if [[ "$add" = "true" ]]; then
            extensions_list+=(${!value})
          fi
        else
          exit 1
        fi
      fi
    done
  fi
  if [[ "${PL_config_dev_extensions_rm_type}" = "array" ]]; then
    for ((i=0; i < PL_config_dev_extensions_rm_length ; i++)); do
      type=PL_config_dev_extensions_rm_${i}_type
      value=PL_config_dev_extensions_rm_${i}_value
      if [[ ${!type} = "string" ]]; then
        extensions_list=("${extensions_list[@]/${!value}}")
      fi
    done
  fi
  if [[ -z "extensions_list[@]" ]]; then
    echo "[]"
  else
    echo "[ \"$(nos_join '","' ${extensions_list[@]})\" ]"
  fi
}

dev_zend_extensions() {
  # boxfile zend_extensions
  extension_dir=$(extension_dir)
  declare -a zend_extensions_list
  if [[ "${PL_config_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_config_zend_extensions_length ; i++)); do
      type=PL_config_zend_extensions_${i}_type
      value=PL_config_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ${extension_dir}/${!value}.so ]]; then
          add="true"
          for j in "${zend_extensions_list[@]}"; do
            if [[ "$j" = "${!value}" ]]; then
              add="false"
              break;
            fi
          done
          if [[ "$add" = "true" ]]; then
            zend_extensions_list+=(${!value})
          fi
        else
          exit 1
        fi
      fi
    done
  fi
  if [[ "${PL_config_dev_zend_extensions_add_type}" = "array" ]]; then
    for ((i=0; i < PL_config_dev_zend_extensions_add_length ; i++)); do
      type=PL_config_dev_zend_extensions_add_${i}_type
      value=PL_config_dev_zend_extensions_add_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ${extension_dir}/${!value}.so ]]; then
          add="true"
          for j in "${zend_extensions_list[@]}"; do
            if [[ "$j" = "${!value}" ]]; then
              add="false"
              break;
            fi
          done
          if [[ "$add" = "true" ]]; then
            zend_extensions_list+=(${!value})
          fi
        else
          exit 1
        fi
      fi
    done
  fi
  if [[ "${PL_config_dev_zend_extensions_rm_type}" = "array" ]]; then
    for ((i=0; i < PL_config_dev_zend_extensions_rm_length ; i++)); do
      type=PL_config_dev_zend_extensions_rm_${i}_type
      value=PL_config_dev_zend_extensions_rm_${i}_value
      if [[ ${!type} = "string" ]]; then
        zend_extensions_list=("${zend_extensions_list[@]/${!value}}")
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
  _session_length=$(nos_validate "$(nos_payload config_session_length)" "integer" "3600")
  echo "$_session_length"
}

default_locale() {
  # boxfile default_locale
  _default_locale=$(nos_validate "$(nos_payload config_default_locale)" "string" "")
  echo "$_default_locale"
}

session_autostart() {
  # boxfile session_autostart
  _session_autostart=$(nos_validate "$(nos_payload config_session_autostart)" "boolean" "Off")
  echo "$_session_autostart"
}

session_save_path() {
  # boxfile session_save_path
  _session_save_path=$(nos_validate "$(nos_payload config_session_save_path)" "string" "$(nos_data_dir)/var/php/sessions")
  echo "$_session_save_path"
}

session_save_handler() {
  # boxfile session_save_handler
  _session_save_handler=$(nos_validate "$(nos_payload config_session_save_handler)" "string" "files")
  echo "$_session_save_handler"
}

date_timezone() {
  # boxfile date_timezone
  _date_timezone=$(nos_validate "$(nos_payload config_date_timezone)" "string" "Etc/UTC")
  echo "$_date_timezone"
}

configure_php() {
  nos_print_bullet "Configuring PHP..."
  mkdir -p $(nos_etc_dir)/php
  mkdir -p $(nos_data_dir)/var/log/php
  mkdir -p $(nos_data_dir)/var/run
  mkdir -p $(nos_data_dir)/var/tmp
  generate_php_ini
  generate_dev_php_ini
}

configure_extensions() {
  
  # if there aren't any php extensions we should show a message
  if [[ "$(extensions)" = "[ \"\" ]" ]]; then
    print_extension_warnings
  fi
  
  mkdir -p $(nos_etc_dir)/php.prod.d
  mkdir -p $(nos_etc_dir)/php.dev.d

  declare -a dev_extensions_rm
  if [[ "${PL_config_dev_extensions_rm_type}" = "array" ]]; then
    for ((i=0; i < PL_config_dev_extensions_rm_length ; i++)); do
      type=PL_config_dev_extensions_rm_${i}_type
      value=PL_config_dev_extensions_rm_${i}_value
      if [[ ${!type} = "string" ]]; then
        dev_extensions_rm+=(${!value})
      fi
    done
  fi

  declare -a dev_zend_extensions_rm
  if [[ "${PL_config_dev_zend_extensions_rm_type}" = "array" ]]; then
    for ((i=0; i < PL_config_dev_zend_extensions_rm_length ; i++)); do
      type=PL_config_dev_zend_extensions_rm_${i}_type
      value=PL_config_dev_zend_extensions_rm_${i}_value
      if [[ ${!type} = "string" ]]; then
        dev_zend_extensions_rm+=(${!value})
      fi
    done
  fi
  
  if [[ "${PL_config_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_config_extensions_length ; i++)); do
      type=PL_config_extensions_${i}_type
      value=PL_config_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ../templates/php/php.d/${!value}.ini.mustache ]]; then
          nos_print_bullet_info "Configuring PHP extension ${!value}..."
          eval generate_${!value}_ini
          if [[ ! " ${dev_extensions_rm[@]} " =~ " ${!value} " ]]; then
            nos_print_bullet_info "Configuring dev PHP extension ${!value}..."
            eval generate_dev_${!value}_ini
          fi
        fi
      fi
    done
  fi

  if [[ "${PL_config_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_config_zend_extensions_length ; i++)); do
      type=PL_config_zend_extensions_${i}_type
      value=PL_config_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ../templates/php/php.d/${!value}.ini.mustache ]]; then
          nos_print_bullet_info "Configuring Zend extension ${!value}..."
          eval generate_${!value}_ini
          if [[ ! " ${dev_zend_extensions_rm[@]} " =~ " ${!value} " ]]; then
            nos_print_bullet_info "Configuring dev Zend extension ${!value}..."
            eval generate_dev_${!value}_ini
          fi
        fi
      fi
    done
  fi

  if [[ "${PL_config_dev_extensions_add_type}" = "array" ]]; then
    for ((i=0; i < PL_config_dev_extensions_add_length ; i++)); do
      type=PL_config_dev_extensions_add_${i}_type
      value=PL_config_dev_extensions_add_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ../templates/php/php.d/${!value}.ini.mustache ]]; then
          nos_print_bullet_info "Configuring dev PHP extension ${!value}..."
          eval generate_dev_${!value}_ini
        fi
      fi
    done
  fi

  if [[ "${PL_config_dev_zend_extensions_add_type}" = "array" ]]; then
    for ((i=0; i < PL_config_dev_zend_extensions_add_length ; i++)); do
      type=PL_config_dev_zend_extensions_add_${i}_type
      value=PL_config_dev_zend_extensions_add_${i}_value
      if [[ ${!type} = "string" ]]; then
        if [[ -f ../templates/php/php.d/${!value}.ini.mustache ]]; then
          nos_print_bullet_info "Configuring dev Zend extension ${!value}..."
          eval generate_dev_${!value}_ini
        fi
      fi
    done
  fi

  rm -rf $(nos_etc_dir)/php.d
  ln -sf $(nos_etc_dir)/php.prod.d $(nos_etc_dir)/php.d
}

print_extension_warnings() {
  
  message=$(cat <<END
  ----------------------------------  WARNING  ----------------------------------
  It looks like you haven't declared any php extensions. If this app requires php 
  extensions, you can declare them in the boxfile like this:

  run.config:
    engine: php
    engine.config:
      extensions:
        - apc
        - geoip
        - mysql

  For additional information or clarity, please consult the nanobox php guide:

  http://guides.nanobox.io/php

END
)
  echo
  echo "$message"
  echo
}
