# PHP

This is a generic PHP engine. This has a wide collection of PHP extensions available. In theory, anything that can be done with a PHP framework engine could be done with this one.

## Configuration Options

This engine exposes configuration option through the [Boxfile](http://docs.nanobox.io/boxfile/), a yaml config file used to provision and configure your app's infrastructure when using Nanobox. Being a generic PHP engine, there are a lot of configuration options to try to allow compatibility with as many PHP apps as possible. This engine makes the following options available.

#### Overview of Boxfile Configuration Options
```yaml
build:
  # Apache httpd Settings
  httpd_document_root:
  httpd_index_list:
  httpd_php_interpreter: mod_php
  httpd_modules: []
  httpd_max_spares:
  httpd_max_clients:
  httpd_server_limit:
  httpd_max_requests:
  httpd_default_gateway:
  httpd_static_expire:
  httpd_log_level:
  httpd_access_log:
  
  # PHP-FPM Settings
  php_fpm_events_mechanism:
  php_fpm_max_children:
  php_fpm_max_spare_servers:
  php_fpm_max_requests:

  # PHP Settings
  php_version:
  php_extensions:
  php_zend_extensions:
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
  php_session_length:
  php_default_locale:
  php_session_autostart:
  php_session_save_path:
  php_session_save_handler:
  php_date_timezone:
  php_iconv_internal_encoding:

  # PHP APC Settings
  php_apc_shm_size:
  php_apc_num_files_hint:
  php_apc_user_entries_hint:
  php_apc_filters:

  # PHP EAccelerator Settings
  php_eaccelerator_shm_max:
  php_eaccelerator_shm_size:
  php_eaccelerator_filter:

  # PHP GeoIP Settings
  php_geoip_custom_directory:

  # PHP Memcache Settings
  php_memcache_chunk_size:
  php_memcache_hash_strategy:

  # PHP Mongo Settings
  php_mongo_native_long:
  php_mongo_allow_empty_keys:
  php_mongo_cmd:
  php_mongo_long_as_object:

  # PHP Newrelic Settings
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

  # PHP Opcache Settings
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

  # PHP XCache Settings
  php_xcache_size:
  php_xcache_var_size:
  php_xcache_admin_user:
  php_xcache_admin_pass:
```

##### Quick Links
[Apache httpd Settings](#apache-httpd-settings)  
[PHP-FPM Settings](#php-fpm-settings)  
[PHP Settings](#php-settings)  
[PHP APC Settings](#php-apc-settings)  
[PHP EAccelerator Settings](#php-eaccelerator-settings)  
[PHP GeoIP Settings](#php-geoip-settings)  
[PHP Memcache Settings](#php-memcache-settings)  
[PHP Mongo Settings](#php-mongo-settings)  
[PHP Newrelic Settings](#php-newrelic-settings)  
[PHP Opcache Settings](#php-opcache-settings)  
[PHP XCache Settings](#php-xcache-settings)  

### Apache httpd Settings
---

##### `httpd_document_root`
The public root of your web application. For instance, if you like to house your app in `/public` for security or organizational purposes, you can specify that here. The default is the `/`.
```yaml
build:
  httpd_document_root: '/'
```

---

##### `httpd_index_list`
When a path is not specified in the url, these files are served in order in which they're listed.
```yaml
build:
  httpd_index_list:
    - index.php
    - index.html
```

---

##### `httpd_php_interpreter`

Specify which PHP interepreter you would like Apache to use.
```yaml
build:
  httpd_php_interpreter: fastcgi
```

- fastcgi *(default)*
- mod_php

---

##### `httpd_modules`

Specify which Apache modules to enable or disable. View the [full list of available Apache Modules](https://gist.github.com/sanderson/948bdf49ccea35496d3e). By default, all modules are enabled.
```yaml
build:
  httpd_modules
```

---

##### `httpd_max_spares`

Sets Apaches [`MaxSpareServers` directive](http://httpd.apache.org/docs/2.2/mod/prefork.html#maxspareservers).
```yaml
build:
  httpd_max_spares: 10
```

---

##### `httpd_max_clients`
Sets Apache's [`MaxClients` directive](http://httpd.apache.org/docs/2.2/mod/mpm_common.html#maxclients). **Note:**This configuration must be less than or equal to the [`httpd_server_limit`](#httpd_server_limit).
```yaml
build:
  httpd_max_clients: 128
```

---

##### `httpd_server_limit`
Sets Apaches [`ServerLimit` directive](http://httpd.apache.org/docs/2.2/mod/mpm_common.html#serverlimit). **Note:** This configuration must be greater than or equal to the [`httpd_max_clients`](#httpd_max_clients).
```yaml
build:
  httpd_server_limit: 128
```

---

##### `httpd_max_requests`
Sets Apache's [`MaxRequestsPerChild` directive](http://httpd.apache.org/docs/2.2/mod/mpm_common.html#maxrequestsperchild).
```yaml
build:
  httpd_max_requests: 10000
```

---

##### `httpd_default_gateway`
When a path is not specified in the url, this files is served. *This is similar to [`httpd_index_list`](#httpd_index_list) except it only accepts a single argument.*
```yaml
build:
  httpd_default_gateway: "index.php"
```

---

##### `httpd_static_expire`
Adds far future expires to your header, setting the number of seconds static assets are cached. By default, static asset caching is not enabled. We only recommend using this directive on apps whose static assets do not change often.
```yaml
build:
  httpd_static_expire: 86400
```

---

##### `httpd_log_level`
Sets Apache's [`LogLevel` directive](http://httpd.apache.org/docs/2.2/mod/core.html#loglevel).
```yaml
build:
  apache_log_level: warn
```

---

##### `httpd_access_log`
Enables or disables the Apache Access log.
```yaml
build:
  httpd_access_log: false
```

---

### PHP-FPM Settings
##### `php_fpm_events_mechanism`
##### `php_fpm_max_children`
##### `php_fpm_max_spare_servers`
##### `php_fpm_max_requests`

### PHP Settings
##### `php_version`
##### `php_extensions`
##### `php_zend_extensions`
##### `php_short_open_tag`
##### `php_zlib_output_compression`
##### `php_allow_url_fopen`
##### `php_disable_functions`
##### `php_expose_php`
##### `php_max_execution_time`
##### `php_max_input_time`
##### `php_memory_limit`
##### `php_error_reporting`
##### `php_display_errors`
##### `php_register_globals`
##### `php_register_argc_argv`
##### `php_post_max_size`
##### `php_default_mimetype`
##### `php_browscap`
##### `php_file_uploads`
##### `php_max_input_vars`
##### `php_upload_max_filesize`
##### `php_max_file_uploads`
##### `php_session_length`
##### `php_default_locale`
##### `php_session_autostart`
##### `php_session_save_path`
##### `php_session_save_handler`
##### `php_date_timezone`
##### `php_iconv_internal_encoding`

### PHP APC Settings:
##### `php_apc_shm_size`
##### `php_apc_num_files_hint`
##### `php_apc_user_entries_hint`
##### `php_apc_filters`

### PHP EAccelerator Settings:
##### `php_eaccelerator_shm_max`
##### `php_eaccelerator_shm_size`
##### `php_eaccelerator_filter`

### PHP GeoIP Settings:
##### `php_geoip_custom_directory`

### PHP Memcache Settings:
##### `php_memcache_chunk_size`
##### `php_memcache_hash_strategy`

### PHP Mongo Settings:
##### `php_mongo_native_long`
##### `php_mongo_allow_empty_keys`
##### `php_mongo_cmd`
##### `php_mongo_long_as_object`

### PHP Newrelic Settings:
##### `php_newrelic_capture_params`
##### `php_newrelic_ignored_params`
##### `php_newrelic_loglevel`
##### `php_newrelic_framework`
##### `php_newrelic_browser_monitoring_auto_instrument`
##### `php_newrelic_framework_drupal_modules`
##### `php_newrelic_transaction_tracer_detail`
##### `php_newrelic_transaction_tracer_enabled`
##### `php_newrelic_transaction_tracer_record_sql`
##### `php_newrelic_transaction_tracer_threshold`
##### `php_newrelic_transaction_tracer_stack_trace_threshold`
##### `php_newrelic_transaction_tracer_explain_threshold`
##### `php_newrelic_transaction_tracer_slow_sql`
##### `php_newrelic_transaction_tracer_custom`
##### `php_newrelic_error_collector_enabled`
##### `php_newrelic_error_collector_record_database_errors`
##### `php_newrelic_webtransaction_name_functions`
##### `php_newrelic_webtransaction_name_files`
##### `php_newrelic_webtransaction_name_remove_trailing_path`
##### `php_newrelic_synchronous_startup`

### PHP Opcache Settings:
##### `php_opcache_memory_consumption`
##### `php_opcache_validate_timestamps`
##### `php_opcache_revalidate_freq`
##### `php_opcache_revalidate_path`
##### `php_opcache_save_comments`
##### `php_opcache_load_comments`
##### `php_opcache_enable_file_override`
##### `php_opcache_optimization_level`
##### `php_opcache_inherited_hack`
##### `php_opcache_dups_fix`
##### `php_opcache_blacklist_filename`

### PHP XCache Settings:
##### `php_xcache_size`
##### `php_xcache_var_size`
##### `php_xcache_admin_user`
##### `php_xcache_admin_pass`

## Help & Support
*Engine developers are responsible for supporting their published engines. Here you should provide information about how users can request help in case of issues. You could provide an email address or simply direct them to submit an issue to the project on Github.*
