# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

php_create_php_newrelic_ini() {
  nos_print_bullet "Generating newrelic.ini"
  nos_template \
    "php/php.d/newrelic.ini.mustache" \
    "$(nos_etc_dir)/php.d/newrelic.ini" \
    "$(php_newrelic_ini_payload)"
}

php_newrelic_ini_payload() {
  _newrelic_capture_params=$(php_newrelic_capture_params)
  _newrelic_ignored_params=$(php_newrelic_ignored_params)
  _newrelic_loglevel=$(php_newrelic_loglevel)
  _newrelic_framework=$(php_newrelic_framework)
  _newrelic_browser_monitoring_auto_instrument=$(php_newrelic_browser_monitoring_auto_instrument)
  _newrelic_framework_drupal_modules=$(php_newrelic_framework_drupal_modules)
  _newrelic_transaction_tracer_detail=$(php_newrelic_transaction_tracer_detail)
  _newrelic_transaction_tracer_enabled=$(php_newrelic_transaction_tracer_enabled)
  _newrelic_transaction_tracer_record_sql=$(php_newrelic_transaction_tracer_record_sql)
  _newrelic_transaction_tracer_threshold=$(php_newrelic_transaction_tracer_threshold)
  _newrelic_transaction_tracer_stack_trace_threshold=$(php_newrelic_transaction_tracer_stack_trace_threshold)
  _newrelic_transaction_tracer_explain_threshold=$(php_newrelic_transaction_tracer_explain_threshold)
  _newrelic_transaction_tracer_slow_sql=$(php_newrelic_transaction_tracer_slow_sql)
  _newrelic_transaction_tracer_custom=$(php_newrelic_transaction_tracer_custom)
  _newrelic_error_collector_enabled=$(php_newrelic_error_collector_enabled)
  _newrelic_error_collector_record_database_errors=$(php_newrelic_error_collector_record_database_errors)
  _newrelic_webtransaction_name_functions=$(php_newrelic_webtransaction_name_functions)
  _newrelic_webtransaction_name_files=$(php_newrelic_webtransaction_name_files)
  _newrelic_webtransaction_name_remove_trailing_path=$(php_newrelic_webtransaction_name_remove_trailing_path)
  nos_print_bullet_sub "Caputure params: ${_newrelic_capture_params}"
  nos_print_bullet_sub "Ignored params: ${_newrelic_ignored_params}"
  nos_print_bullet_sub "Log level: ${_newrelic_loglevel}"
  nos_print_bullet_sub "Framework: ${_newrelic_framework}"
  nos_print_bullet_sub "Browser monitoring auto instrument: ${_newrelic_browser_monitoring_auto_instrument}"
  nos_print_bullet_sub "Framework drupal modules: ${_newrelic_framework_drupal_modules}"
  nos_print_bullet_sub "Transaction tracer detail: ${_newrelic_transaction_tracer_detail}"
  nos_print_bullet_sub "Transaction tracer enabled: ${_newrelic_transaction_tracer_enabled}"
  nos_print_bullet_sub "Transaction tracer record sql: ${_newrelic_transaction_tracer_record_sql}"
  nos_print_bullet_sub "Transaction tracer threshold: ${_newrelic_transaction_tracer_threshold}"
  nos_print_bullet_sub "Transaction tracer stack trace threshold: ${_newrelic_transaction_tracer_stack_trace_threshold}"
  nos_print_bullet_sub "Transaction tracer explain threshold: ${_newrelic_transaction_tracer_explain_threshold}"
  nos_print_bullet_sub "Transaction tracer slow sql: ${_newrelic_transaction_tracer_slow_sql}"
  nos_print_bullet_sub "Transaction tracer custom: ${_newrelic_transaction_tracer_custom}"
  nos_print_bullet_sub "Error collector enabled: ${_newrelic_error_collector_enabled}"
  nos_print_bullet_sub "Error collector record database errors: ${_newrelic_error_collector_record_database_errors}"
  nos_print_bullet_sub "Eebtransaction name functions: ${_newrelic_webtransaction_name_functions}"
  nos_print_bullet_sub "Webtransaction name files: ${_newrelic_webtransaction_name_files}"
  nos_print_bullet_sub "Webtransaction name remove trailing pathprint bullet sub: ${_newrelic_webtransaction_name_remove_trailing_pathnos_print_bullet_sub}"
  cat <<-END
{
  "app_name": "$(php_app_name)",
  "newrelic_license": "$(php_newrelic_license)",
  "newrelic_capture_params": "${_newrelic_capture_params}",
  "newrelic_ignored_params": "${_newrelic_ignored_params}",
  "newrelic_loglevel": "${_newrelic_loglevel}",
  "newrelic_framework": "${_newrelic_framework}",
  "newrelic_browser_monitoring_auto_instrument": "${_newrelic_browser_monitoring_auto_instrument}",
  "newrelic_framework_drupal_modules": "${_newrelic_framework_drupal_modules}",
  "newrelic_transaction_tracer_detail": "${_newrelic_transaction_tracer_detail}",
  "newrelic_transaction_tracer_enabled": "${_newrelic_transaction_tracer_enabled}",
  "newrelic_transaction_tracer_record_sql": "${_newrelic_transaction_tracer_record_sql}",
  "newrelic_transaction_tracer_threshold": "${_newrelic_transaction_tracer_threshold}",
  "newrelic_transaction_tracer_stack_trace_threshold": "${_newrelic_transaction_tracer_stack_trace_threshold}",
  "newrelic_transaction_tracer_explain_threshold": "${_newrelic_transaction_tracer_explain_threshold}",
  "newrelic_transaction_tracer_slow_sql": "${_newrelic_transaction_tracer_slow_sql}",
  "newrelic_transaction_tracer_custom": "${_newrelic_transaction_tracer_custom}",
  "newrelic_error_collector_enabled": "${_newrelic_error_collector_enabled}",
  "newrelic_error_collector_record_database_errors": "${_newrelic_error_collector_record_database_errors}",
  "newrelic_webtransaction_name_functions": "${_newrelic_webtransaction_name_functions}",
  "newrelic_webtransaction_name_files": "${_newrelic_webtransaction_name_files}",
  "newrelic_webtransaction_name_remove_trailing_path": "${_newrelic_webtransaction_name_remove_trailing_path}"
}
END
}

