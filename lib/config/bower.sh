# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

has_bower() {
  if [[ -f $(code_dir)/bower.json ]]; then
    echo "true"
  else
    echo "false"
  fi
}

install_bower() {
  if [[ "$(has_bower)" = "true" ]]; then
    print_bullet_info "Found bower.json, installing bower"
    (cd $(code_dir); run_process "npm install bower" "npm install bower")
  fi
}

bower_install() {
  if [[ "$(has_bower)" = "true" ]]; then
    print_bullet_info "Found bower.json, running 'bower install'"
    (cd $(code_dir); run_process "bower install" "node_modules/.bin/bower --config.interactive=false install")
  fi
}