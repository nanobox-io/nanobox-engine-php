# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

generate_xdebug_ini() {
  
  # Report back to the user
  report_xdebug_settings
  
  nos_template \
    "php/php.d/xdebug.ini.mustache" \
    "$(nos_etc_dir)/php.prod.d/xdebug.ini" \
    "$(xdebug_ini_payload)"
}

generate_dev_xdebug_ini() {
  nos_template \
    "php/php.d/xdebug.ini.mustache" \
    "$(nos_etc_dir)/php.dev.d/xdebug.ini" \
    "$(xdebug_ini_payload)"
}

report_xdebug_settings() {
  nos_print_bullet_sub "xdebug_auto_trace: $(xdebug_auto_trace)"
  nos_print_bullet_sub "xdebug_cli_color: $(xdebug_cli_color)"
  nos_print_bullet_sub "xdebug_collect_assignments: $(xdebug_collect_assignments)"
  nos_print_bullet_sub "xdebug_collect_includes: $(xdebug_collect_includes)"
  nos_print_bullet_sub "xdebug_collect_params: $(xdebug_collect_params)"
  nos_print_bullet_sub "xdebug_collect_return: $(xdebug_collect_return)"
  nos_print_bullet_sub "xdebug_collect_vars: $(xdebug_collect_vars)"
  nos_print_bullet_sub "xdebug_coverage_enable: $(xdebug_coverage_enable)"
  nos_print_bullet_sub "xdebug_default_enable: $(xdebug_default_enable)"
  nos_print_bullet_sub "xdebug_dump_COOKIE: $(xdebug_dump_COOKIE)"
  nos_print_bullet_sub "xdebug_dump_FILES: $(xdebug_dump_FILES)"
  nos_print_bullet_sub "xdebug_dump_GET: $(xdebug_dump_GET)"
  nos_print_bullet_sub "xdebug_dump_POST: $(xdebug_dump_POST)"
  nos_print_bullet_sub "xdebug_dump_REQUEST: $(xdebug_dump_REQUEST)"
  nos_print_bullet_sub "xdebug_dump_SERVER: $(xdebug_dump_SERVER)"
  nos_print_bullet_sub "xdebug_dump_SESSION: $(xdebug_dump_SESSION)"
  nos_print_bullet_sub "xdebug_dump_globals: $(xdebug_dump_globals)"
  nos_print_bullet_sub "xdebug_dump_once: $(xdebug_dump_once)"
  nos_print_bullet_sub "xdebug_dump_undefined: $(xdebug_dump_undefined)"
  nos_print_bullet_sub "xdebug_extended_info: $(xdebug_extended_info)"
  nos_print_bullet_sub "xdebug_file_link_format: $(xdebug_file_link_format)"
  nos_print_bullet_sub "xdebug_force_display_errors: $(xdebug_force_display_errors)"
  nos_print_bullet_sub "xdebug_force_error_reporting: $(xdebug_force_error_reporting)"
  nos_print_bullet_sub "xdebug_halt_level: $(xdebug_halt_level)"
  nos_print_bullet_sub "xdebug_idekey: $(xdebug_idekey)"
  nos_print_bullet_sub "xdebug_manual_url: $(xdebug_manual_url)"
  nos_print_bullet_sub "xdebug_max_nesting_level: $(xdebug_max_nesting_level)"
  nos_print_bullet_sub "xdebug_max_stack_frames: $(xdebug_max_stack_frames)"
  nos_print_bullet_sub "xdebug_overload_var_dump: $(xdebug_overload_var_dump)"
  nos_print_bullet_sub "xdebug_profiler_aggregate: $(xdebug_profiler_aggregate)"
  nos_print_bullet_sub "xdebug_profiler_append: $(xdebug_profiler_append)"
  nos_print_bullet_sub "xdebug_profiler_enable: $(xdebug_profiler_enable)"
  nos_print_bullet_sub "xdebug_profiler_enable_trigger: $(xdebug_profiler_enable_trigger)"
  nos_print_bullet_sub "xdebug_profiler_enable_trigger_value: $(xdebug_profiler_enable_trigger_value)"
  nos_print_bullet_sub "xdebug_profiler_output_dir: $(xdebug_profiler_output_dir)"
  nos_print_bullet_sub "xdebug_profiler_output_name: $(xdebug_profiler_output_name)"
  nos_print_bullet_sub "xdebug_remote_addr_header: $(xdebug_remote_addr_header)"
  nos_print_bullet_sub "xdebug_remote_autostart: $(xdebug_remote_autostart)"
  nos_print_bullet_sub "xdebug_remote_connect_back: $(xdebug_remote_connect_back)"
  nos_print_bullet_sub "xdebug_remote_cookie_expire_time: $(xdebug_remote_cookie_expire_time)"
  nos_print_bullet_sub "xdebug_remote_enable: $(xdebug_remote_enable)"
  nos_print_bullet_sub "xdebug_remote_handler: $(xdebug_remote_handler)"
  nos_print_bullet_sub "xdebug_remote_host: $(xdebug_remote_host)"
  nos_print_bullet_sub "xdebug_remote_log: $(xdebug_remote_log)"
  nos_print_bullet_sub "xdebug_remote_mode: $(xdebug_remote_mode)"
  nos_print_bullet_sub "xdebug_remote_port: $(xdebug_remote_port)"
  nos_print_bullet_sub "xdebug_scream: $(xdebug_scream)"
  nos_print_bullet_sub "xdebug_show_error_trace: $(xdebug_show_error_trace)"
  nos_print_bullet_sub "xdebug_show_exception_trace: $(xdebug_show_exception_trace)"
  nos_print_bullet_sub "xdebug_show_local_vars: $(xdebug_show_local_vars)"
  nos_print_bullet_sub "xdebug_show_mem_delta: $(xdebug_show_mem_delta)"
  nos_print_bullet_sub "xdebug_trace_enable_trigger: $(xdebug_trace_enable_trigger)"
  nos_print_bullet_sub "xdebug_trace_enable_trigger_value: $(xdebug_trace_enable_trigger_value)"
  nos_print_bullet_sub "xdebug_trace_format: $(xdebug_trace_format)"
  nos_print_bullet_sub "xdebug_trace_options: $(xdebug_trace_options)"
  nos_print_bullet_sub "xdebug_trace_output_dir: $(xdebug_trace_output_dir)"
  nos_print_bullet_sub "xdebug_trace_output_name: $(xdebug_trace_output_name)"
  nos_print_bullet_sub "xdebug_var_display_max_children: $(xdebug_var_display_max_children)"
  nos_print_bullet_sub "xdebug_var_display_max_data: $(xdebug_var_display_max_data)"
  nos_print_bullet_sub "xdebug_var_display_max_depth: $(xdebug_var_display_max_depth)"

}

