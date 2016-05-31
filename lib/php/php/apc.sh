# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_apc_ini() {
  nos_print_bullet "Generating apc.ini"
  nos_template \
    "php/php.d/apc.ini.mustache" \
    "$(nos_etc_dir)/php.d/apc.ini" \
    "$(apc_ini_payload)"
}

apc_ini_payload() {
  _apc_shm_size=$(apc_shm_size)
  _apc_num_files_hint=$(apc_num_files_hint)
  _apc_user_entries_hint=$(apc_user_entries_hint)
  _apc_filters=$(apc_filters)
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

apc_shm_size() {
  # boxfile php_apc_shm_size
  _apc_shm_size=$(nos_validate "$(nos_payload boxfile_apc_shm_size)" "byte" "128M")
  echo "$_apc_shm_size"
}

apc_num_files_hint() {
  # boxfile php_apc_num_files_hint
  _apc_num_files_hint=$(nos_validate "$(nos_payload boxfile_apc_num_files_hint)" "integer" "0")
  echo "$_apc_num_files_hint"
}

apc_user_entries_hint() {
  # boxfile php_apc_user_entries_hint
  _apc_user_entries_hint=$(nos_validate "$(nos_payload boxfile_apc_user_entries_hint)" "integer" "0")
  echo "$_apc_user_entries_hint"
}

apc_filters() {
  # boxfile php_apc_filters
  _apc_filters=$(nos_validate "$(nos_payload boxfile_apc_filters)" "string" "")
  echo "$_apc_filters"
}