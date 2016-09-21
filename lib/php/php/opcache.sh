# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

generate_opcache_ini() {
  
  # Report back to the user
  report_opcache_settings
  
  nos_template \
    "php/php.d/opcache.ini.mustache" \
    "$(nos_etc_dir)/php.prod.d/opcache.ini" \
    "$(opcache_ini_payload)"
}

generate_opcache_ini() {
  nos_template \
    "php/php.d/opcache.ini.mustache" \
    "$(nos_etc_dir)/php.dev.d/opcache.ini" \
    "$(opcache_ini_payload)"
}

report_opcache_settings() {
  nos_print_bullet_sub "Memory consumption: $(opcache_memory_consumption)"
  nos_print_bullet_sub "Validate timestamps: $(opcache_validate_timestamps)"
  nos_print_bullet_sub "Revalidate freq: $(opcache_revalidate_freq)"
  nos_print_bullet_sub "Revalidate path: $(opcache_revalidate_path)"
  nos_print_bullet_sub "Save comments: $(opcache_save_comments)"
  nos_print_bullet_sub "Load comments: $(opcache_load_comments)"
  nos_print_bullet_sub "Enable file override: $(opcache_enable_file_override)"
  nos_print_bullet_sub "Optimization level: $(opcache_optimization_level)"
  nos_print_bullet_sub "Dups fix: $(opcache_dups_fix)"
  nos_print_bullet_sub "Blacklist filename: $(opcache_blacklist_filename)"
}

opcache_ini_payload() {
  cat <<-END
{
  "opcache_memory_consumption": "$(opcache_memory_consumption)",
  "opcache_validate_timestamps": "$(opcache_validate_timestamps)",
  "opcache_revalidate_freq": "$(opcache_revalidate_freq)",
  "opcache_revalidate_path": "$(opcache_revalidate_path)",
  "opcache_save_comments": "$(opcache_save_comments)",
  "opcache_load_comments": "$(opcache_load_comments)",
  "opcache_enable_file_override": "$(opcache_enable_file_override)",
  "opcache_optimization_level": "$(opcache_optimization_level)",
  "opcache_dups_fix": "$(opcache_dups_fix)",
  "opcache_blacklist_filename": "$(opcache_blacklist_filename)"
}
END
}

opcache_memory_consumption() {
  # boxfile opcache_memory_consumption
  _opcache_memory_consumption=$(nos_validate "$(nos_payload config_opcache_memory_consumption)" "integer" "128")
  echo "$_opcache_memory_consumption"
}

opcache_validate_timestamps() {
  # boxfile opcache_validate_timestamps
  _opcache_validate_timestamps=$(nos_validate "$(nos_payload config_opcache_validate_timestamps)" "boolean" "0")
  echo "$_opcache_validate_timestamps"
}

opcache_revalidate_freq() {
  # boxfile opcache_revalidate_freq
  _opcache_revalidate_freq=$(nos_validate "$(nos_payload config_opcache_revalidate_freq)" "integer" "0")
  echo "$_opcache_revalidate_freq"
}

opcache_revalidate_path() {
  # boxfile opcache_revalidate_path
  _opcache_revalidate_path=$(nos_validate "$(nos_payload config_opcache_revalidate_path)" "integer" "0")
  echo "$_opcache_revalidate_path"
}

opcache_save_comments() {
  # boxfile opcache_save_comments
  _opcache_save_comments=$(nos_validate "$(nos_payload config_opcache_save_comments)" "boolean" "1")
  echo "$_opcache_save_comments"
}

opcache_load_comments() {
  # boxfile opcache_load_comments
  _opcache_load_comments=$(nos_validate "$(nos_payload config_opcache_load_comments)" "boolean" "1")
  echo "$_opcache_load_comments"
}

opcache_enable_file_override() {
  # boxfile opcache_enable_file_override
  _opcache_enable_file_override=$(nos_validate "$(nos_payload config_opcache_enable_file_override)" "boolean" "0")
  echo "$_opcache_enable_file_override"
}

opcache_optimization_level() {
  # boxfile opcache_optimization_level
  _opcache_optimization_level=$(nos_validate "$(nos_payload config_opcache_optimization_level)" "string" "0xffffffff")
  echo "$_opcache_optimization_level"
}

opcache_dups_fix() {
  # boxfile opcache_dups_fix
  _opcache_dups_fix=$(nos_validate "$(nos_payload config_opcache_dups_fix)" "boolean" "0")
  echo "$_opcache_dups_fix"
}

opcache_blacklist_filename() {
  # boxfile opcache_blacklist_filename
  _opcache_blacklist_filename=$(nos_validate "$(nos_payload config_opcache_blacklist_filename)" "string" "")
  echo "$_opcache_blacklist_filename"
}
