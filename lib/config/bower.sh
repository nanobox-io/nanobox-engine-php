has_bower() {
  [[ -f $(code_dir)/bower.json ]] && echo "true" || echo "false"
}

install_bower() {
  [[ "$(has_bower)" = "true" ]] && (cd $(code_dir); print_bullet_info "Found bower.json, installing bower"; run_process "npm install bower" "npm install bower") || print_bullet_info "Did not find bower.json, not installing bower"
}

bower_install() {
  [[ "$(has_bower)" = "true" ]] && (cd $(code_dir); print_bullet_info "Found bower.json, running 'bower install'";run_process "bower install" "node_modules/.bin/bower --config.interactive=false install") || print_bullet_info "Did not find bower.json, not running bower install"
}