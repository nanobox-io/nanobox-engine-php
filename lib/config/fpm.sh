
create_php_fpm_conf() {
  template \
    "php/php-fpm.conf.mustache" \
    "$(payload 'etc_dir')/php/php-fpm.conf" \
    "$(fpm_conf_payload)"
}

fpm_conf_payload() {
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

events_mechanism() {
  # boxfile php_fpm_events_mechanism
  uname=$(uname)
  [[ "$uname" =~ "Linux" ]] && default=epoll
  php_fpm_events_mechanism=$(validate "$(payload php_fpm_events_mechanism)" "string" "$default")
  echo $php_fpm_events_mechanism
}

max_children() {
  # boxfile php_fpm_max_children
  php_fpm_max_children=$(validate "$(payload boxfile_php_fpm_max_children)" "integer" "20")
  echo "$php_fpm_max_children"
}

max_spare_servers() {
  # boxfile php_fpm_max_spare_servers
  php_fpm_max_spare_servers=$(validate "$(payload boxfile_php_fpm_max_spare_servers)" "integer" "1")
  echo "$php_fpm_max_spare_servers"
}

max_requests() {
  # boxfile php_fpm_max_requests
  php_fpm_max_requests=$(validate "$(payload boxfile_php_fpm_max_requests)" "integer" "128")
  echo "$php_fpm_max_requests"
}