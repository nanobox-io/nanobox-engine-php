has_bower() {
  [[ -f $(code_dir)/bower.json ]] && echo "true" || echo "false"
}

install_bower() {
  [[ "$(has_bower)" = "true" ]] && (cd $(code_dir); run_process "npm install bower" "npm install bower")
}

bower_install() {
  [[ "$(has_bower)" = "true" ]] && (cd $(code_dir); run_process "bower install" "node_modules/.bin/bower --config.interactive=false install")
}