xdebug_ini_payload() {
  cat <<-END
{
  "xdebug_auto_trace": $(xdebug_auto_trace),
  "xdebug_cli_color": $(xdebug_cli_color),
  "xdebug_collect_assignments": $(xdebug_collect_assignments),
  "xdebug_collect_includes": $(xdebug_collect_includes),
  "xdebug_collect_params": $(xdebug_collect_params),
  "xdebug_collect_return": $(xdebug_collect_return),
  "xdebug_collect_vars": $(xdebug_collect_vars),
  "xdebug_coverage_enable": $(xdebug_coverage_enable),
  "xdebug_default_enable": $(xdebug_default_enable),
  "xdebug_dump_COOKIE": "$(xdebug_dump_COOKIE)",
  "xdebug_dump_FILES": "$(xdebug_dump_FILES)",
  "xdebug_dump_GET": "$(xdebug_dump_GET)",
  "xdebug_dump_POST": "$(xdebug_dump_POST)",
  "xdebug_dump_REQUEST": "$(xdebug_dump_REQUEST)",
  "xdebug_dump_SERVER": "$(xdebug_dump_SERVER)",
  "xdebug_dump_SESSION": "$(xdebug_dump_SESSION)",
  "xdebug_dump_globals": $(xdebug_dump_globals),
  "xdebug_dump_once": $(xdebug_dump_once),
  "xdebug_dump_undefined": $(xdebug_dump_undefined),
  "xdebug_extended_info": $(xdebug_extended_info),
  "xdebug_file_link_format": "$(xdebug_file_link_format)",
  "xdebug_force_display_errors": $(xdebug_force_display_errors),
  "xdebug_force_error_reporting": $(xdebug_force_error_reporting),
  "xdebug_halt_level": $(xdebug_halt_level),
  "xdebug_idekey": "$(xdebug_idekey)",
  "xdebug_manual_url": "$(xdebug_manual_url)",
  "xdebug_max_nesting_level": $(xdebug_max_nesting_level),
  "xdebug_max_stack_frames": $(xdebug_max_stack_frames),
  "xdebug_overload_var_dump": $(xdebug_overload_var_dump),
  "xdebug_profiler_aggregate": $(xdebug_profiler_aggregate),
  "xdebug_profiler_append": $(xdebug_profiler_append),
  "xdebug_profiler_enable": $(xdebug_profiler_enable),
  "xdebug_profiler_enable_trigger": $(xdebug_profiler_enable_trigger),
  "xdebug_profiler_enable_trigger_value": "$(xdebug_profiler_enable_trigger_value)",
  "xdebug_profiler_output_dir": "$(xdebug_profiler_output_dir)",
  "xdebug_profiler_output_name": "$(xdebug_profiler_output_name)",
  "xdebug_remote_addr_header": "$(xdebug_remote_addr_header)",
  "xdebug_remote_autostart": $(xdebug_remote_autostart),
  "xdebug_remote_connect_back": $(xdebug_remote_connect_back),
  "xdebug_remote_cookie_expire_time": $(xdebug_remote_cookie_expire_time),
  "xdebug_remote_enable": $(xdebug_remote_enable),
  "xdebug_remote_handler": "$(xdebug_remote_handler)",
  "xdebug_remote_host": "$(xdebug_remote_host)",
  "xdebug_remote_log": "$(xdebug_remote_log)",
  "xdebug_remote_mode": "$(xdebug_remote_mode)",
  "xdebug_remote_port": $(xdebug_remote_port),
  "xdebug_scream": $(xdebug_scream),
  "xdebug_show_error_trace": $(xdebug_show_error_trace),
  "xdebug_show_exception_trace": $(xdebug_show_exception_trace),
  "xdebug_show_local_vars": $(xdebug_show_local_vars),
  "xdebug_show_mem_delta": $(xdebug_show_mem_delta),
  "xdebug_trace_enable_trigger": $(xdebug_trace_enable_trigger),
  "xdebug_trace_enable_trigger_value": "$(xdebug_trace_enable_trigger_value)",
  "xdebug_trace_format": $(xdebug_trace_format),
  "xdebug_trace_options": $(xdebug_trace_options),
  "xdebug_trace_output_dir": "$(xdebug_trace_output_dir)",
  "xdebug_trace_output_name": "$(xdebug_trace_output_name)",
  "xdebug_var_display_max_children": $(xdebug_var_display_max_children),
  "xdebug_var_display_max_data": $(xdebug_var_display_max_data),
  "xdebug_var_display_max_depth": $(xdebug_var_display_max_depth)
}
END
}

