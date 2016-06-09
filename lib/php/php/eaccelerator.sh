# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_eaccelerator_ini() {
  nos_print_bullet "Generating eaccelerator.ini"
  nos_template \
    "php/php.d/eaccelerator.ini.mustache" \
    "$(nos_etc_dir)/php.d/eaccelerator.ini" \
    "$(eaccelerator_ini_payload)"
}

eaccelerator_ini_payload() {
  _eaccelerator_shm_max=$(eaccelerator_shm_max)
  _eaccelerator_shm_size=$(eaccelerator_shm_size)
  _eaccelerator_filter=$(eaccelerator_filter)
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

eaccelerator_shm_max() {
  # boxfile eaccelerator_shm_max
  _eaccelerator_shm_max=$(nos_validate "$(nos_payload config_eaccelerator_shm_max)" "integer" "128")
  echo "$_eaccelerator_shm_max"
}

eaccelerator_shm_size() {
  # boxfile eaccelerator_shm_size
  _eaccelerator_shm_size=$(nos_validate "$(nos_payload config_eaccelerator_shm_size)" "integer" "128")
  echo "$_eaccelerator_shm_size"
}

eaccelerator_filter() {
  # boxfile eaccelerator_filter
  _eaccelerator_filter=$(nos_validate "$(nos_payload config_eaccelerator_filter)" "string" "")
  echo "$_eaccelerator_filter"
}