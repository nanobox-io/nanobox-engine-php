# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_php_opcache_ini() {
  template \
    "php/php.d/opcache.ini.mustache" \
    "$(payload 'etc_dir')/php.d/opcache.ini" \
    "$(opcache_ini_payload)"
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
  # boxfile php_opcache_memory_consumption
  php_opcache_memory_consumption=$(validate "$(payload boxfile_php_opcache_memory_consumption)" "integer" "128")
  >&2 echo "   Using ${php_opcache_memory_consumption} as OPcache memory consumption"
  echo "$php_opcache_memory_consumption"
}

opcache_validate_timestamps() {
  # boxfile php_opcache_validate_timestamps
  php_opcache_validate_timestamps=$(validate "$(payload boxfile_php_opcache_validate_timestamps)" "boolean" "0")
  >&2 echo "   Using ${php_opcache_validate_timestamps} as OPcache validate timestamps"
  echo "$php_opcache_validate_timestamps"
}

opcache_revalidate_freq() {
  # boxfile php_opcache_revalidate_freq
  php_opcache_revalidate_freq=$(validate "$(payload boxfile_php_opcache_revalidate_freq)" "integer" "0")
  >&2 echo "   Using ${php_opcache_revalidate_freq} as OPcache revalidate frequency"
  echo "$php_opcache_revalidate_freq"
}

opcache_revalidate_path() {
  # boxfile php_opcache_revalidate_path
  php_opcache_revalidate_path=$(validate "$(payload boxfile_php_opcache_revalidate_path)" "integer" "0")
  >&2 echo "   Using ${php_opcache_revalidate_path} as OPcache revalidate path"
  echo "$php_opcache_revalidate_path"
}

opcache_save_comments() {
  # boxfile php_opcache_save_comments
  php_opcache_save_comments=$(validate "$(payload boxfile_php_opcache_save_comments)" "boolean" "1")
  >&2 echo "   Using ${php_opcache_save_comments} as OPcache save comments"
  echo "$php_opcache_save_comments"
}

opcache_load_comments() {
  # boxfile php_opcache_load_comments
  php_opcache_load_comments=$(validate "$(payload boxfile_php_opcache_load_comments)" "boolean" "1")
  >&2 echo "   Using ${php_opcache_load_comments} as OPcache load comments"
  echo "$php_opcache_load_comments"
}

opcache_enable_file_override() {
  # boxfile php_opcache_enable_file_override
  php_opcache_enable_file_override=$(validate "$(payload boxfile_php_opcache_enable_file_override)" "boolean" "0")
  >&2 echo "   Using ${php_opcache_enable_file_override} as OPcache enable file override"
  echo "$php_opcache_enable_file_override"
}

opcache_optimization_level() {
  # boxfile php_opcache_optimization_level
  php_opcache_optimization_level=$(validate "$(payload boxfile_php_opcache_optimization_level)" "string" "0xffffffff")
  >&2 echo "   Using ${php_opcache_optimization_level} as OPcache optimization level"
  echo "$php_opcache_optimization_level"
}

opcache_dups_fix() {
  # boxfile php_opcache_dups_fix
  php_opcache_dups_fix=$(validate "$(payload boxfile_php_opcache_dups_fix)" "boolean" "0")
  >&2 echo "   Using ${php_opcache_dups_fix} as OPcache dups fix"
  echo "$php_opcache_dups_fix"
}

opcache_blacklist_filename() {
  # boxfile php_opcache_blacklist_filename
  php_opcache_blacklist_filename=$(validate "$(payload boxfile_php_opcache_blacklist_filename)" "string" "")
  >&2 echo "   Using ${php_opcache_blacklist_filename} as OPcache blacklist filename"
  echo "$php_opcache_blacklist_filename"
}
