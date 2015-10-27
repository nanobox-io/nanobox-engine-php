# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_php_eaccelerator_ini() {
  template \
    "php/php.d/eaccelerator.ini.mustache" \
    "$(payload 'etc_dir')/php.d/eaccelerator.ini" \
    "$(eaccelerator_ini_payload)"
}

eaccelerator_ini_payload() {
  cat <<-END
{
  "eaccelerator_shm_max": "$(eaccelerator_shm_max)",
  "eaccelerator_shm_size": "$(eaccelerator_shm_size)",
  "eaccelerator_filter": "$(eaccelerator_filter)"
}
END
}

eaccelerator_shm_max() {
  # boxfile php_eaccelerator_shm_max
  php_eaccelerator_shm_max=$(validate "$(payload boxfile_php_eaccelerator_shm_max)" "integer" "128")
  >&2 echo "Using ${php_eaccelerator_shm_max} as eAccelerator shm max"
  echo "$php_eaccelerator_shm_max"
}

eaccelerator_shm_size() {
  # boxfile php_eaccelerator_shm_size
  php_eaccelerator_shm_size=$(validate "$(payload boxfile_php_eaccelerator_shm_size)" "integer" "128")
  >&2 echo "Using ${php_eaccelerator_shm_size} as eAccelerator shm size"
  echo "$php_eaccelerator_shm_size"
}

eaccelerator_filter() {
  # boxfile php_eaccelerator_filter
  php_eaccelerator_filter=$(validate "$(payload boxfile_php_eaccelerator_filter)" "string" "")
  >&2 echo "Using ${php_eaccelerator_filter} as eAccelerator filter"
  echo "$php_eaccelerator_filter"
}