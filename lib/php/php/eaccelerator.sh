# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

php_create_php_eaccelerator_ini() {
  nos_print_bullet "Generating eaccelerator.ini"
  nos_template \
    "php/php.d/eaccelerator.ini.mustache" \
    "$(nos_etc_dir)/php.d/eaccelerator.ini" \
    "$(php_eaccelerator_ini_payload)"
}

php_eaccelerator_ini_payload() {
  _eaccelerator_shm_max=$(php_eaccelerator_shm_max)
  _eaccelerator_shm_size=$(php_eaccelerator_shm_size)
  _eaccelerator_filter=$(php_eaccelerator_filter)
  nos_print_bullet_sub "Shm max: ${_eaccelerator_shm_max}"
  nos_print_bullet_sub "Shm size: ${_eaccelerator_shm_size}"
  nos_print_bullet_sub "Filter: ${_eaccelerator_filter}"
  cat <<-END
{
  "eaccelerator_shm_max": "${_eaccelerator_shm_max}",
  "eaccelerator_shm_size": "${_eaccelerator_shm_size}",
  "eaccelerator_filter": "${_eaccelerator_filter}"
}
END
}

php_eaccelerator_shm_max() {
  # boxfile php_eaccelerator_shm_max
  _php_eaccelerator_shm_max=$(nos_validate "$(nos_payload boxfile_php_eaccelerator_shm_max)" "integer" "128")
  echo "$_php_eaccelerator_shm_max"
}

php_eaccelerator_shm_size() {
  # boxfile php_eaccelerator_shm_size
  _php_eaccelerator_shm_size=$(nos_validate "$(nos_payload boxfile_php_eaccelerator_shm_size)" "integer" "128")
  echo "$_php_eaccelerator_shm_size"
}

php_eaccelerator_filter() {
  # boxfile php_eaccelerator_filter
  _php_eaccelerator_filter=$(nos_validate "$(nos_payload boxfile_php_eaccelerator_filter)" "string" "")
  echo "$_php_eaccelerator_filter"
}