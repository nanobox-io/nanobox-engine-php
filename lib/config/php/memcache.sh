# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_php_memcache_ini() {
  print_bullet "Generating memcache.ini"
  template \
    "php/php.d/memcache.ini.mustache" \
    "$(payload 'etc_dir')/php.d/memcache.ini" \
    "$(memcache_ini_payload)"
}

memcache_ini_payload() {
  _memcache_chunk_size=$(memcache_chunk_size)
  _memcache_hash_strategy=$(memcache_hash_strategy)
  print_bullet_sub "Chunk size: ${_memcache_chunk_size}"
  print_bullet_sub "Hash strategy: ${_memcache_hash_strategy}"
  cat <<-END
{
  "memcache_chunk_size": "${_memcache_chunk_size}",
  "memcache_hash_strategy": "${_memcache_hash_strategy}"
}
END
}

memcache_chunk_size() {
  # boxfile php_memcache_chunk_size
  php_memcache_chunk_size=$(validate "$(payload boxfile_php_memcache_chunk_size)" "integer" "32768")
  echo "$php_memcache_chunk_size"
}

memcache_hash_strategy() {
  # boxfile php_memcache_hash_strategy
  php_memcache_hash_strategy=$(validate "$(payload boxfile_php_memcache_hash_strategy)" "string" "standard")
  echo "$php_memcache_hash_strategy"
}