xdebug_auto_trace() {
  #boxfile xdebug_auto_trace
  _xdebug_auto_trace=$(nos_validate "$(nos_payload config_xdebug_auto_trace)" "integer" "0")
  echo "_xdebug_auto_trace"
}

xdebug_cli_color() {
  #boxfile xdebug_cli_color
  _xdebug_cli_color=$(nos_validate "$(nos_payload config_xdebug_cli_color)" "integer" "0")
  echo "_xdebug_cli_color"
}

xdebug_collect_assignments() {
  #boxfile xdebug_collect_assignments
  _xdebug_collect_assignments=$(nos_validate "$(nos_payload config_xdebug_collect_assignments)" "integer" "0")
  echo "_xdebug_collect_assignments"
}

xdebug_collect_includes() {
  #boxfile xdebug_collect_includes
  _xdebug_collect_includes=$(nos_validate "$(nos_payload config_xdebug_collect_includes)" "integer" "1")
  echo "_xdebug_collect_includes"
}

xdebug_collect_params() {
  #boxfile xdebug_collect_params
  _xdebug_collect_params=$(nos_validate "$(nos_payload config_xdebug_collect_params)" "integer" "0")
  echo "_xdebug_collect_params"
}

xdebug_collect_return() {
  #boxfile xdebug_collect_return
  _xdebug_collect_return=$(nos_validate "$(nos_payload config_xdebug_collect_return)" "integer" "0")
  echo "_xdebug_collect_return"
}

