# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

generate_newrelic_ini() {
  
  # Report back to the user
  report_newrelic_settings
  
  nos_template \
    "php/php.d/newrelic.ini.mustache" \
    "$(nos_etc_dir)/php.prod.d/newrelic.ini" \
    "$(newrelic_ini_payload)"

  generate_newrelic_cfg
}

generate_dev_newrelic_ini() {
  nos_template \
    "php/php.d/newrelic.ini.mustache" \
    "$(nos_etc_dir)/php.dev.d/newrelic.ini" \
    "$(newrelic_ini_payload)"
}

generate_newrelic_cfg() {
  nos_template \
    "newrelic.cfg.mustache" \
    "$(nos_etc_dir)/newrelic.cfg" \
    "$(newrelic_cfg_payload)"
}

report_newrelic_settings() {
  nos_print_bullet_sub "Caputure params: $(newrelic_capture_params)"
  nos_print_bullet_sub "Ignored params: $(newrelic_ignored_params)"
  nos_print_bullet_sub "Log level: $(newrelic_loglevel)"
  nos_print_bullet_sub "Framework: $(newrelic_framework)"
  nos_print_bullet_sub "Browser monitoring auto instrument: $(newrelic_browser_monitoring_auto_instrument)"
  nos_print_bullet_sub "Framework drupal modules: $(newrelic_framework_drupal_modules)"
  nos_print_bullet_sub "Transaction tracer detail: $(newrelic_transaction_tracer_detail)"
  nos_print_bullet_sub "Transaction tracer enabled: $(newrelic_transaction_tracer_enabled)"
  nos_print_bullet_sub "Transaction tracer record sql: $(newrelic_transaction_tracer_record_sql)"
  nos_print_bullet_sub "Transaction tracer threshold: $(newrelic_transaction_tracer_threshold)"
  nos_print_bullet_sub "Transaction tracer stack trace threshold: $(newrelic_transaction_tracer_stack_trace_threshold)"
  nos_print_bullet_sub "Transaction tracer explain threshold: $(newrelic_transaction_tracer_explain_threshold)"
  nos_print_bullet_sub "Transaction tracer slow sql: $(newrelic_transaction_tracer_slow_sql)"
  nos_print_bullet_sub "Transaction tracer custom: $(newrelic_transaction_tracer_custom)"
  nos_print_bullet_sub "Error collector enabled: $(newrelic_error_collector_enabled)"
  nos_print_bullet_sub "Error collector record database errors: $(newrelic_error_collector_record_database_errors)"
  nos_print_bullet_sub "Eebtransaction name functions: $(newrelic_webtransaction_name_functions)"
  nos_print_bullet_sub "Webtransaction name files: $(newrelic_webtransaction_name_files)"
  nos_print_bullet_sub "Webtransaction name remove trailing pathprint bullet sub: $(newrelic_webtransaction_name_remove_trailing_path)"  
}

newrelic_ini_payload() {
  cat <<-END
{
  "app_name": "$(app_name)",
  "newrelic_capture_params": "$(newrelic_capture_params)",
  "newrelic_ignored_params": "$(newrelic_ignored_params)",
  "newrelic_loglevel": "$(newrelic_loglevel)",
  "newrelic_framework": "$(newrelic_framework)",
  "newrelic_browser_monitoring_auto_instrument": "$(newrelic_browser_monitoring_auto_instrument)",
  "newrelic_framework_drupal_modules": "$(newrelic_framework_drupal_modules)",
  "newrelic_transaction_tracer_detail": "$(newrelic_transaction_tracer_detail)",
  "newrelic_transaction_tracer_enabled": "$(newrelic_transaction_tracer_enabled)",
  "newrelic_transaction_tracer_record_sql": "$(newrelic_transaction_tracer_record_sql)",
  "newrelic_transaction_tracer_threshold": "$(newrelic_transaction_tracer_threshold)",
  "newrelic_transaction_tracer_stack_trace_threshold": "$(newrelic_transaction_tracer_stack_trace_threshold)",
  "newrelic_transaction_tracer_explain_threshold": "$(newrelic_transaction_tracer_explain_threshold)",
  "newrelic_transaction_tracer_slow_sql": "$(newrelic_transaction_tracer_slow_sql)",
  "newrelic_transaction_tracer_custom": "$(newrelic_transaction_tracer_custom)",
  "newrelic_error_collector_enabled": "$(newrelic_error_collector_enabled)",
  "newrelic_error_collector_record_database_errors": "$(newrelic_error_collector_record_database_errors)",
  "newrelic_webtransaction_name_functions": "$(newrelic_webtransaction_name_functions)",
  "newrelic_webtransaction_name_files": "$(newrelic_webtransaction_name_files)",
  "newrelic_webtransaction_name_remove_trailing_path": "$(newrelic_webtransaction_name_remove_trailing_path)"
}
END
}

