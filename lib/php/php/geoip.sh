# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

generate_geoip_ini() {
  
  # Report back to the user
  report_geoip_settings
  
  nos_template \
    "php/php.d/geoip.ini.mustache" \
    "$(nos_etc_dir)/php.d/geoip.ini" \
    "$(geoip_ini_payload)"
}

report_geoip_settings() {
  nos_print_bullet_sub "Custom directory: $(geoip_custom_directory)"
}

geoip_ini_payload() {
  cat <<-END
{
  "geoip_custom_directory": "$(geoip_custom_directory)"
}
END
}

geoip_custom_directory() {
  # boxfile geoip_custom_directory
  _geoip_custom_directory=$(nos_validate "$(nos_payload config_geoip_custom_directory)" "folder" "")
  echo "$_geoip_custom_directory"
}
