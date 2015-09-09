
create_php_geoip_ini() {
  template \
    "php/php.d/geoip.ini.mustache" \
    "$(payload 'etc_dir')/php.d/geoip.ini" \
    "$(geoip_ini_payload)"
}

geoip_ini_payload() {
  cat <<-END
{
  "geoip_custom_directory": "$(geoip_custom_directory)"
}
END
}

geoip_custom_directory() {
  # boxfile php_geoip_custom_directory
  php_geoip_custom_directory=$(validate "$(payload boxfile_php_geoip_custom_directory)" "folder" "")
  echo "$php_geoip_custom_directory"
}