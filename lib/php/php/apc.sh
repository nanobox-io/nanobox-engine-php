# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

php_create_php_apc_ini() {
  nos_print_bullet "Generating apc.ini"
  nos_template \
    "php/php.d/apc.ini.mustache" \
    "$(nos_etc_dir)/php.d/apc.ini" \
    "$(php_apc_ini_payload)"
}

php_apc_ini_payload() {
  _apc_shm_size=$(php_apc_shm_size)
  _apc_num_files_hint=$(php_apc_num_files_hint)
  _apc_user_entries_hint=$(php_apc_user_entries_hint)
  _apc_filters=$(php_apc_filters)
  nos_print_bullet_sub "Shm size: ${_apc_shm_size}"
  nos_print_bullet_sub "Num files hint: ${_apc_num_files_hint}"
  nos_print_bullet_sub "User entries hint: ${_apc_user_entries_hint}"
  nos_print_bullet_sub "Filters: ${_apc_filters}"
  cat <<-END
{
  "apc_shm_size": "${_apc_shm_size}",
  "apc_num_files_hint": "${_apc_num_files_hint}",
  "apc_user_entries_hint": "${_apc_user_entries_hint}",
  "apc_filters": "${_apc_filters}"
}
END
}

php_apc_shm_size() {
  # boxfile php_apc_shm_size
  _php_apc_shm_size=$(nos_validate "$(nos_payload boxfile_php_apc_shm_size)" "byte" "128M")
  echo "$_php_apc_shm_size"
}

php_apc_num_files_hint() {
  # boxfile php_apc_num_files_hint
  _php_apc_num_files_hint=$(nos_validate "$(nos_payload boxfile_php_apc_num_files_hint)" "integer" "0")
  echo "$_php_apc_num_files_hint"
}

php_apc_user_entries_hint() {
  # boxfile php_apc_user_entries_hint
  _php_apc_user_entries_hint=$(nos_validate "$(nos_payload boxfile_php_apc_user_entries_hint)" "integer" "0")
  echo "$_php_apc_user_entries_hint"
}

php_apc_filters() {
  # boxfile php_apc_filters
  _php_apc_filters=$(nos_validate "$(nos_payload boxfile_php_apc_filters)" "string" "")
  echo "$_php_apc_filters"
}