php_newrelic_license() {
  # payload newrelic_license
  echo "$(nos_payload newrelic_key)"
}

php_newrelic_capture_params() {
  # boxfile php_newrelic_capture_params
  _php_newrelic_capture_params=$(nos_validate "$(nos_payload boxfile_php_newrelic_capture_params)" "boolean" "Off")
  echo "$_php_newrelic_capture_params"
}

php_newrelic_ignored_params() {
  # boxfile php_newrelic_ignored_params
  _php_newrelic_ignored_params=$(nos_validate "$(nos_payload boxfile_php_newrelic_ignored_params)" "string" "")
  echo "$_php_newrelic_ignored_params"
}

php_newrelic_loglevel() {
  # boxfile php_newrelic_loglevel
  _php_newrelic_loglevel=$(nos_validate "$(nos_payload boxfile_php_newrelic_loglevel)" "string" "info")
  [[ "$_php_newrelic_loglevel" = 'error' ]] && echo "$_php_newrelic_loglevel" && return
  [[ "$_php_newrelic_loglevel" = 'warning' ]] && echo "$_php_newrelic_loglevel" && return
  [[ "$_php_newrelic_loglevel" = 'info' ]] && echo "$_php_newrelic_loglevel" && return
  [[ "$_php_newrelic_loglevel" = 'verbose' ]] && echo "$_php_newrelic_loglevel" && return
  [[ "$_php_newrelic_loglevel" = 'debug' ]] && echo "$_php_newrelic_loglevel" && return
  [[ "$_php_newrelic_loglevel" = 'verbosedebug' ]] && echo "$_php_newrelic_loglevel" && return
  exit 1
}

php_newrelic_framework() {
  # boxfile php_newrelic_framework
  _php_newrelic_framework=$(nos_validate "$(nos_payload boxfile_php_newrelic_framework)" "string" "")
  echo "$_php_newrelic_framework"
}

php_newrelic_browser_monitoring_auto_instrument() {
  # boxfile php_newrelic_browser_monitoring_auto_instrument
  _php_newrelic_browser_monitoring_auto_instrument=$(nos_validate "$(nos_payload boxfile_php_newrelic_browser_monitoring_auto_instrument)" "boolean" "On")
  echo "$_php_newrelic_browser_monitoring_auto_instrument"
}

php_newrelic_framework_drupal_modules() {
  # boxfile php_newrelic_framework_drupal_modules
  _php_newrelic_framework_drupal_modules=$(nos_validate "$(nos_payload boxfile_php_newrelic_framework_drupal_modules)" "boolean" "On")
  echo "$_php_newrelic_framework_drupal_modules"
}

php_newrelic_transaction_tracer_detail() {
  # boxfile php_newrelic_transaction_tracer_detail
  _php_newrelic_transaction_tracer_detail=$(nos_validate "$(nos_payload boxfile_php_newrelic_transaction_tracer_detail)" "integer" "1")
  echo "$_php_newrelic_transaction_tracer_detail"
}

php_newrelic_transaction_tracer_enabled() {
  # boxfile php_newrelic_transaction_tracer_enabled
  _php_newrelic_transaction_tracer_enabled=$(nos_validate "$(nos_payload boxfile_php_newrelic_transaction_tracer_enabled)" "boolean" "On")
  echo "$_php_newrelic_transaction_tracer_enabled"
}

