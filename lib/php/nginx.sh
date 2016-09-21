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
  "document_root": "$(nginx_document_root)",
  "directory_index": "$(nginx_directory_index)",
  "default_gateway": "$(nginx_default_gateway)"
}
END
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
  default_gateway=$(nos_validate "$(nos_payload config_nginx_default_gateway)" "file" "index.php")
  echo "$default_gateway"
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
