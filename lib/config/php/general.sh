# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_php_ini() {
  template \
    "php/php.ini.mustache" \
    "$(payload 'etc_dir')/php/php.ini" \
    "$(php_ini_payload)"
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
  "live_dir": "$(live_dir)",
  "browscap": $(browscap),
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

php53() {
  # boxfile php_version = 5.3
  version=$(validate "$(payload boxfile_php_version)" "string" "5.6")
  [[ ${version} = "5.3" ]] && echo "true" && return
  echo "false"
}

iconv_internal_encoding() {
  # boxfile php_iconv_internal_encoding
  php_iconv_internal_encoding=$(validate "$(payload boxfile_php_iconv_internal_encoding)" "string" "UTF-8")
  >&2 echo "Using ${php_iconv_internal_encoding} as PHP iconv internal encoding"
  echo "$php_iconv_internal_encoding"
}

timeout() {
  # boxfile php_max_execution_time + boxfile php_max_input_time + 30
  php_max_execution_time=$(validate "$(payload boxfile_php_max_execution_time)" "integer" "30")
  php_max_input_time=$(validate "$(payload boxfile_php_max_input)" "integer" "60")
  >&2 echo "Using $((php_max_execution_time + php_max_input_time + 30)) as PHP timeout"
  echo $((php_max_execution_time + php_max_input_time + 30))
}

short_open_tag() {
  # boxfile php_short_open_tag
  php_short_open_tag=$(validate "$(payload boxfile_php_short_open_tag)" "boolean" "On")
  >&2 echo "Using ${php_short_open_tag} as PHP short open tag"
  echo "$php_short_open_tag"
}

zlib_output_compression() {
  # boxfile php_zlib_output_compression
  php_zlib_output_compression=$(validate "$(payload boxfile_php_zlib_output_compression)" "boolean" "Off")
  >&2 echo "Using ${php_zlib_output_compression} as PHP zlib output compression"
  echo "$php_zlib_output_compression"
}

allow_url_fopen() {
  # boxfile php_allow_url_fopen
  php_allow_url_fopen=$(validate "$(payload boxfile_php_allow_url_fopen)" "boolean" "On")
  >&2 echo "Using ${php_allow_url_fopen} as PHP allow url fopen"
  echo "$php_allow_url_fopen"
}

disable_functions() {
  # boxfile php_disable_functions
  php_disable_functions=$(validate "$(payload boxfile_php_disable_functions)" "string" "")
  >&2 echo "Using ${php_disable_functions} as PHP disable functions"
  echo "$php_disable_functions"
}

expose_php() {
  # boxfile php_expose_php
  php_expose_php=$(validate "$(payload boxfile_php_expose_php)" "boolean" "Off")
  >&2 echo "Using ${php_expose_php} as PHP expose php"
  echo "$php_expose_php"
}

max_execution_time() {
  # boxfile php_max_execution_time
  php_max_execution_time=$(validate "$(payload boxfile_php_max_execution_time)" "integer" "30")
  >&2 echo "Using ${php_max_execution_time} as PHP max execution time"
  echo "$php_max_execution_time"
}

max_input_time() {
  # boxfile php_max_input_time
  php_max_input_time=$(validate "$(payload boxfile_php_max_input_time)" "integer" "60")
  >&2 echo "Using ${php_max_input_time} as PHP max input time"
  echo "$php_max_input_time"
}

memory_limit() {
  # boxfile php_memory_limit
  php_memory_limit=$(validate "$(payload boxfile_php_memory_limit)" "byte" "512M")
  >&2 echo "Using ${php_memory_limit} as PHP memory limit"
  echo "$php_memory_limit"
}

error_reporting() {
  # boxfile php_error_reporting
  php_error_reporting=$(validate "$(payload boxfile_php_error_reporting)" "string" "E_ALL")
  >&2 echo "Using ${php_error_reporting} as PHP error reporting"
  echo "$php_error_reporting"
}

display_errors() {
  # boxfile php_display_errors
  php_display_errors=$(validate "$(payload boxfile_php_display_errors)" "boolean" "On")
  >&2 echo "Using ${php_display_errors} as PHP display errors"
  echo "$php_display_errors"
}

register_globals() {
  # boxfile php_register_globals
  php_register_globals=$(validate "$(payload boxfile_php_register_globals)" "boolean" "Off")
  >&2 echo "Using ${php_register_globals} as PHP register globals"
  echo "$php_register_globals"
}

register_argc_argv() {
  # boxfile php_register_argc_argv
  php_register_argc_argv=$(validate "$(payload boxfile_php_register_argc_argv)" "boolean" "Off")
  >&2 echo "Using ${php_register_argc_argv} as PHP register argc argv"
  echo "$php_register_argc_argv"
}

post_max_size() {
  # boxfile php_post_max_size
  php_post_max_size=$(validate "$(payload boxfile_php_post_max_size)" "byte" "8M")
  >&2 echo "Using ${php_post_max_size} as PHP max post size"
  echo "$php_post_max_size"
}

default_mimetype() {
  # boxfile php_default_mimetype
  php_default_mimetype=$(validate "$(payload boxfile_php_default_mimetype)" "string" "text/html")
  >&2 echo "Using ${php_default_mimetype} as PHP default mimetype"
  echo "$php_default_mimetype"
}

browscap() {
  # boxfile php_browscap
  php_browscap=$(validate "$(payload boxfile_php_browscap)" "string" "")
  if [[ -z "${php_browscap}" ]]; then
    >&2 echo "Not using PHP browscap"
    echo "false"
  else
    >&2 echo "Using ${php_browscap} as PHP browscap"
    echo "\"$php_browscap\""
  fi
}