php_newrelic_transaction_tracer_record_sql() {
  # boxfile php_newrelic_transaction_tracer_record_sql
  _php_newrelic_transaction_tracer_record_sql=$(nos_validate "$(nos_payload boxfile_php_newrelic_transaction_tracer_record_sql)" "string" "obfuscated")
  [[ "$_php_newrelic_transaction_tracer_record_sql" = "off" ]] && echo "$_php_newrelic_transaction_tracer_record_sql" && return
  [[ "$_php_newrelic_transaction_tracer_record_sql" = "raw" ]] && echo "$_php_newrelic_transaction_tracer_record_sql" && return
  [[ "$_php_newrelic_transaction_tracer_record_sql" = "obfuscated" ]] && echo "$_php_newrelic_transaction_tracer_record_sql" && return
  exit 1
}

php_newrelic_transaction_tracer_threshold() {
  # boxfile php_newrelic_transaction_tracer_threshold
  _php_newrelic_transaction_tracer_threshold=$(nos_validate "$(nos_payload boxfile_php_newrelic_transaction_tracer_threshold)" "string" "apdex_f")
  echo "$_php_newrelic_transaction_tracer_threshold"
}

php_newrelic_transaction_tracer_stack_trace_threshold() {
  # boxfile php_newrelic_transaction_tracer_stack_trace_threshold
  _php_newrelic_transaction_tracer_stack_trace_threshold=$(nos_validate "$(nos_payload boxfile_php_newrelic_transaction_tracer_stack_trace_threshold)" "integer" "500")
  echo "$_php_newrelic_transaction_tracer_stack_trace_threshold"
}

php_newrelic_transaction_tracer_explain_threshold() {
  # boxfile php_newrelic_transaction_tracer_explain_threshold
  _php_newrelic_transaction_tracer_explain_threshold=$(nos_validate "$(nos_payload boxfile_php_newrelic_transaction_tracer_explain_threshold)" "integer" "500")
  echo "$_php_newrelic_transaction_tracer_explain_threshold"
}

php_newrelic_transaction_tracer_slow_sql() {
  # boxfile php_newrelic_transaction_tracer_slow_sql
  _php_newrelic_transaction_tracer_slow_sql=$(nos_validate "$(nos_payload boxfile_php_newrelic_transaction_tracer_slow_sql)" "boolean" "On")
  echo "$_php_newrelic_transaction_tracer_slow_sql"
}

php_newrelic_transaction_tracer_custom() {
  # boxfile php_newrelic_transaction_tracer_custom
  _php_newrelic_transaction_tracer_custom=$(nos_validate "$(nos_payload boxfile_php_newrelic_transaction_tracer_custom)" "string" "")
  echo "$_php_newrelic_transaction_tracer_custom"
}

php_newrelic_error_collector_enabled() {
  # boxfile php_newrelic_error_collector_enabled
  _php_newrelic_error_collector_enabled=$(nos_validate "$(nos_payload boxfile_php_newrelic_error_collector_enabled)" "boolean" "On")
  echo "$_php_newrelic_error_collector_enabled"
}

php_newrelic_error_collector_record_database_errors() {
  # boxfile php_newrelic_error_collector_record_database_errors
  _php_newrelic_error_collector_record_database_errors=$(nos_validate "$(nos_payload boxfile_php_newrelic_error_collector_record_database_errors)" "boolean" "On")
  echo "$_php_newrelic_error_collector_record_database_errors"
}

php_newrelic_webtransaction_name_functions() {
  # boxfile php_newrelic_webtransaction_name_functions
  _php_newrelic_webtransaction_name_functions=$(nos_validate "$(nos_payload boxfile_php_newrelic_webtransaction_name_functions)" "string" "")
  echo "$_php_newrelic_webtransaction_name_functions"
}

php_newrelic_webtransaction_name_files() {
  # boxfile php_newrelic_webtransaction_name_files
  _php_newrelic_webtransaction_name_files=$(nos_validate "$(nos_payload boxfile_php_newrelic_webtransaction_name_files)" "string" "")
  echo "$_php_newrelic_webtransaction_name_files"
}

php_newrelic_webtransaction_name_remove_trailing_path() {
  # boxfile php_newrelic_webtransaction_name_remove_trailing_path
  _php_newrelic_webtransaction_name_remove_trailing_path=$(nos_validate "$(nos_payload boxfile_php_newrelic_webtransaction_name_remove_trailing_path)" "boolean" "Off")
  echo "$_php_newrelic_webtransaction_name_remove_trailing_path"
}

php_configure_newrelic() {
  if [[ -n "$(php_newrelic_license)" ]]; then
    nos_print_bullet_info "Configuring PHP New Relic extension"
    mkdir -p $(nos_etc_dir)/php.d
    create_php_newrelic_ini
  fi
}