xdebug_collect_vars() {
  #boxfile xdebug_collect_vars
  _xdebug_collect_vars=$(nos_validate "$(nos_payload config_xdebug_collect_vars)" "integer" "0")
  echo "_xdebug_collect_vars"
}

xdebug_coverage_enable() {
  #boxfile xdebug_coverage_enable
  _xdebug_coverage_enable=$(nos_validate "$(nos_payload config_xdebug_coverage_enable)" "integer" "1")
  echo "_xdebug_coverage_enable"
}

xdebug_default_enable() {
  #boxfile xdebug_default_enable
  _xdebug_default_enable=$(nos_validate "$(nos_payload config_xdebug_default_enable)" "integer" "1")
  echo "_xdebug_default_enable"
}

xdebug_dump_COOKIE() {
  #boxfile xdebug_dump_COOKIE
  _xdebug_dump_COOKIE=$(nos_validate "$(nos_payload config_xdebug_dump_COOKIE)" "string" "")
  echo "_xdebug_dump_COOKIE"
}

xdebug_dump_FILES() {
  #boxfile xdebug_dump_FILES
  _xdebug_dump_FILES=$(nos_validate "$(nos_payload config_xdebug_dump_FILES)" "string" "")
  echo "_xdebug_dump_FILES"
}

xdebug_dump_GET() {
  #boxfile xdebug_dump_GET
  _xdebug_dump_GET=$(nos_validate "$(nos_payload config_xdebug_dump_GET)" "string" "")
  echo "_xdebug_dump_GET"
}

xdebug_dump_POST() {
  #boxfile xdebug_dump_POST
  _xdebug_dump_POST=$(nos_validate "$(nos_payload config_xdebug_dump_POST)" "string" "")
  echo "_xdebug_dump_POST"
}

xdebug_dump_REQUEST() {
  #boxfile xdebug_dump_REQUEST
  _xdebug_dump_REQUEST=$(nos_validate "$(nos_payload config_xdebug_dump_REQUEST)" "string" "")
  echo "_xdebug_dump_REQUEST"
}

xdebug_dump_SERVER() {
  #boxfile xdebug_dump_SERVER
  _xdebug_dump_SERVER=$(nos_validate "$(nos_payload config_xdebug_dump_SERVER)" "string" "")
  echo "_xdebug_dump_SERVER"
}

xdebug_dump_SESSION() {
  #boxfile xdebug_dump_SESSION
  _xdebug_dump_SESSION=$(nos_validate "$(nos_payload config_xdebug_dump_SESSION)" "string" "")
  echo "_xdebug_dump_SESSION"
}

