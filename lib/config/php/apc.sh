# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_php_apc_ini() {
  print_bullet "Generating apc.ini"
  template \
    "php/php.d/apc.ini.mustache" \
    "$(payload 'etc_dir')/php.d/apc.ini" \
    "$(apc_ini_payload)"
}

apc_ini_payload() {
  _apc_shm_size=$(apc_shm_size)
  _apc_num_files_hint=$(apc_num_files_hint)
  _apc_user_entries_hint=$(apc_user_entries_hint)
  _apc_filters=$(apc_filters)
  print_bullet_sub "Shm size: ${_apc_shm_size}"
  print_bullet_sub "Num files hint: ${_apc_num_files_hint}"
  print_bullet_sub "User entries hint: ${_apc_user_entries_hint}"
  print_bullet_sub "Filters: ${_apc_filters}"
  cat <<-END
{
  "apc_shm_size": "${_apc_shm_size}",
  "apc_num_files_hint": "${_apc_num_files_hint}",
  "apc_user_entries_hint": "${_apc_user_entries_hint}",
  "apc_filters": "${_apc_filters}"
}
END
}

apc_shm_size() {
  # boxfile php_apc_shm_size
  php_apc_shm_size=$(validate "$(payload boxfile_php_apc_shm_size)" "byte" "128M")
  echo "$php_apc_shm_size"
}

apc_num_files_hint() {
  # boxfile php_apc_num_files_hint
  php_apc_num_files_hint=$(validate "$(payload boxfile_php_apc_num_files_hint)" "integer" "0")
  echo "$php_apc_num_files_hint"
}

apc_user_entries_hint() {
  # boxfile php_apc_user_entries_hint
  php_apc_user_entries_hint=$(validate "$(payload boxfile_php_apc_user_entries_hint)" "integer" "0")
  echo "$php_apc_user_entries_hint"
}

apc_filters() {
  # boxfile php_apc_filters
  php_apc_filters=$(validate "$(payload boxfile_php_apc_filters)" "string" "")
  echo "$php_apc_filters"
}