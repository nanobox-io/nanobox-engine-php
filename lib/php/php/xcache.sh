# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_xcache_ini() {
  nos_print_bullet "Generating xcache.ini"
  nos_template \
    "php/php.d/xcache.ini.mustache" \
    "$(nos_etc_dir)/php.d/xcache.ini" \
    "$(xcache_ini_payload)"
}

xcache_ini_payload() {
  _xcache_size=$(xcache_size)
  _xcache_var_size=$(xcache_var_size)
  _xcache_admin_user=$(xcache_admin_user)
  _xcache_admin_pass=$(xcache_admin_pass)
  nos_print_bullet_sub "Size: ${_xcache_size}"
  nos_print_bullet_sub "Var size: ${_xcache_var_size}"
  nos_print_bullet_sub "Admin user: ${_xcache_admin_user}"
  nos_print_bullet_sub "Admin password: ${_xcache_admin_pass}"
  cat <<-END
{
  "xcache_size": "${_xcache_size}",
  "xcache_var_size": "${_xcache_var_size}",
  "xcache_admin_user": "${_xcache_admin_user}",
  "xcache_admin_pass": "${_xcache_admin_pass}"
}
END
}

xcache_size() {
  # boxfile xcache_size
  _xcache_size=$(nos_validate "$(nos_payload boxfile_xcache_size)" "byte" "64M")
  echo "$_xcache_size"
}

xcache_var_size() {
  # boxfile xcache_var_size
  _xcache_var_size=$(nos_validate "$(nos_payload boxfile_xcache_var_size)" "byte" "64M")
  echo "$_xcache_var_size"
}

xcache_admin_user() {
  # boxfile xcache_admin_user
  _xcache_admin_user=$(nos_validate "$(nos_payload boxfile_xcache_admin_user)" "string" "")
  echo "$_xcache_admin_user"
}

xcache_admin_pass() {
  # boxfile xcache_admin_pass
  _xcache_admin_pass=$(nos_validate "$(nos_payload boxfile_xcache_admin_pass)" "string" "e0817d5307b3e779a428ea10b50f4441")
  echo "$_xcache_admin_pass"
}