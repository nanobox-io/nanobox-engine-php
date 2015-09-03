# PHP

This is a generic PHP engine. This has a wide collection of PHP extensions available. In theory, anything that can be done with a PHP framework engine could be done with this one.

## Configuration Options

This engine exposes configuration option through the [Boxfile](http://docs.nanobox.io/boxfile/), a yaml config file used to provision and configure your app's infrastructure when using Nanobox. Being a generic PHP engine, there are a lot of configuration options to try to allow compatibility with as many PHP apps as possible. This engine makes the following options available.

#### Overview of Boxfile Configuration Options
```yaml
build:
  httpd_max_spares:
  httpd_max_clients:
  httpd_max_requests:
  httpd_server_limit:
  httpd_php_interpreter: mod_php
  httpd_modules: []
  httpd_document_root:
  httpd_index_list:
  httpd_default_gateway:
  httpd_static_expire:
  httpd_log_level:
  httpd_access_log:
  php_fpm_events_mechanism:
  php_fpm_max_children:
  php_fpm_max_spare_servers:
  php_fpm_max_requests:
  php_version:
  php_short_open_tag:
  php_zlib_output_compression:
  php_allow_url_fopen:
  php_disable_functions:
  php_expose_php:
  php_max_execution_time:
  php_max_input_time:
  php_memory_limit:
  php_error_reporting:
  php_display_errors:
  php_register_globals:
  php_register_argc_argv:
  php_post_max_size:
  php_default_mimetype:
  php_browscap:
  php_file_uploads:
  php_max_input_vars:
  php_upload_max_filesize:
  php_max_file_uploads:
  php_extensions:
  php_zend_extensions:
  php_session_length:
  php_default_locale:
  php_session_autostart:
  php_session_save_path:
  php_session_save_handler:
  php_date_timezone:
  php_iconv_internal_encoding:
  php_apc_shm_size:
  php_apc_num_files_hint:
  php_apc_user_entries_hint:
  php_apc_filters:
  php_eaccelerator_shm_max:
  php_eaccelerator_shm_size:
  php_eaccelerator_filter:
  php_geoip_custom_directory:
  php_memcache_chunk_size:
  php_memcache_hash_strategy:
  php_mongo_native_long:
  php_mongo_allow_empty_keys:
  php_mongo_cmd:
  php_mongo_long_as_object:
  php_newrelic_capture_params:
  php_newrelic_ignored_params:
  php_newrelic_loglevel:
  php_newrelic_framework:
  php_newrelic_browser_monitoring_auto_instrument:
  php_newrelic_framework_drupal_modules:
  php_newrelic_transaction_tracer_detail:
  php_newrelic_transaction_tracer_enabled:
  php_newrelic_transaction_tracer_record_sql:
  php_newrelic_transaction_tracer_threshold:
  php_newrelic_transaction_tracer_stack_trace_threshold:
  php_newrelic_transaction_tracer_explain_threshold:
  php_newrelic_transaction_tracer_slow_sql:
  php_newrelic_transaction_tracer_custom:
  php_newrelic_error_collector_enabled:
  php_newrelic_error_collector_record_database_errors:
  php_newrelic_webtransaction_name_functions:
  php_newrelic_webtransaction_name_files:
  php_newrelic_webtransaction_name_remove_trailing_path:
  php_newrelic_synchronous_startup:
  php_opcache_memory_consumption:
  php_opcache_validate_timestamps:
  php_opcache_revalidate_freq:
  php_opcache_revalidate_path:
  php_opcache_save_comments:
  php_opcache_load_comments:
  php_opcache_enable_file_override:
  php_opcache_optimization_level:
  php_opcache_inherited_hack:
  php_opcache_dups_fix:
  php_opcache_blacklist_filename:
  php_xcache_size:
  php_xcache_var_size:
  php_xcache_admin_user:
  php_xcache_admin_pass:
```

##### Quick Links
- [Apache httpd settings](#apache-httpd-settins)
- [PHP-FPM settings](#php-fpm-settings)
- [PHP settings](#php-settings)
- [PHP APC settings](#php-apc-settings)
- [PHP EAccelerator settings](#php-eaccelerator-settings)
- [PHP GeoIP settings](#php-geoip-settings)
- [PHP Memcache settings](#php-memcache-settings)
- [PHP Mongo settings](#php-mongo-settings)
- [PHP Newrelic settings](#php-newrelic-settings)
- [PHP Opcache settings](#php-opcache-settings)
- [PHP XCache settings](#php-xcache-settings)

#### Apache httpd settings

- httpd_max_spares
- httpd_max_clients
- httpd_max_requests
- httpd_server_limit
- httpd_php_interpreter
- httpd_modules
- httpd_document_root
- httpd_index_list
- httpd_default_gateway
- httpd_static_expire
- httpd_log_level
- httpd_access_log

#### PHP-FPM settings
- php_fpm_events_mechanism
- php_fpm_max_children
- php_fpm_max_spare_servers
- php_fpm_max_requests

#### PHP settings
- php_version
- php_short_open_tag
- php_zlib_output_compression
- php_allow_url_fopen
- php_disable_functions
- php_expose_php
- php_max_execution_time
- php_max_input_time
- php_memory_limit
- php_error_reporting
- php_display_errors
- php_register_globals
- php_register_argc_argv
- php_post_max_size
- php_default_mimetype
- php_browscap
- php_file_uploads
- php_max_input_vars
- php_upload_max_filesize
- php_max_file_uploads
- php_extensions
- php_zend_extensions
- php_session_length
- php_default_locale
- php_session_autostart
- php_session_save_path
- php_session_save_handler
- php_date_timezone
- php_iconv_internal_encoding

#### PHP APC settings:
- php_apc_shm_size
- php_apc_num_files_hint
- php_apc_user_entries_hint
- php_apc_filters

#### PHP EAccelerator settings:
- php_eaccelerator_shm_max
- php_eaccelerator_shm_size
- php_eaccelerator_filter

#### PHP GeoIP settings:
- php_geoip_custom_directory

#### PHP Memcache settings:
- php_memcache_chunk_size
- php_memcache_hash_strategy

#### PHP Mongo settings:
- php_mongo_native_long
- php_mongo_allow_empty_keys
- php_mongo_cmd
- php_mongo_long_as_object

#### PHP Newrelic settings:
- php_newrelic_capture_params
- php_newrelic_ignored_params
- php_newrelic_loglevel
- php_newrelic_framework
- php_newrelic_browser_monitoring_auto_instrument
- php_newrelic_framework_drupal_modules
- php_newrelic_transaction_tracer_detail
- php_newrelic_transaction_tracer_enabled
- php_newrelic_transaction_tracer_record_sql
- php_newrelic_transaction_tracer_threshold
- php_newrelic_transaction_tracer_stack_trace_threshold
- php_newrelic_transaction_tracer_explain_threshold
- php_newrelic_transaction_tracer_slow_sql
- php_newrelic_transaction_tracer_custom
- php_newrelic_error_collector_enabled
- php_newrelic_error_collector_record_database_errors
- php_newrelic_webtransaction_name_functions
- php_newrelic_webtransaction_name_files
- php_newrelic_webtransaction_name_remove_trailing_path
- php_newrelic_synchronous_startup

#### PHP Opcache settings:
- php_opcache_memory_consumption
- php_opcache_validate_timestamps
- php_opcache_revalidate_freq
- php_opcache_revalidate_path
- php_opcache_save_comments
- php_opcache_load_comments
- php_opcache_enable_file_override
- php_opcache_optimization_level
- php_opcache_inherited_hack
- php_opcache_dups_fix
- php_opcache_blacklist_filename

#### PHP XCache settings:
- php_xcache_size
- php_xcache_var_size
- php_xcache_admin_user
- php_xcache_admin_pass

## Help & Support
*Engine developers are responsible for supporting their published engines. Here you should provide information about how users can request help in case of issues. You could provide an email address or simply direct them to submit an issue to the project on Github.*
