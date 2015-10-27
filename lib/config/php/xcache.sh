# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_php_xcache_ini() {
  template \
    "php/php.d/xcache.ini.mustache" \
    "$(payload 'etc_dir')/php.d/xcache.ini" \
    "$(xcache_ini_payload)"
}

xcache_ini_payload() {
  cat <<-END
{
  "xcache_size": "$(xcache_size)",
  "xcache_var_size": "$(xcache_var_size)",
  "xcache_admin_user": "$(xcache_admin_user)",
  "xcache_admin_pass": "$(xcache_admin_pass)"
}
END
}

xcache_size() {
  # boxfile php_xcache_size
  php_xcache_size=$(validate "$(payload boxfile_php_xcache_size)" "byte" "64M")
  >&2 echo "   Using ${php_xcache_size} as XCache size"
  echo "$php_xcache_size"
}

xcache_var_size() {
  # boxfile php_xcache_var_size
  php_xcache_var_size=$(validate "$(payload boxfile_php_xcache_var_size)" "byte" "64M")
  >&2 echo "   Using ${php_xcache_var_size} as XCache var size"
  echo "$php_xcache_var_size"
}

xcache_admin_user() {
  # boxfile php_xcache_admin_user
  php_xcache_admin_user=$(validate "$(payload boxfile_php_xcache_admin_user)" "string" "")
  >&2 echo "   Using '${php_xcache_admin_user}' as XCache admin user"
  echo "$php_xcache_admin_user"
}

xcache_admin_pass() {
  # boxfile php_xcache_admin_pass
  php_xcache_admin_pass=$(validate "$(payload boxfile_php_xcache_admin_pass)" "string" "e0817d5307b3e779a428ea10b50f4441")
  >&2 echo "   Using ${php_xcache_admin_pass} as XCache admin password"
  echo "$php_xcache_admin_pass"
}