newrelic_cfg_payload() {
  cat <<-END
{
  "data_dir": "$(nos_data_dir)",
  "newrelic_loglevel": "$(newrelic_loglevel)"
}
END
}

newrelic_capture_params() {
  # boxfile newrelic_capture_params
  _newrelic_capture_params=$(nos_validate "$(nos_payload config_newrelic_capture_params)" "boolean" "Off")
  echo "$_newrelic_capture_params"
}

newrelic_ignored_params() {
  # boxfile newrelic_ignored_params
  _newrelic_ignored_params=$(nos_validate "$(nos_payload config_newrelic_ignored_params)" "string" "")
  echo "$_newrelic_ignored_params"
}

newrelic_loglevel() {
  # boxfile newrelic_loglevel
  _newrelic_loglevel=$(nos_validate "$(nos_payload config_newrelic_loglevel)" "string" "info")
  [[ "$_newrelic_loglevel" = 'error' ]] && echo "$_newrelic_loglevel" && return
  [[ "$_newrelic_loglevel" = 'warning' ]] && echo "$_newrelic_loglevel" && return
  [[ "$_newrelic_loglevel" = 'info' ]] && echo "$_newrelic_loglevel" && return
  [[ "$_newrelic_loglevel" = 'verbose' ]] && echo "$_newrelic_loglevel" && return
  [[ "$_newrelic_loglevel" = 'debug' ]] && echo "$_newrelic_loglevel" && return
  [[ "$_newrelic_loglevel" = 'verbosedebug' ]] && echo "$_newrelic_loglevel" && return
  exit 1
}

newrelic_framework() {
  # boxfile newrelic_framework
  _newrelic_framework=$(nos_validate "$(nos_payload config_newrelic_framework)" "string" "")
  echo "$_newrelic_framework"
}

newrelic_browser_monitoring_auto_instrument() {
  # boxfile newrelic_browser_monitoring_auto_instrument
  _newrelic_browser_monitoring_auto_instrument=$(nos_validate "$(nos_payload config_newrelic_browser_monitoring_auto_instrument)" "boolean" "On")
  echo "$_newrelic_browser_monitoring_auto_instrument"
}

newrelic_framework_drupal_modules() {
  # boxfile newrelic_framework_drupal_modules
  _newrelic_framework_drupal_modules=$(nos_validate "$(nos_payload config_newrelic_framework_drupal_modules)" "boolean" "On")
  echo "$_newrelic_framework_drupal_modules"
}

newrelic_transaction_tracer_detail() {
  # boxfile newrelic_transaction_tracer_detail
  _newrelic_transaction_tracer_detail=$(nos_validate "$(nos_payload config_newrelic_transaction_tracer_detail)" "integer" "1")
  echo "$_newrelic_transaction_tracer_detail"
}

newrelic_transaction_tracer_enabled() {
  # boxfile newrelic_transaction_tracer_enabled
  _newrelic_transaction_tracer_enabled=$(nos_validate "$(nos_payload config_newrelic_transaction_tracer_enabled)" "boolean" "On")
  echo "$_newrelic_transaction_tracer_enabled"
}