file_uploads() {
  # boxfile php_file_uploads
  php_file_uploads=$(validate "$(payload boxfile_php_file_uploads)" "boolean" "On")
  >&2 echo "Using ${php_file_uploads} as PHP file uploads"
  echo "$php_file_uploads"
}

max_input_vars() {
  # boxfile php_max_input_vars
  php_max_input_vars=$(validate "$(payload boxfile_php_max_input_vars)" "integer" "1000")
  >&2 echo "Using ${php_max_input_vars} as PHP max input vars"
  echo "$php_max_input_vars"
}

upload_max_filesize() {
  # boxfile php_upload_max_filesize
  php_upload_max_filesize=$(validate "$(payload boxfile_php_upload_max_filesize)" "byte" "2M")
  >&2 echo "Using ${php_upload_max_filesize} as PHP upload max filesize"
  echo "$php_upload_max_filesize"
}

max_file_uploads() {
  # boxfile php_max_file_uploads
  php_max_file_uploads=$(validate "$(payload boxfile_php_max_file_uploads)" "integer" "20")
  >&2 echo "Using ${php_max_file_uploads} as PHP max file uploads"
  echo "$php_max_file_uploads"
}

extension_folder() {
  # folder in lib/php/???
  for i in $(payload deploy_dir)/lib/php/*; do [[ "$i" =~ /[0-9]+$ ]] && echo $i && return; done
}

extensions() {
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
    >&2 echo "Not loading any PHP extensions"
    echo "[]"
  else
    >&2 echo "Using $(join ', ' ${php_extensions_list[@]}) as PHP extensions"
    echo "[ \"$(join '","' ${php_extensions_list[@]})\" ]"
  fi
}

zend_extensions() {
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
    >&2 echo "Not loading any PHP Zend extensions"
    echo "[]"
  else
    >&2 echo "Using $(join ', ' ${php_zend_extensions_list[@]}) as PHP Zend extensions"
    echo "[ \"$(join '","' ${php_zend_extensions_list[@]})\" ]"
  fi
}

session_length() {
  # boxfile php_session_length
  php_session_length=$(validate "$(payload boxfile_php_session_length)" "integer" "3600")
  >&2 echo "Using ${php_session_length} as PHP session length"
  echo "$php_session_length"
}

default_locale() {
  # boxfile php_default_locale
  php_default_locale=$(validate "$(payload boxfile_php_default_locale)" "string" "")
  >&2 echo "Using ${php_default_locale} as PHP default locale"
  echo "$php_default_locale"
}

session_autostart() {
  # boxfile php_session_autostart
  php_session_autostart=$(validate "$(payload boxfile_php_session_autostart)" "boolean" "Off")
  >&2 echo "Using ${php_session_autostart} as PHP session autostart"
  echo "$php_session_autostart"
}

session_save_path() {
  # boxfile php_session_save_path
  php_session_save_path=$(validate "$(payload boxfile_php_session_save_path)" "string" "/var/php/sessions")
  >&2 echo "Using ${php_session_save_path} as PHP session save path"
  echo "$php_session_save_path"
}

session_save_handler() {
  # boxfile php_session_save_handler
  php_session_save_handler=$(validate "$(payload boxfile_php_session_save_handler)" "string" "files")
  >&2 echo "Using ${php_session_save_handler} as PHP session save handler"
  echo "$php_session_save_handler"
}

date_timezone() {
  # boxfile php_date_timezone
  php_date_timezone=$(validate "$(payload boxfile_php_date_timezone)" "string" "Etc/UTC")
  >&2 echo "Using ${php_date_timezone} as PHP date timezone"
  echo "$php_date_timezone"
}

runtime() {
  version=$(validate "$(payload boxfile_runtime)" "string" "php-5.6")
  echo "${version}"
}

condensed_runtime() {
  version="$(runtime)"
  echo "${version//[.-]/}"
}

install_runtime() {
  install "$(runtime)"
}

install_php_extensions() {
  if [[ "${PL_boxfile_php_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_php_extensions_length ; i++)); do
      type=PL_boxfile_php_extensions_${i}_type
      value=PL_boxfile_php_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        install $(condensed_runtime)-${!value}
      fi
    done
  fi

  if [[ "${PL_boxfile_php_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_php_zend_extensions_length ; i++)); do
      type=PL_boxfile_php_zend_extensions_${i}_type
      value=PL_boxfile_php_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        install $(condensed_runtime)-${!value}
      fi
    done
  fi
}

configure_php() {
  print_bullet_info "Configuring PHP"
  mkdir -p $(etc_dir)/php
  mkdir -p $(deploy_dir)/var/log/php
  mkdir -p $(deploy_dir)/var/run
  mkdir -p $(deploy_dir)/var/tmp
  create_php_ini

}

configure_php_extensions() {
  mkdir -p $(etc_dir)/php.d
  if [[ "${PL_boxfile_php_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_php_extensions_length ; i++)); do
      type=PL_boxfile_php_extensions_${i}_type
      value=PL_boxfile_php_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        [[ -f ../templates/php/php.d/${!value}.ini.mustache ]] && print_bullet_info "configuring PHP extension ${!value}" && eval create_php_${!value}_ini
      fi
    done
  fi

  if [[ "${PL_boxfile_php_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_boxfile_php_zend_extensions_length ; i++)); do
      type=PL_boxfile_php_zend_extensions_${i}_type
      value=PL_boxfile_php_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        [[ -f ../templates/php/php.d/${!value}.ini.mustache ]] && print_bullet_info && print_bullet_info "configuring PHP Zend extension ${!value}" && eval create_php_${!value}_ini
      fi
    done
  fi
}