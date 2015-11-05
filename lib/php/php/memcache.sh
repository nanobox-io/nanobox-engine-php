# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

php_create_php_memcache_ini() {
  nos_print_bullet "Generating memcache.ini"
  nos_template \
    "php/php.d/memcache.ini.mustache" \
    "$(nos_etc_dir)/php.d/memcache.ini" \
    "$(php_memcache_ini_payload)"
}

php_memcache_ini_payload() {
  _memcache_chunk_size=$(php_memcache_chunk_size)
  _memcache_hash_strategy=$(php_memcache_hash_strategy)
  nos_print_bullet_sub "Chunk size: ${_memcache_chunk_size}"
  nos_print_bullet_sub "Hash strategy: ${_memcache_hash_strategy}"
  cat <<-END
{
  "memcache_chunk_size": "${_memcache_chunk_size}",
  "memcache_hash_strategy": "${_memcache_hash_strategy}"
}
END
}

php_memcache_chunk_size() {
  # boxfile php_memcache_chunk_size
  _php_memcache_chunk_size=$(nos_validate "$(nos_payload boxfile_php_memcache_chunk_size)" "integer" "32768")
  echo "$_php_memcache_chunk_size"
}

php_memcache_hash_strategy() {
  # boxfile php_memcache_hash_strategy
  _php_memcache_hash_strategy=$(nos_validate "$(nos_payload boxfile_php_memcache_hash_strategy)" "string" "standard")
  echo "$_php_memcache_hash_strategy"
}