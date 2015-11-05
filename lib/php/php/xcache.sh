# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

php_create_php_xcache_ini() {
  print_bullet "Generating xcache.ini"
  template \
    "php/php.d/xcache.ini.mustache" \
    "$(nos_etc_dir)/php.d/xcache.ini" \
    "$(php_xcache_ini_payload)"
}

php_xcache_ini_payload() {
  _xcache_size=$(php_xcache_size)
  _xcache_var_size=$(php_xcache_var_size)
  _xcache_admin_user=$(php_xcache_admin_user)
  _xcache_admin_pass=$(php_xcache_admin_pass)
  print_bullet_sub "Size: ${_xcache_size}"
  print_bullet_sub "Var size: ${_xcache_var_size}"
  print_bullet_sub "Admin user: ${_xcache_admin_user}"
  print_bullet_sub "Admin password: ${_xcache_admin_pass}"
  cat <<-END
{
  "xcache_size": "${_xcache_size}",
  "xcache_var_size": "${_xcache_var_size}",
  "xcache_admin_user": "${_xcache_admin_user}",
  "xcache_admin_pass": "${_xcache_admin_pass}"
}
END
}

php_xcache_size() {
  # boxfile php_xcache_size
  _php_xcache_size=$(nos_validate "$(nos_payload boxfile_php_xcache_size)" "byte" "64M")
  echo "$_php_xcache_size"
}

php_xcache_var_size() {
  # boxfile php_xcache_var_size
  _php_xcache_var_size=$(nos_validate "$(nos_payload boxfile_php_xcache_var_size)" "byte" "64M")
  echo "$_php_xcache_var_size"
}

php_xcache_admin_user() {
  # boxfile php_xcache_admin_user
  _php_xcache_admin_user=$(nos_validate "$(nos_payload boxfile_php_xcache_admin_user)" "string" "")
  echo "$_php_xcache_admin_user"
}

php_xcache_admin_pass() {
  # boxfile php_xcache_admin_pass
  _php_xcache_admin_pass=$(nos_validate "$(nos_payload boxfile_php_xcache_admin_pass)" "string" "e0817d5307b3e779a428ea10b50f4441")
  echo "$_php_xcache_admin_pass"
}