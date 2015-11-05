# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

php_create_php_geoip_ini() {
  nos_print_bullet "Generating geoip.ini"
  nos_template \
    "php/php.d/geoip.ini.mustache" \
    "$(nos_etc_dir)/php.d/geoip.ini" \
    "$(php_geoip_ini_payload)"
}

php_geoip_ini_payload() {
  _geoip_custom_directory=$(php_geoip_custom_directory)
  nos_print_bullet_sub "Custom directory: ${_geoip_custom_directory}"
  cat <<-END
{
  "geoip_custom_directory": "${_geoip_custom_directory}"
}
END
}

php_geoip_custom_directory() {
  # boxfile php_geoip_custom_directory
  _php_geoip_custom_directory=$(nos_validate "$(nos_payload boxfile_php_geoip_custom_directory)" "folder" "")
  echo "$_php_geoip_custom_directory"
}