xdebug_dump_globals() {
  #boxfile xdebug_dump_globals
  _xdebug_dump_globals=$(nos_validate "$(nos_payload config_xdebug_dump_globals)" "integer" "1")
  echo "_xdebug_dump_globals"
}

xdebug_dump_once() {
  #boxfile xdebug_dump_once
  _xdebug_dump_once=$(nos_validate "$(nos_payload config_xdebug_dump_once)" "integer" "1")
  echo "_xdebug_dump_once"
}

xdebug_dump_undefined() {
  #boxfile xdebug_dump_undefined
  _xdebug_dump_undefined=$(nos_validate "$(nos_payload config_xdebug_dump_undefined)" "integer" "0")
  echo "_xdebug_dump_undefined"
}

xdebug_extended_info() {
  #boxfile xdebug_extended_info
  _xdebug_extended_info=$(nos_validate "$(nos_payload config_xdebug_extended_info)" "integer" "1")
  echo "_xdebug_extended_info"
}

xdebug_file_link_format() {
  #boxfile xdebug_file_link_format
  _xdebug_file_link_format=$(nos_validate "$(nos_payload config_xdebug_file_link_format)" "string" "")
  echo "_xdebug_file_link_format"
}

xdebug_force_display_errors() {
  #boxfile xdebug_force_display_errors
  _xdebug_force_display_errors=$(nos_validate "$(nos_payload config_xdebug_force_display_errors)" "integer" "0")
  echo "_xdebug_force_display_errors"
}

xdebug_force_error_reporting() {
  #boxfile xdebug_force_error_reporting
  _xdebug_force_error_reporting=$(nos_validate "$(nos_payload config_xdebug_force_error_reporting)" "integer" "0")
  echo "_xdebug_force_error_reporting"
}

xdebug_halt_level() {
  #boxfile xdebug_halt_level
  _xdebug_halt_level=$(nos_validate "$(nos_payload config_xdebug_halt_level)" "integer" "0")
  echo "_xdebug_halt_level"
}

xdebug_idekey() {
  #boxfile xdebug_idekey
  _xdebug_idekey=$(nos_validate "$(nos_payload config_xdebug_idekey)" "string" "")
  echo "_xdebug_idekey"
}

xdebug_manual_url() {
  #boxfile xdebug_manual_url
  _xdebug_manual_url=$(nos_validate "$(nos_payload config_xdebug_manual_url)" "string" "http://www.php.net")
  echo "_xdebug_manual_url"
}

xdebug_max_nesting_level() {
  #boxfile xdebug_max_nesting_level
  _xdebug_max_nesting_level=$(nos_validate "$(nos_payload config_xdebug_max_nesting_level)" "integer" "256")
  echo "_xdebug_max_nesting_level"
}

xdebug_max_stack_frames() {
  #boxfile xdebug_max_stack_frames
  _xdebug_max_stack_frames=$(nos_validate "$(nos_payload config_xdebug_max_stack_frames)" "integer" "-1")
  echo "_xdebug_max_stack_frames"
}

xdebug_overload_var_dump() {
  #boxfile xdebug_overload_var_dump
  _xdebug_overload_var_dump=$(nos_validate "$(nos_payload config_xdebug_overload_var_dump)" "integer" "2")
  echo "_xdebug_overload_var_dump"
}

xdebug_profiler_aggregate() {
  #boxfile xdebug_profiler_aggregate
  _xdebug_profiler_aggregate=$(nos_validate "$(nos_payload config_xdebug_profiler_aggregate)" "integer" "0")
  echo "_xdebug_profiler_aggregate"
}

xdebug_profiler_append() {
  #boxfile xdebug_profiler_append
  _xdebug_profiler_append=$(nos_validate "$(nos_payload config_xdebug_profiler_append)" "integer" "0")
  echo "_xdebug_profiler_append"
}

