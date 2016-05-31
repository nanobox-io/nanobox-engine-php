# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_opcache_ini() {
  nos_print_bullet "Generating opcache.ini"
  nos_template \
    "php/php.d/opcache.ini.mustache" \
    "$(nos_etc_dir)/php.d/opcache.ini" \
    "$(opcache_ini_payload)"
}

opcache_ini_payload() {
  _opcache_memory_consumption=$(opcache_memory_consumption)
  _opcache_validate_timestamps=$(opcache_validate_timestamps)
  _opcache_revalidate_freq=$(opcache_revalidate_freq)
  _opcache_revalidate_path=$(opcache_revalidate_path)
  _opcache_save_comments=$(opcache_save_comments)
  _opcache_load_comments=$(opcache_load_comments)
  _opcache_enable_file_override=$(opcache_enable_file_override)
  _opcache_optimization_level=$(opcache_optimization_level)
  _opcache_dups_fix=$(opcache_dups_fix)
  _opcache_blacklist_filename=$(opcache_blacklist_filename)
  nos_print_bullet_sub "Memory consumption: ${_opcache_memory_consumption}"
  nos_print_bullet_sub "Validate timestamps: ${_opcache_validate_timestamps}"
  nos_print_bullet_sub "Revalidate freq: ${_opcache_revalidate_freq}"
  nos_print_bullet_sub "Revalidate path: ${_opcache_revalidate_path}"
  nos_print_bullet_sub "Save comments: ${_opcache_save_comments}"
  nos_print_bullet_sub "Load comments: ${_opcache_load_comments}"
  nos_print_bullet_sub "Enable file override: ${_opcache_enable_file_override}"
  nos_print_bullet_sub "Optimization level: ${_opcache_optimization_level}"
  nos_print_bullet_sub "Dups fix: ${_opcache_dups_fix}"
  nos_print_bullet_sub "Blacklist filename: ${_opcache_blacklist_filename}"
  cat <<-END
{
  "opcache_memory_consumption": "${_opcache_memory_consumption}",
  "opcache_validate_timestamps": "${_opcache_validate_timestamps}",
  "opcache_revalidate_freq": "${_opcache_revalidate_freq}",
  "opcache_revalidate_path": "${_opcache_revalidate_path}",
  "opcache_save_comments": "${_opcache_save_comments}",
  "opcache_load_comments": "${_opcache_load_comments}",
  "opcache_enable_file_override": "${_opcache_enable_file_override}",
  "opcache_optimization_level": "${_opcache_optimization_level}",
  "opcache_dups_fix": "${_opcache_dups_fix}",
  "opcache_blacklist_filename": "${_opcache_blacklist_filename}"
}
END
}

opcache_memory_consumption() {
  # boxfile opcache_memory_consumption
  _opcache_memory_consumption=$(nos_validate "$(nos_payload boxfile_opcache_memory_consumption)" "integer" "128")
  echo "$_opcache_memory_consumption"
}

opcache_validate_timestamps() {
  # boxfile opcache_validate_timestamps
  _opcache_validate_timestamps=$(nos_validate "$(nos_payload boxfile_opcache_validate_timestamps)" "boolean" "0")
  echo "$_opcache_validate_timestamps"
}

opcache_revalidate_freq() {
  # boxfile opcache_revalidate_freq
  _opcache_revalidate_freq=$(nos_validate "$(nos_payload boxfile_opcache_revalidate_freq)" "integer" "0")
  echo "$_opcache_revalidate_freq"
}

opcache_revalidate_path() {
  # boxfile opcache_revalidate_path
  _opcache_revalidate_path=$(nos_validate "$(nos_payload boxfile_opcache_revalidate_path)" "integer" "0")
  echo "$_opcache_revalidate_path"
}

opcache_save_comments() {
  # boxfile opcache_save_comments
  _opcache_save_comments=$(nos_validate "$(nos_payload boxfile_opcache_save_comments)" "boolean" "1")
  echo "$_opcache_save_comments"
}

opcache_load_comments() {
  # boxfile opcache_load_comments
  _opcache_load_comments=$(nos_validate "$(nos_payload boxfile_opcache_load_comments)" "boolean" "1")
  echo "$_opcache_load_comments"
}

opcache_enable_file_override() {
  # boxfile opcache_enable_file_override
  _opcache_enable_file_override=$(nos_validate "$(nos_payload boxfile_opcache_enable_file_override)" "boolean" "0")
  echo "$_opcache_enable_file_override"
}

opcache_optimization_level() {
  # boxfile opcache_optimization_level
  _opcache_optimization_level=$(nos_validate "$(nos_payload boxfile_opcache_optimization_level)" "string" "0xffffffff")
  echo "$_opcache_optimization_level"
}

opcache_dups_fix() {
  # boxfile opcache_dups_fix
  _opcache_dups_fix=$(nos_validate "$(nos_payload boxfile_opcache_dups_fix)" "boolean" "0")
  echo "$_opcache_dups_fix"
}

opcache_blacklist_filename() {
  # boxfile opcache_blacklist_filename
  _opcache_blacklist_filename=$(nos_validate "$(nos_payload boxfile_opcache_blacklist_filename)" "string" "")
  echo "$_opcache_blacklist_filename"
}
