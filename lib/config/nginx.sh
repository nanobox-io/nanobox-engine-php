# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_ngnix_conf() {
  template \
  "nginx/nginx.conf.mustache" \
  "$(payload 'etc_dir')/nginx/nginx.conf" \
  "$(nginx_conf_payload)"
}

nginx_conf_payload() {
  cat <<-END
{
  "deploy_dir": "$(deploy_dir)",
  "domains": $(domains),
  "live_dir": "$(live_dir)",
  "document_root": "$(nginx_document_root)",
  "directory_index": "$(nginx_directory_index)",
  "default_gateway": "$(nginx_default_gateway)",
  "env_vars": $(env_vars)
}
END
}

nginx_document_root() {
  # boxfile nginx_document_root
  document_root=$(validate "$(payload boxfile_nginx_document_root)" "folder" "$(validate "$(payload boxfile_document_root)" "folder" "/")")

  if [[ ${document_root:0:1} = '/' ]]; then
    >&2 echo "Using $document_root as the Nginx document root" 
    echo $document_root
  else
    >&2 echo "Using /$document_root as the Nginx document root" 
    echo /$document_root
  fi
}

nginx_directory_index() {
  # boxfile nginx_index_list
  index_list=$(validate "$(payload boxfile_nginx_index_list)" "string" "index.html index.php")
  for i in $index_list; do
    ignore=$(validate "$i" "file" "")
  done
  >&2 echo "Using ${index_list} as the index list"
  echo "$index_list"
}

nginx_default_gateway() {
  # boxfile nginx_default_gateway
  default_gateway=$(validate "$(payload boxfile_nginx_default_gateway)" "file" "index.php")
  >&2 echo "Using ${default_gateway} as the default application gateway"
  echo "$default_gateway"
}

install_nginx() {
  install "nginx"
}

configure_nginx() {
  print_bullet_info "Configuring Nginx"
  mkdir -p $(etc_dir)/nginx
  mkdir -p $(deploy_dir)/var/log/nginx
  mkdir -p $(deploy_dir)/var/tmp/nginx/client_body_temp
  mkdir -p $(deploy_dir)/var/run
  mkdir -p $(deploy_dir)/var/tmp
  create_ngnix_conf
}