newrelic_transaction_tracer_record_sql() {
  # boxfile newrelic_transaction_tracer_record_sql
  _newrelic_transaction_tracer_record_sql=$(nos_validate "$(nos_payload config_newrelic_transaction_tracer_record_sql)" "string" "obfuscated")
  [[ "$_newrelic_transaction_tracer_record_sql" = "off" ]] && echo "$_newrelic_transaction_tracer_record_sql" && return
  [[ "$_newrelic_transaction_tracer_record_sql" = "raw" ]] && echo "$_newrelic_transaction_tracer_record_sql" && return
  [[ "$_newrelic_transaction_tracer_record_sql" = "obfuscated" ]] && echo "$_newrelic_transaction_tracer_record_sql" && return
  exit 1
}

newrelic_transaction_tracer_threshold() {
  # boxfile newrelic_transaction_tracer_threshold
  _newrelic_transaction_tracer_threshold=$(nos_validate "$(nos_payload config_newrelic_transaction_tracer_threshold)" "string" "apdex_f")
  echo "$_newrelic_transaction_tracer_threshold"
}

newrelic_transaction_tracer_stack_trace_threshold() {
  # boxfile newrelic_transaction_tracer_stack_trace_threshold
  _newrelic_transaction_tracer_stack_trace_threshold=$(nos_validate "$(nos_payload config_newrelic_transaction_tracer_stack_trace_threshold)" "integer" "500")
  echo "$_newrelic_transaction_tracer_stack_trace_threshold"
}

newrelic_transaction_tracer_explain_threshold() {
  # boxfile newrelic_transaction_tracer_explain_threshold
  _newrelic_transaction_tracer_explain_threshold=$(nos_validate "$(nos_payload config_newrelic_transaction_tracer_explain_threshold)" "integer" "500")
  echo "$_newrelic_transaction_tracer_explain_threshold"
}

newrelic_transaction_tracer_slow_sql() {
  # boxfile newrelic_transaction_tracer_slow_sql
  _newrelic_transaction_tracer_slow_sql=$(nos_validate "$(nos_payload config_newrelic_transaction_tracer_slow_sql)" "boolean" "On")
  echo "$_newrelic_transaction_tracer_slow_sql"
}

newrelic_transaction_tracer_custom() {
  # boxfile newrelic_transaction_tracer_custom
  _newrelic_transaction_tracer_custom=$(nos_validate "$(nos_payload config_newrelic_transaction_tracer_custom)" "string" "")
  echo "$_newrelic_transaction_tracer_custom"
}

newrelic_error_collector_enabled() {
  # boxfile newrelic_error_collector_enabled
  _newrelic_error_collector_enabled=$(nos_validate "$(nos_payload config_newrelic_error_collector_enabled)" "boolean" "On")
  echo "$_newrelic_error_collector_enabled"
}

newrelic_error_collector_record_database_errors() {
  # boxfile newrelic_error_collector_record_database_errors
  _newrelic_error_collector_record_database_errors=$(nos_validate "$(nos_payload config_newrelic_error_collector_record_database_errors)" "boolean" "On")
  echo "$_newrelic_error_collector_record_database_errors"
}

newrelic_webtransaction_name_functions() {
  # boxfile newrelic_webtransaction_name_functions
  _newrelic_webtransaction_name_functions=$(nos_validate "$(nos_payload config_newrelic_webtransaction_name_functions)" "string" "")
  echo "$_newrelic_webtransaction_name_functions"
}

newrelic_webtransaction_name_files() {
  # boxfile newrelic_webtransaction_name_files
  _newrelic_webtransaction_name_files=$(nos_validate "$(nos_payload config_newrelic_webtransaction_name_files)" "string" "")
  echo "$_newrelic_webtransaction_name_files"
}

newrelic_webtransaction_name_remove_trailing_path() {
  # boxfile newrelic_webtransaction_name_remove_trailing_path
  _newrelic_webtransaction_name_remove_trailing_path=$(nos_validate "$(nos_payload config_newrelic_webtransaction_name_remove_trailing_path)" "boolean" "Off")
  echo "$_newrelic_webtransaction_name_remove_trailing_path"
}

configure_newrelic() {
  if [[ -n "$(newrelic_license)" ]]; then
    nos_print_bullet_info "Configuring PHP New Relic extension"
    mkdir -p $(nos_etc_dir)/php.d
    create_newrelic_ini
  fi
}
