# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

php_create_php_mongo_ini() {
  nos_print_bullet "Generating mongo.ini"
  nos_template \
    "php/php.d/mongo.ini.mustache" \
    "$(nos_etc_dir)/php.d/mongo.ini" \
    "$(php_mongo_ini_payload)"
}

php_mongo_ini_payload() {
  _mongo_native_long=$(php_mongo_native_long)
  _mongo_allow_empty_keys=$(php_mongo_allow_empty_keys)
  _mongo_cmd=$(php_mongo_cmd)
  _mongo_long_as_object=$(php_mongo_long_as_object)
  nos_print_bullet_sub "Native long: ${_mongo_native_long}"
  nos_print_bullet_sub "Allow empty keys: ${_mongo_allow_empty_keys}"
  nos_print_bullet_sub "Cmd: ${_mongo_cmd}"
  nos_print_bullet_sub "Long as object: ${_mongo_long_as_object}"
  cat <<-END
{
  "mongo_native_long": "${_mongo_native_long}",
  "mongo_allow_empty_keys": "${_mongo_allow_empty_keys}",
  "mongo_cmd": "${_mongo_cmd}",
  "mongo_long_as_object": "${_mongo_long_as_object}"
}
END
}

php_mongo_native_long() {
  # boxfile php_mongo_native_long
  _php_mongo_native_long=$(nos_validate "$(nos_payload boxfile_php_mongo_native_long)" "integer" "1")
  echo "$_php_mongo_native_long"
}

php_mongo_allow_empty_keys() {
  # boxfile php_mongo_allow_empty_keys
  _php_mongo_allow_empty_keys=$(nos_validate "$(nos_payload boxfile_php_mongo_allow_empty_keys)" "integer" "0")
  echo "$_php_mongo_allow_empty_keys"
}

php_mongo_cmd() {
  # boxfile php_mongo_cmd
  _php_mongo_cmd=$(nos_validate "$(nos_payload boxfile_php_mongo_cmd)" "string" "\$")
  echo "$_php_mongo_cmd"
}

php_mongo_long_as_object() {
  # boxfile php_mongo_long_as_object
  _php_mongo_long_as_object=$(nos_validate "$(nos_payload boxfile_php_mongo_long_as_object)" "integer" "0")
  echo "$_php_mongo_long_as_object"
}