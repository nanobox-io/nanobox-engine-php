
create_php_newrelic_ini() {
  template \
    "php/php.d/newrelic.ini.mustache" \
    "$(payload 'etc_dir')/php.d/newrelic.ini" \
    "$(newrelic_ini_payload)"
}

newrelic_ini_payload() {
  cat <<-END
{
  "app_name": "$(app_name)",
  "newrelic_license": "$(newrelic_license)",
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

newrelic_license() {
  # payload newrelic_license
  echo "$(payload newrelic_license)"
}

newrelic_capture_params() {
  # boxfile php_newrelic_capture_params
  php_newrelic_capture_params=$(validate "$(payload boxfile_php_newrelic_capture_params)" "boolean" "Off")
  echo "$php_newrelic_capture_params"
}

newrelic_ignored_params() {
  # boxfile php_newrelic_ignored_params
  php_newrelic_ignored_params=$(validate "$(payload boxfile_php_newrelic_ignored_params)" "string" "")
  echo "$php_newrelic_ignored_params"
}

newrelic_loglevel() {
  # boxfile php_newrelic_loglevel
  php_newrelic_loglevel=$(validate "$(payload boxfile_php_newrelic_loglevel)" "string" "info")
  [[ "$php_newrelic_loglevel" = 'error' ]] && echo "$php_newrelic_loglevel" && return
  [[ "$php_newrelic_loglevel" = 'warning' ]] && echo "$php_newrelic_loglevel" && return
  [[ "$php_newrelic_loglevel" = 'info' ]] && echo "$php_newrelic_loglevel" && return
  [[ "$php_newrelic_loglevel" = 'verbose' ]] && echo "$php_newrelic_loglevel" && return
  [[ "$php_newrelic_loglevel" = 'debug' ]] && echo "$php_newrelic_loglevel" && return
  [[ "$php_newrelic_loglevel" = 'verbosedebug' ]] && echo "$php_newrelic_loglevel" && return
  >&2 echo "Error: Invalid Newrelic Log Level \"$php_newrelic_loglevel\""
  exit 1
}

newrelic_framework() {
  # boxfile php_newrelic_framework
  php_newrelic_framework=$(validate "$(payload boxfile_php_newrelic_framework)" "string" "")
  echo "$php_newrelic_framework"
}

newrelic_browser_monitoring_auto_instrument() {
  # boxfile php_newrelic_browser_monitoring_auto_instrument
  php_newrelic_browser_monitoring_auto_instrument=$(validate "$(payload boxfile_php_newrelic_browser_monitoring_auto_instrument)" "boolean" "On")
  echo "$php_newrelic_browser_monitoring_auto_instrument"
}

newrelic_framework_drupal_modules() {
  # boxfile php_newrelic_framework_drupal_modules
  php_newrelic_framework_drupal_modules=$(validate "$(payload boxfile_php_newrelic_framework_drupal_modules)" "boolean" "On")
  echo "$php_newrelic_framework_drupal_modules"
}

newrelic_transaction_tracer_detail() {
  # boxfile php_newrelic_transaction_tracer_detail
  php_newrelic_transaction_tracer_detail=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_detail)" "integer" "1")
  echo "$php_newrelic_transaction_tracer_detail"
}

newrelic_transaction_tracer_enabled() {
  # boxfile php_newrelic_transaction_tracer_enabled
  php_newrelic_transaction_tracer_enabled=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_enabled)" "boolean" "On")
  echo "$php_newrelic_transaction_tracer_enabled"
}

newrelic_transaction_tracer_record_sql() {
  # boxfile php_newrelic_transaction_tracer_record_sql
  php_newrelic_transaction_tracer_record_sql=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_record_sql)" "string" "obfuscated")
  [[ "$php_newrelic_transaction_tracer_record_sql" = "off" ]] && echo "$php_newrelic_transaction_tracer_record_sql" && return
  [[ "$php_newrelic_transaction_tracer_record_sql" = "raw" ]] && echo "$php_newrelic_transaction_tracer_record_sql" && return
  [[ "$php_newrelic_transaction_tracer_record_sql" = "obfuscated" ]] && echo "$php_newrelic_transaction_tracer_record_sql" && return
  >&2 echo "Error: Invalid Newrelic transaction tracer record sql value \"$php_newrelic_transaction_tracer_record_sql\""
  exit 1
}

newrelic_transaction_tracer_threshold() {
  # boxfile php_newrelic_transaction_tracer_threshold
  php_newrelic_transaction_tracer_threshold=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_threshold)" "string" "apdex_f")
  echo "$php_newrelic_transaction_tracer_threshold"
}

newrelic_transaction_tracer_stack_trace_threshold() {
  # boxfile php_newrelic_transaction_tracer_stack_trace_threshold
  php_newrelic_transaction_tracer_stack_trace_threshold=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_stack_trace_threshold)" "integer" "500")
  echo "$php_newrelic_transaction_tracer_stack_trace_threshold"
}

newrelic_transaction_tracer_explain_threshold() {
  # boxfile php_newrelic_transaction_tracer_explain_threshold
  php_newrelic_transaction_tracer_explain_threshold=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_explain_threshold)" "integer" "500")
  echo "$php_newrelic_transaction_tracer_explain_threshold"
}

newrelic_transaction_tracer_slow_sql() {
  # boxfile php_newrelic_transaction_tracer_slow_sql
  php_newrelic_transaction_tracer_slow_sql=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_slow_sql)" "boolean" "On")
  echo "$php_newrelic_transaction_tracer_slow_sql"
}

newrelic_transaction_tracer_custom() {
  # boxfile php_newrelic_transaction_tracer_custom
  php_newrelic_transaction_tracer_custom=$(validate "$(payload boxfile_php_newrelic_transaction_tracer_custom)" "string" "")
  echo "$php_newrelic_transaction_tracer_custom"
}

newrelic_error_collector_enabled() {
  # boxfile php_newrelic_error_collector_enabled
  php_newrelic_error_collector_enabled=$(validate "$(payload boxfile_php_newrelic_error_collector_enabled)" "boolean" "On")
  echo "$php_newrelic_error_collector_enabled"
}

newrelic_error_collector_record_database_errors() {
  # boxfile php_newrelic_error_collector_record_database_errors
  php_newrelic_error_collector_record_database_errors=$(validate "$(payload boxfile_php_newrelic_error_collector_record_database_errors)" "boolean" "On")
  echo "$php_newrelic_error_collector_record_database_errors"
}

newrelic_webtransaction_name_functions() {
  # boxfile php_newrelic_webtransaction_name_functions
  php_newrelic_webtransaction_name_functions=$(validate "$(payload boxfile_php_newrelic_webtransaction_name_functions)" "string" "")
  echo "$php_newrelic_webtransaction_name_functions"
}

newrelic_webtransaction_name_files() {
  # boxfile php_newrelic_webtransaction_name_files
  php_newrelic_webtransaction_name_files=$(validate "$(payload boxfile_php_newrelic_webtransaction_name_files)" "string" "")
  echo "$php_newrelic_webtransaction_name_files"
}

newrelic_webtransaction_name_remove_trailing_path() {
  # boxfile php_newrelic_webtransaction_name_remove_trailing_path
  php_newrelic_webtransaction_name_remove_trailing_path=$(validate "$(payload boxfile_php_newrelic_webtransaction_name_remove_trailing_path)" "boolean" "Off")
  echo "$php_newrelic_webtransaction_name_remove_trailing_path"
}

configure_newrelic() {
  if [[ -n "$(newrelic_license)" ]]; then
    mkdir -p $(etc_dir)/php.d
    create_php_newrelic_ini
  fi
}