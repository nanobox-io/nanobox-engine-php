# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_php_apc_ini() {
  template \
    "php/php.d/apc.ini.mustache" \
    "$(payload 'etc_dir')/php.d/apc.ini" \
    "$(apc_ini_payload)"
}

apc_ini_payload() {
  cat <<-END
{
  "apc_shm_size": "$(apc_shm_size)",
  "apc_num_files_hint": "$(apc_num_files_hint)",
  "apc_user_entries_hint": "$(apc_user_entries_hint)",
  "apc_filters": "$(apc_filters)"
}
END
}

apc_shm_size() {
  # boxfile php_apc_shm_size
  php_apc_shm_size=$(validate "$(payload boxfile_php_apc_shm_size)" "byte" "128M")
  >&2 echo "Using ${php_apc_shm_size} as APC shm size"
  echo "$php_apc_shm_size"
}

apc_num_files_hint() {
  # boxfile php_apc_num_files_hint
  php_apc_num_files_hint=$(validate "$(payload boxfile_php_apc_num_files_hint)" "integer" "0")
  >&2 echo "Using ${php_apc_num_files_hint} as APC num files hint"
  echo "$php_apc_num_files_hint"
}

apc_user_entries_hint() {
  # boxfile php_apc_user_entries_hint
  php_apc_user_entries_hint=$(validate "$(payload boxfile_php_apc_user_entries_hint)" "integer" "0")
  >&2 echo "Using ${php_apc_user_entries_hint} as APC user entries hint"
  echo "$php_apc_user_entries_hint"
}

apc_filters() {
  # boxfile php_apc_filters
  php_apc_filters=$(validate "$(payload boxfile_php_apc_filters)" "string" "")
  >&2 echo "Using ${php_apc_filters} as APC filters"
  echo "$php_apc_filters"
}