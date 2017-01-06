# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# Copy the code into the live directory which will be used to run the app
publish_release() {
  nos_print_bullet "Moving build into live code directory..."
  rsync -a $(nos_code_dir)/ $(nos_app_dir)
}

# Takes an argument as the interpreter and returns true if it's configured
is_interpreter() {
  # extract php interpreter
  interpreter="fpm"
  
  if [[ -n "$(nos_payload 'config_apache_php_interpreter')" ]]; then
    interpreter=$(nos_payload 'config_apache_php_interpreter')
  fi
  
  if [[ "${interpreter}" = "$1" ]]; then
    echo "true"
  else
    echo "false"
  fi
}

app_name() {
  # payload app
  echo "$(nos_payload app)"
}

webserver() {
  _webserver=$(nos_validate "$(nos_payload config_webserver)" "string" "apache")
  echo "${_webserver}"
}

configure_webserver() {
  
  if [[ "$(webserver)" = 'apache' ]]; then
    configure_apache
  elif [[ "$(webserver)" = 'nginx' ]]; then
    configure_nginx
  elif [[ "$(webserver)" = 'builtin' ]]; then
    configure_builtin
  fi
  
  if [[ "$(php_fpm_use_fastcgi)" = "true" ]]; then
    configure_php_fpm
  fi
}

runtime() {
  version=$(nos_validate "$(nos_payload config_runtime)" "string" "php-5.6")
  echo "${version}"
}

condensed_runtime() {
  version="$(runtime)"
  echo "${version//[.-]/}"
}

extension_packages() {
  pkgs=()
  extensions_list+=($(composer_required_extensions))
  
  for pkg in $(composer_required_extensions); do
    pkgs+=("$(condensed_runtime)-${pkg}")
  done

  if [[ "${PL_config_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_config_extensions_length ; i++)); do
      type=PL_config_extensions_${i}_type
      value=PL_config_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        pkgs+=("$(condensed_runtime)-${!value}")
      fi
    done
  fi

  if [[ "${PL_config_zend_extensions_type}" = "array" ]]; then
    for ((i=0; i < PL_config_zend_extensions_length ; i++)); do
      type=PL_config_zend_extensions_${i}_type
      value=PL_config_zend_extensions_${i}_value
      if [[ ${!type} = "string" ]]; then
        pkgs+=("$(condensed_runtime)-${!value}")
      fi
    done
  fi
  
  if [[ "${PL_config_dev_extensions_add_type}" = "array" ]]; then
    for ((i=0; i < PL_config_dev_extensions_add_length ; i++)); do
      type=PL_config_dev_extensions_add_${i}_type
      value=PL_config_dev_extensions_add_${i}_value
      if [[ ${!type} = "string" ]]; then
        pkgs+=("$(condensed_runtime)-${!value}")
      fi
    done
  fi

  if [[ "${PL_config_dev_zend_extensions_add_type}" = "array" ]]; then
    for ((i=0; i < PL_config_dev_zend_extensions_add_length ; i++)); do
      type=PL_config_dev_zend_extensions_add_${i}_type
      value=PL_config_dev_zend_extensions_add_${i}_value
      if [[ ${!type} = "string" ]]; then
        pkgs+=("$(condensed_runtime)-${!value}")
      fi
    done
  fi

  echo "${pkgs[@]}"
}

validate_runtime_packages() {
  /data/bin/pkgin up > /dev/null

  pkgs=("$(runtime)")
  
  # add php/zend extensions
  pkgs+=("$(extension_packages)")
  
  # add apache packages
  if [[ "$(webserver)" = "apache" ]]; then
    pkgs+=("$(apache_packages)")
  fi
  
  # add nginx packages
  if [[ "$(webserver)" = "nginx" ]]; then
    pkgs+=("$(nginx_packages)")
  fi
  
  # install composer
  pkgs+=("$(composer_packages)")

  bad_pkgs=()

  for pkg in ${pkgs[@]}; do
    if [[ $pkg =~ ^(.*)-([0-9\.]+) ]]; then
      p=${BASH_REMATCH[1]}
      v=${BASH_REMATCH[2]}
      (/data/bin/pkgin se ${p} | grep ${p}-${v} > /dev/null) || bad_pkgs+=("${pkg}")
    else
      /data/bin/pkgin se ${pkg} | grep ${pkg}- > /dev/null || bad_pkgs+=("${pkg}")
    fi
  done

  if [[ ${#bad_pkgs[@]} -gt 0 ]]; then
    echo "Can not find ${bad_pkgs[@]} to install"
    echo "Please verify they exist. Check what extensions are available here:"
    echo "https://github.com/nanobox-io/nanobox-engine-php/blob/master/doc/php-extensions.md"
    exit 1
  fi
}

# Install php runtime, webservers, and any additional dependencies
install_runtime_packages() {
  pkgs=("$(runtime)")
  
  # add php/zend extensions
  pkgs+=("$(extension_packages)")
  
  # add apache packages
  if [[ "$(webserver)" = "apache" ]]; then
    pkgs+=("$(apache_packages)")
  fi
  
  # add nginx packages
  if [[ "$(webserver)" = "nginx" ]]; then
    pkgs+=("$(nginx_packages)")
  fi
  
  # install composer
  pkgs+=("$(composer_packages)")

  # unique the list
  declare -a install_pkgs
  for i in "${pkgs[@]}"; do
    add="true"
    for j in "${install_pkgs[@]}"; do
      if [[ "$i" = "$j" ]]; then
        add="false"
        break;
      fi
    done
    if [[ "$add" = "true" ]]; then
      install_pkgs+=(${i})
    fi
  done 
  
  nos_install ${install_pkgs[@]}
}

# Uninstall build dependencies
uninstall_build_packages() {
  # currently php doesn't install any build-only deps... I think
  pkgs=()

  # if pkgs isn't empty, let's uninstall what we don't need
  if [[ ${#pkgs[@]} -gt 0 ]]; then
    nos_uninstall ${pkgs[@]}
  fi
}

# Generate the payload to render the php profile template
php_profile_payload() {
  cat <<-END
{
  "etc_dir": "$(nos_etc_dir)"
}
END
}

# Profile script to switch between production and dev php.ini files
php_profile_script() {
  nos_template \
    "profile.d/php.sh" \
    "$(nos_etc_dir)/profile.d/php.sh" \
    "$(php_profile_payload)"
}

# Takes an argument as the webserver and returns true if it's configured    
is_webserver() {    
  # set the default webserver to apache   
  webserver='apache'    
      
  if [[ -n "$(nos_payload 'config_webserver')" ]]; then   
    webserver=$(nos_payload 'config_webserver')   
  fi    
      
  if [[ "$webserver" = "$1" ]]; then    
    echo "true"   
  else    
    echo "false"    
  fi    
}

php_server_script_payload() {
  cat <<-END
{
  "env_dir": "$(nos_payload "env_dir")",
  "apache": $(is_webserver 'apache'),    
  "fpm": $(is_interpreter 'fpm'),   
  "mod_php": $(is_interpreter 'mod_php'),   
  "nginx": $(is_webserver 'nginx'),   
  "builtin": $(is_webserver 'builtin'),   
  "etc_dir": "$(nos_etc_dir)",    
  "data_dir": "$(nos_data_dir)",    
  "code_dir": "$(nos_code_dir)",
}
END
}

php_server_script() {
  nos_template \
  "bin/php-server.mustache" \
  "$(nos_data_dir)/bin/php-server" \
  "$(php_server_script_payload)"
  chmod 755 $(nos_data_dir)/bin/php-server
}
