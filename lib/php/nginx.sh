# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

php_nginx_create_ngnix_conf() {
  nos_print_bullet "Generating nginx.conf"
  nos_template \
  "nginx/nginx.conf.mustache" \
  "$(nos_etc_dir)/nginx/nginx.conf" \
  "$(php_nginx_conf_payload)"
}

php_nginx_conf_payload() {
  _nginx_document_root=$(php_nginx_document_root)
  _nginx_directory_index=$(php_nginx_directory_index)
  _nginx_default_gateway=$(php_nginx_default_gateway)
  nos_print_bullet_sub "Document root: ${_nginx_document_root}"
  nos_print_bullet_sub "Directory index: ${_nginx_directory_index}"
  nos_print_bullet_sub "Default application gateway: ${_nginx_default_gateway}"
  cat <<-END
{
  "deploy_dir": "$(nos_deploy_dir)",
  "domains": $(php_domains),
  "live_dir": "$(nos_live_dir)",
  "document_root": "${_nginx_document_root}",
  "directory_index": "${_nginx_directory_index}",
  "default_gateway": "${_nginx_default_gateway}",
  "env_vars": $(php_env_vars)
}
END
}

php_nginx_document_root() {
  # boxfile nginx_document_root
  document_root=$(nos_validate "$(nos_payload boxfile_nginx_document_root)" "folder" "$(nos_validate "$(nos_payload boxfile_document_root)" "folder" "/")")

  if [[ ${document_root:0:1} = '/' ]]; then
    echo $document_root
  else 
    echo /$document_root
  fi
}

php_nginx_directory_index() {
  # boxfile nginx_index_list
  index_list=$(nos_validate "$(nos_payload boxfile_nginx_index_list)" "string" "index.html index.php")
  for i in $index_list; do
    ignore=$(nos_validate "$i" "file" "")
  done
  echo "$index_list"
}

php_nginx_default_gateway() {
  # boxfile nginx_default_gateway
  default_gateway=$(nos_validate "$(nos_payload boxfile_nginx_default_gateway)" "file" "index.php")
  echo "$default_gateway"
}

php_install_nginx() {
  nos_install "nginx"
}

php_configure_nginx() {
  nos_print_process_start "Configuring Nginx"
  mkdir -p $(etc_dir)/nginx
  mkdir -p $(deploy_dir)/var/log/nginx
  mkdir -p $(deploy_dir)/var/tmp/nginx/client_body_temp
  mkdir -p $(deploy_dir)/var/run
  mkdir -p $(deploy_dir)/var/tmp
  php_nginx_create_ngnix_conf
}