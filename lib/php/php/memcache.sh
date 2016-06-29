# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

generate_memcache_ini() {
  
  # Report back to the user
  report_memcache_settings
  
  nos_template \
    "php/php.d/memcache.ini.mustache" \
    "$(nos_etc_dir)/php.d/memcache.ini" \
    "$(memcache_ini_payload)"
}

report_memcache_settings() {
  nos_print_bullet_sub "Chunk size: $(memcache_chunk_size)"
  nos_print_bullet_sub "Hash strategy: $(memcache_hash_strategy)"  
}

memcache_ini_payload() {
  cat <<-END
{
  "memcache_chunk_size": "$(memcache_chunk_size)",
  "memcache_hash_strategy": "$(memcache_hash_strategy)"
}
END
}

memcache_chunk_size() {
  # boxfile memcache_chunk_size
  _memcache_chunk_size=$(nos_validate "$(nos_payload config_memcache_chunk_size)" "integer" "32768")
  echo "$_memcache_chunk_size"
}

memcache_hash_strategy() {
  # boxfile memcache_hash_strategy
  _memcache_hash_strategy=$(nos_validate "$(nos_payload config_memcache_hash_strategy)" "string" "standard")
  echo "$_memcache_hash_strategy"
}
