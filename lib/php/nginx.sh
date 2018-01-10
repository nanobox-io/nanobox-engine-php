# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

generate_nginx_conf() {
  
  # Report back to the user
  report_nginx_settings
  
  nos_template \
  "nginx/nginx.conf.mustache" \
  "$(nos_etc_dir)/nginx/nginx.conf" \
  "$(nginx_conf_payload)"
}

report_nginx_settings() {
  nos_print_bullet_sub "Document root: $(nginx_document_root)"
  nos_print_bullet_sub "Directory index: $(nginx_directory_index)"
  nos_print_bullet_sub "Default application gateway: $(nginx_default_gateway)"
}

nginx_conf_payload() {
  cat <<-END
{
  "data_dir": "$(nos_data_dir)",
  "code_dir": "$(nos_code_dir)",
  "force_https": $(nginx_force_https),
  "has_try_files": $(nginx_has_try_files),
  "try_files": "$(nginx_try_files)",
  "document_root": "$(nginx_document_root)",
  "directory_index": "$(nginx_directory_index)",
  "default_gateway": "$(nginx_default_gateway)",
  "client_body_buffer_size": "$(nginx_client_body_buffer_size)",
  "client_body_in_file_only": "$(nginx_client_body_in_file_only)",
  "client_max_body_size": "$(nginx_client_max_body_size)",
  "send_timeout": "$(nginx_send_timeout)",
  "fastcgi_read_timeout": "$(nginx_fastcgi_read_timeout)",
  "fastcgi_send_timeout": "$(nginx_fastcgi_send_timeout)"
}
END
}

nginx_force_https() {
  # boxfile nginx_force_https
  force_https=$(nos_validate "$(nos_payload config_nginx_force_https)" "boolean" "false")
  echo "$force_https"
}

nginx_has_try_files() {
  [[ -n "$(nginx_try_files)" ]] && echo "true" && return
  echo "false"
}

nginx_try_files() {
  # boxfile nginx_try_files
  try_files=$(nos_validate "$(nos_payload config_nginx_try_files)" "string" "")
  echo "$try_files"
}

nginx_document_root() {
  # boxfile nginx_document_root
  document_root=$(nos_validate "$(nos_payload config_nginx_document_root)" "folder" "$(nos_validate "$(nos_payload config_document_root)" "folder" "/")")

  if [[ ${document_root:0:1} = '/' ]]; then
    echo $document_root
  else 
    echo /$document_root
  fi
}

nginx_directory_index() {
  # boxfile nginx_index_list
  index_list=$(nos_validate "$(nos_payload config_nginx_index_list)" "string" "index.html index.php")
  for i in $index_list; do
    ignore=$(nos_validate "$i" "file" "")
  done
  echo "$index_list"
}

nginx_default_gateway() {
  # boxfile nginx_default_gateway
  default_gateway=$(nos_validate "$(nos_payload config_nginx_default_gateway)" "string" "index.php")
  echo "$default_gateway"
}

nginx_client_body_buffer_size() {
  # boxfile nginx_client_body_buffer_size
  client_body_buffer_size=$(nos_validate "$(nos_payload config_nginx_client_body_buffer_size)" "byte" "16k")
  echo "$client_body_buffer_size"
}

nginx_client_body_in_file_only() {
  # boxfile nginx_client_body_in_file_only
  client_body_in_file_only=$(nos_validate "$(nos_payload config_nginx_client_body_in_file_only)" "string" "off")
  echo "$client_body_in_file_only"
}
nginx_client_max_body_size() {
  # boxfile nginx_client_max_body_size
  client_max_body_size=$(nos_validate "$(nos_payload config_nginx_client_max_body_size)" "byte" "1m")
  echo "$client_max_body_size"
}

nginx_send_timeout() {
  # boxfile nginx_send_timeout
  send_timeout=$(nos_validate "$(nos_payload config_nginx_send_timeout)" "integer" "60")
  echo "$send_timeout"
}

nginx_fastcgi_read_timeout() {
  # boxfile nginx_fastcgi_read_timeout
  fastcgi_read_timeout=$(nos_validate "$(nos_payload config_nginx_fastcgi_read_timeout)" "integer" "60")
  echo "$fastcgi_read_timeout"
}

nginx_fastcgi_send_timeout() {
  # boxfile nginx_fastcgi_send_timeout
  fastcgi_send_timeout=$(nos_validate "$(nos_payload config_nginx_fastcgi_send_timeout)" "integer" "60")
  echo "$fastcgi_send_timeout"
}

nginx_packages() {
  pkgs=("nginx")
  echo "${pkgs[@]}"
}

generate_nginx_script() {
  nos_template \
  "bin/start-nginx-php-fpm.mustache" \
  "$(nos_data_dir)/bin/start-nginx" \
  "$(nginx_script_payload)"
  chmod 755 $(nos_data_dir)/bin/start-nginx
}

nginx_script_payload() {
  cat <<-END
{
  "data_dir": "$(nos_data_dir)"
}
END
}

configure_nginx() {
  nos_print_bullet "Configuring Nginx..."
  mkdir -p $(nos_etc_dir)/nginx
  mkdir -p $(nos_data_dir)/var/log/nginx
  mkdir -p $(nos_data_dir)/var/tmp/nginx/client_body_temp
  mkdir -p $(nos_data_dir)/var/run
  mkdir -p $(nos_data_dir)/var/tmp
  generate_nginx_conf
  generate_nginx_script
}