xdebug_profiler_enable() {
  #boxfile xdebug_profiler_enable
  _xdebug_profiler_enable=$(nos_validate "$(nos_payload config_xdebug_profiler_enable)" "integer" "0")
  echo "_xdebug_profiler_enable"
}

xdebug_profiler_enable_trigger() {
  #boxfile xdebug_profiler_enable_trigger
  _xdebug_profiler_enable_trigger=$(nos_validate "$(nos_payload config_xdebug_profiler_enable_trigger)" "integer" "0")
  echo "_xdebug_profiler_enable_trigger"
}

xdebug_profiler_enable_trigger_value() {
  #boxfile xdebug_profiler_enable_trigger_value
  _xdebug_profiler_enable_trigger_value=$(nos_validate "$(nos_payload config_xdebug_profiler_enable_trigger_value)" "string" "")
  echo "_xdebug_profiler_enable_trigger_value"
}

xdebug_profiler_output_dir() {
  #boxfile xdebug_profiler_output_dir
  _xdebug_profiler_output_dir=$(nos_validate "$(nos_payload config_xdebug_profiler_output_dir)" "string" "/tmp")
  echo "_xdebug_profiler_output_dir"
}

xdebug_profiler_output_name() {
  #boxfile xdebug_profiler_output_name
  _xdebug_profiler_output_name=$(nos_validate "$(nos_payload config_xdebug_profiler_output_name)" "string" "cachegrind.out.%p")
  echo "_xdebug_profiler_output_name"
}

xdebug_remote_addr_header() {
  #boxfile xdebug_remote_addr_header
  _xdebug_remote_addr_header=$(nos_validate "$(nos_payload config_xdebug_remote_addr_header)" "string" "")
  echo "_xdebug_remote_addr_header"
}

xdebug_remote_autostart() {
  #boxfile xdebug_remote_autostart
  _xdebug_remote_autostart=$(nos_validate "$(nos_payload config_xdebug_remote_autostart)" "integer" "0")
  echo "_xdebug_remote_autostart"
}

xdebug_remote_connect_back() {
  #boxfile xdebug_remote_connect_back
  _xdebug_remote_connect_back=$(nos_validate "$(nos_payload config_xdebug_remote_connect_back)" "integer" "0")
  echo "_xdebug_remote_connect_back"
}

xdebug_remote_cookie_expire_time() {
  #boxfile xdebug_remote_cookie_expire_time
  _xdebug_remote_cookie_expire_time=$(nos_validate "$(nos_payload config_xdebug_remote_cookie_expire_time)" "integer" "3600")
  echo "_xdebug_remote_cookie_expire_time"
}

xdebug_remote_enable() {
  #boxfile xdebug_remote_enable
  _xdebug_remote_enable=$(nos_validate "$(nos_payload config_xdebug_remote_enable)" "integer" "0")
  echo "_xdebug_remote_enable"
}

xdebug_remote_handler() {
  #boxfile xdebug_remote_handler
  _xdebug_remote_handler=$(nos_validate "$(nos_payload config_xdebug_remote_handler)" "string" "dbgp")
  echo "_xdebug_remote_handler"
}

xdebug_remote_host() {
  #boxfile xdebug_remote_host
  _xdebug_remote_host=$(nos_validate "$(nos_payload config_xdebug_remote_host)" "string" "localhost")
  echo "_xdebug_remote_host"
}

xdebug_remote_log() {
  #boxfile xdebug_remote_log
  _xdebug_remote_log=$(nos_validate "$(nos_payload config_xdebug_remote_log)" "string" "")
  echo "_xdebug_remote_log"
}

xdebug_remote_mode() {
  #boxfile xdebug_remote_mode
  _xdebug_remote_mode=$(nos_validate "$(nos_payload config_xdebug_remote_mode)" "string" "req")
  echo "_xdebug_remote_mode"
}

xdebug_remote_port() {
  #boxfile xdebug_remote_port
  _xdebug_remote_port=$(nos_validate "$(nos_payload config_xdebug_remote_port)" "integer" "9000")
  echo "_xdebug_remote_port"
}

