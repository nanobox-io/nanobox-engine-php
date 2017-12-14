# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# Packages required to install composer
composer_packages() {
  pkgs=("composer")
  echo "${pkgs[@]}"
}

composer_required_extensions() {
  exts=("phar" "json" "filter" "hash")
  echo "${exts[@]}"
}

composer_use_prestissimo() {
  # boxfile composer_use_prestissimo
  composer_use_prestissimo=$(nos_validate "$(nos_payload config_composer_use_prestissimo)" "boolean" "false")
  echo "$composer_use_prestissimo"
}

# Runs composer install
composer_install() {
  if [[ -f $(nos_code_dir)/composer.json ]]; then
    if [[ ! -f $(nos_code_dir)/composer.lock ]]; then
      nos_print_warning "No 'composer.lock' file detected. This may cause a slow or failed build. To avoid this issue, commit the 'composer.lock' file to your git repo."
    fi
    if [[ "$(composer_use_prestissimo)" = "true" ]]; then
      (cd $(nos_code_dir); nos_run_process "composer global require hirak/prestissimo" "composer global require hirak/prestissimo")
    fi
    (cd $(nos_code_dir); nos_run_process "composer install" "composer install --no-interaction --prefer-source")
  fi
}
