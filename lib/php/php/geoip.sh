# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_geoip_ini() {
  nos_print_bullet "Generating geoip.ini"
  nos_template \
    "php/php.d/geoip.ini.mustache" \
    "$(nos_etc_dir)/php.d/geoip.ini" \
    "$(geoip_ini_payload)"
}

geoip_ini_payload() {
  _geoip_custom_directory=$(geoip_custom_directory)
  nos_print_bullet_sub "Custom directory: ${_geoip_custom_directory}"
  cat <<-END
{
  "geoip_custom_directory": "${_geoip_custom_directory}"
}
END
}

geoip_custom_directory() {
  # boxfile geoip_custom_directory
  _geoip_custom_directory=$(nos_validate "$(nos_payload config_geoip_custom_directory)" "folder" "")
  echo "$_geoip_custom_directory"
}