xdebug_scream() {
  #boxfile xdebug_scream
  _xdebug_scream=$(nos_validate "$(nos_payload config_xdebug_scream)" "integer" "0")
  echo "_xdebug_scream"
}

xdebug_show_error_trace() {
  #boxfile xdebug_show_error_trace
  _xdebug_show_error_trace=$(nos_validate "$(nos_payload config_xdebug_show_error_trace)" "integer" "0")
  echo "_xdebug_show_error_trace"
}

xdebug_show_exception_trace() {
  #boxfile xdebug_show_exception_trace
  _xdebug_show_exception_trace=$(nos_validate "$(nos_payload config_xdebug_show_exception_trace)" "integer" "0")
  echo "_xdebug_show_exception_trace"
}

xdebug_show_local_vars() {
  #boxfile xdebug_show_local_vars
  _xdebug_show_local_vars=$(nos_validate "$(nos_payload config_xdebug_show_local_vars)" "integer" "0")
  echo "_xdebug_show_local_vars"
}

xdebug_show_mem_delta() {
  #boxfile xdebug_show_mem_delta
  _xdebug_show_mem_delta=$(nos_validate "$(nos_payload config_xdebug_show_mem_delta)" "integer" "0")
  echo "_xdebug_show_mem_delta"
}

xdebug_trace_enable_trigger() {
  #boxfile xdebug_trace_enable_trigger
  _xdebug_trace_enable_trigger=$(nos_validate "$(nos_payload config_xdebug_trace_enable_trigger)" "integer" "0")
  echo "_xdebug_trace_enable_trigger"
}

xdebug_trace_enable_trigger_value() {
  #boxfile xdebug_trace_enable_trigger_value
  _xdebug_trace_enable_trigger_value=$(nos_validate "$(nos_payload config_xdebug_trace_enable_trigger_value)" "string" "")
  echo "_xdebug_trace_enable_trigger_value"
}

xdebug_trace_format() {
  #boxfile xdebug_trace_format
  _xdebug_trace_format=$(nos_validate "$(nos_payload config_xdebug_trace_format)" "integer" "0")
  echo "_xdebug_trace_format"
}

xdebug_trace_options() {
  #boxfile xdebug_trace_options
  _xdebug_trace_options=$(nos_validate "$(nos_payload config_xdebug_trace_options)" "integer" "0")
  echo "_xdebug_trace_options"
}

xdebug_trace_output_dir() {
  #boxfile xdebug_trace_output_dir
  _xdebug_trace_output_dir=$(nos_validate "$(nos_payload config_xdebug_trace_output_dir)" "string" "/tmp")
  echo "_xdebug_trace_output_dir"
}

xdebug_trace_output_name() {
  #boxfile xdebug_trace_output_name
  _xdebug_trace_output_name=$(nos_validate "$(nos_payload config_xdebug_trace_output_name)" "string" "trace.%c")
  echo "_xdebug_trace_output_name"
}

xdebug_var_display_max_children() {
  #boxfile xdebug_var_display_max_children
  _xdebug_var_display_max_children=$(nos_validate "$(nos_payload config_xdebug_var_display_max_children)" "integer" "128")
  echo "_xdebug_var_display_max_children"
}

xdebug_var_display_max_data() {
  #boxfile xdebug_var_display_max_data
  _xdebug_var_display_max_data=$(nos_validate "$(nos_payload config_xdebug_var_display_max_data)" "integer" "512")
  echo "_xdebug_var_display_max_data"
}

xdebug_var_display_max_depth() {
  #boxfile xdebug_var_display_max_depth
  _xdebug_var_display_max_depth=$(nos_validate "$(nos_payload config_xdebug_var_display_max_depth)" "integer" "3")
  echo "_xdebug_var_display_max_depth"
}
