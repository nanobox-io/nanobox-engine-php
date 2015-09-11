# Advanced PHP Configuration Options

This engine exposes configuration option through the [Boxfile](http://docs.nanobox.io/boxfile/), a yaml config file used to provision and configure your app's infrastructure when using Nanobox. Being a generic PHP engine, there are a lot of configuration options to try to allow compatibility with as many PHP apps as possible. This engine makes the following options available.

#### Overview of Boxfile Configuration Options
```yaml
build:
  # Web Server Settings
  webserver: 'apache'
  document_root: '/'

  # PHP Settings
  runtime: 'php-5.6'
  php_extensions:
    - curl
    - gd
    - mbstring
    - pdo_mysql
  php_zend_extensions:
    - ioncube_loader
    - opcache
  php_short_open_tag: true
  php_zlib_output_compression: 'Off'
  php_allow_url_fopen: 'On'
  php_disable_functions:
    - exec
    - shell_exec
    - system
  php_expose_php: 'On'
  php_max_execution_time: 30
  php_max_input_time: 30
  php_memory_limit: '128M'
  php_error_reporting: E_ALL
  php_display_errors: 'stderr'
  php_register_globals: 'Off'
  php_register_argc_argv: 'Off'
  php_post_max_size: '8M'
  php_upload_max_filesize: '2M'
  php_file_uploads: true
  php_max_file_uploads: 20
  php_max_input_vars: 1000
  php_default_mimetype: 'text/html'
  php_default_locale: 'en_US'
  php_browscap: 'app/browscap.ini'
  php_session_save_handler: 'files'
  php_session_save_path: 'app/sessions'
  php_session_length: 3600
  php_session_autostart: false
  php_date_timezone: 'US/central'
  php_iconv_internal_encoding: 'UTF-8'

  # JS Runtime Settings
  js_runtime: 'nodejs-0.12'

  # Apache Settings
  apache_document_root: '/'
  apache_index_list:
    - index.php
    - index.html
  apache_default_gateway: 'index.php'
  apache_php_interpreter: fpm
  apache_modules:
    - actions
    - alias
    - rewrite
  apache_max_spares: 10
  apache_max_clients: 128
  apache_server_limit: 128
  apache_max_requests: 10000
  apache_static_expire: 86400
  apache_log_level: warn
  apache_access_log: false

  # Nginx Settings
  nginx_document_root: '/'
  nginx_index_list:
    - index.php
    - index.html
  nginx_default_gateway: 'index.php'

  # Built-In PHP Web Server Settings
  builtin_document_root: '/'
  
  # PHP-FPM Settings
  php_fpm_events_mechanism: 'epoll'
  php_fpm_max_children: 20
  php_fpm_max_spare_servers: 1
  php_fpm_max_requests: 128

  # PHP GeoIP Settings
  php_geoip_custom_directory: 'app/GeoIP/'

  # PHP Memcache Settings
  php_memcache_chunk_size: 8192
  php_memcache_hash_strategy: 'standard'

  # PHP Mongo Settings
  php_mongo_native_long: 1
  php_mongo_allow_empty_keys: 0
  php_mongo_cmd: '$'
  php_mongo_long_as_object: 0

  # PHP APC Settings
  php_apc_shm_size: '32M'
  php_apc_num_files_hint: 1000
  php_apc_user_entries_hint: 4096
  php_apc_filters: ''

  # PHP eAccelerator Settings
  php_eaccelerator_shm_max: '0'
  php_eaccelerator_shm_size: '0'
  php_eaccelerator_filter: ''

  # PHP OPcache Settings
  php_opcache_memory_consumption: 64
  php_opcache_validate_timestamps: 1
  php_opcache_revalidate_freq: 2
  php_opcache_revalidate_path: 0
  php_opcache_save_comments: 1
  php_opcache_load_comments: 1
  php_opcache_enable_file_override: 0
  php_opcache_optimization_level: '0xffffffff'
  php_opcache_inherited_hack: 1
  php_opcache_dups_fix: 0
  php_opcache_blacklist_filename: ''

  # PHP XCache Settings
  php_xcache_size: 0
  php_xcache_var_size: 0
  php_xcache_admin_user: 'mOo'
  php_xcache_admin_pass: ''

  # PHP New Relic Settings
  php_newrelic_capture_params: false
  php_newrelic_ignored_params: ''
  php_newrelic_loglevel: info
  php_newrelic_framework: 'laravel'
  php_newrelic_framework_drupal_modules: true
  php_newrelic_browser_monitoring_auto_instrument: true
  php_newrelic_transaction_tracer_enabled: true
  php_newrelic_transaction_tracer_detail: 1
  php_newrelic_transaction_tracer_record_sql: 'obfuscated'
  php_newrelic_transaction_tracer_threshold: 'apdex_f'
  php_newrelic_transaction_tracer_stack_trace_threshold: '500'
  php_newrelic_transaction_tracer_explain_threshold: '500'
  php_newrelic_transaction_tracer_slow_sql: true
  php_newrelic_transaction_tracer_custom: ''
  php_newrelic_error_collector_enabled: true
  php_newrelic_error_collector_record_database_errors: true
  php_newrelic_webtransaction_name_files: ''
  php_newrelic_webtransaction_name_functions: ''
  php_newrelic_webtransaction_name_remove_trailing_path: false
```

##### Quick Links
[Web Server Settings](#web-server-settings)  
[PHP Settings](#php-settings)  
[JS Runtime Settings](#js-runtime-settings)
[Apache Settings](#apache-settings)  
[Nginx Settings](#nginx-settings)  
[Built-In PHP Web Server Settings](#built-in-php-web-server-settings)  
[PHP-FPM Settings](#php-fpm-settings)  
[PHP GeoIP Settings](#php-geoip-settings)  
[PHP Memcache Settings](#php-memcache-settings)  
[PHP Mongo Settings](#php-mongo-settings)  
[PHP APC Settings](#php-apc-settings)  
[PHP eAccelerator Settings](#php-eaccelerator-settings)  
[PHP OPcache Settings](#php-opcache-settings)  
[PHP XCache Settings](#php-xcache-settings)  
[PHP New Relic Settings](#php-new-relic-settings)  

### Web Server Settings
The following setting is used to select which web server to use in your application.

- [webserver](#webserver)
- [document_root](#document_root)

---

##### `webserver`
The following web servers are available:

- apache *(default)*
- nginx
- builtin ([PHP's built-in web server](http://php.net/manual/en/features.commandline.webserver.php) available in 5.4+)

```yaml
build:
  webserver: 'apache'
```

*Web server specific settings are available in the [Apache Settings](#apache-settings), [Nginx Settings](#nginx-settings), & [Built-In PHP Web Server Settings](#built-in-php-web-server-settings) sections below.*

---

##### `document_root`
The public root of your web application. For instance, if you like to house your app in `/public` for security or organizational purposes, you can specify that here. The default is the `/`.
```yaml
build:
  document_root: '/'
```

---

### PHP Settings
The following settings are typically configured in the php.ini. When using Nanobox, these are configured in the Boxfile.

- [runtime](#runtime)
- [php_extensions](#php_extensions)
- [php_zend_extensions](#php_zend_extensions)
- [php_short_open_tag](#php_short_open_tag)
- [php_zlib_output_compression](#php_zlib_output_compression)
- [php_allow_url_fopen](#php_allow_url_fopen)
- [php_disable_functions](#php_disable_functions)
- [php_expose_php](#php_expose_php)
- [php_max_execution_time](#php_max_execution_time)
- [php_max_input_time](#php_max_input_time)
- [php_memory_limit](#php_memory_limit)
- [php_error_reporting](#php_error_reporting)
- [php_display_errors](#php_display_errors)
- [php_register_globals](#php_register_globals)
- [php_register_argc_argv](#php_register_argc_argv)
- [php_post_max_size](#php_post_max_size)
- [php_upload_max_filesize](#php_upload_max_filesize)
- [php_file_uploads](#php_file_uploads)
- [php_max_file_uploads](#php_max_file_uploads)
- [php_max_input_vars](#php_max_input_vars)
- [php_default_mimetype](#php_default_mimetype)
- [php_default_locale](#php_default_locale)
- [php_browscap](#php_browscap)
- [php_session_save_handler](#php_session_save_handler)
- [php_session_save_path](#php_session_save_path)
- [php_session_length](#php_session_length)
- [php_session_autostart](#php_session_autostart)
- [php_date_timezone](#php_date_timezone)
- [php_iconv_internal_encoding](#php_iconv_internal_encoding)

---

##### `runtime`
Specifies which PHP runtime and version to use. The following runtimes are available:

- 5.3
- 5.4
- 5.5
- 5.6

```yaml
build:
  runtime: 'php-5.6'
```

---

##### `php_extensions`
Specifies what PHP extensions should be included in your app's environment. To see what PHP extensions are available, view the [full list of available PHP extensions](https://github.com/pagodabox/nanobox-engine-php/blob/master/doc/php-extensions.md).

```yaml
build:
  php_extensions:
    - curl
    - gd
    - mbstring
    - pdo_mysql
```

---

##### `php_zend_extensions`
Specifies what Zend extensions should be included in your app's environment. To see what Zend extensions are available, view the [Zend Extensions section of the PHP extensions list](https://github.com/pagodabox/nanobox-engine-php/blob/master/doc/php-extensions.md#zend-extensions).
```yaml
build:
  php_zend_extensions:
    - ioncube_loader
    - opcache
```

---

##### `php_short_open_tag`
Sets the [`short_open_tag` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.short-open-tag).
```yaml
build:
  php_short_open_tag: true
```

---

##### `php_zlib_output_compression`
Sets the [`zlib.output_compression` PHP setting](http://php.net/manual/en/zlib.configuration.php#ini.zlib.output-compression).
```yaml
build:
  php_zlib_output_compression: 'Off'
```

---

##### `php_allow_url_fopen`
Sets the [`allow_url_fopen` PHP setting](http://php.net/manual/en/filesystem.configuration.php#ini.allow-url-fopen).
```yaml
build:
  php_allow_url_fopen: 'On'
```

---

##### `php_disable_functions`
Sets the [`disable_fuctions` PHP setting](http://php.net/manual/en/ini.core.php#ini.disable-functions).
```yaml
build:
  php_disable_functions:
    - exec
    - shell_exec
    - system
```

---

##### `php_expose_php`
Sets the [`expose_php` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.expose-php).
```yaml
build:
  php_expose_php: 'On'
```

---

##### `php_max_execution_time`
Sets the [`max_execution_time` PHP setting](http://www.php.net/manual/en/info.configuration.php#ini.max-execution-time).
```yaml
build:
  php_max_execution_time: 30
```

---

##### `php_max_input_time`
Sets the [`max_input_time` PHP setting](http://www.php.net/manual/en/info.configuration.php#ini.max-input-time).
```yaml
build:
  php_max_input_time: 60
```

---

##### `php_memory_limit`
Sets the [`memory_limit` PHP setting](http://php.net/manual/en/ini.core.php#ini.memory-limit). **Note:** This setting should not exceed the memory available on your PHP server(s).
```yaml
build:
  php_memory_limit: '128M'
```

---

##### `php_error_reporting`
Sets the [`error_reporting` PHP setting](http://www.php.net/manual/en/errorfunc.configuration.php#ini.error-reporting).
```yaml
build:
  php_error_reporting: E_ALL
```

---

##### `php_display_errors`
Sets the [`display_errors` PHP setting](http://us3.php.net/manual/en/errorfunc.configuration.php#ini.display-errors).
```yaml
build:
  php_display_errors: 'stderr'
```

---

##### `php_register_globals`
Sets the [`register_globals` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.register-globals)
```yaml
build:
  php_register_globals: 'Off'
```

---

##### `php_register_argc_argv`
Sets the [`register_argc_argv` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.register-argc-argv).
```yaml
build:
  php_register_argc_argv: 'Off'
```

---

##### `php_post_max_size`
Sets the [`post_max_size` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.post-max-size).
```yaml
build:
  php_post_max_size: '8M'
```

---

##### `php_upload_max_filesize`
Sets the [`upload_max_filesize` PHP setting](http://php.net/manual/en/ini.core.php#ini.upload-max-filesize).
```yaml
build:
  php_upload_max_filesize: '2M'
```

---

##### `php_file_uploads`
Sets the [`file_uploads` PHP setting](http://php.net/manual/en/ini.core.php#ini.file-uploads).
```yaml
build:
  php_file_uploads: true
```

---

##### `php_max_file_uploads`
Sets the [`max_file_uploads` PHP setting](http://php.net/manual/en/ini.core.php#ini.max-file-uploads).
```yaml
build:
  php_max_file_uploads: 20
```

---

##### `php_max_input_vars`
Sets the [`max_input_vars` PHP setting](http://php.net/manual/en/info.configuration.php#ini.max-input-vars).
```yaml
build:
  php_max_input_vars: 1000
```

---

##### `php_default_mimetype`
Sets the [`default_mime_type` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.default-mimetype).
```yaml
build:
  php_default_mimetype: 'text/html'
```

---

##### `php_default_locale`
Sets the [`intl.default_locale` PHP setting](http://php.net/manual/en/intl.configuration.php#ini.intl.default-locale).
```yaml
build:
  php_default_locale: 'en_US'
```

---

##### `php_browscap`
This allows you to specify the filepath to your browser capabilities file (browscap.ini). See [PHP.net Docs](http://php.net/manual/en/misc.configuration.php#ini.browscap) for definition & configuration options. When specifying the path to your browscap.ini in your Boxfile, it should relative to the root of your repo.

***Note:*** You must include your own browscap.ini in your app's repo. They are available for free from [browscap.org](http://browscap.org/).

```yaml
build:
  php_browscap: 'app/browscap.ini'
```

---

##### `php_session_save_handler`
Sets the [`session.save_handler` PHP setting](http://www.php.net/manual/en/session.configuration.php#ini.session.save-handler).
```yaml
build:
  php_session_save_handler: 'files'
```

---

##### `php_session_save_path`
Sets the [`session.save_path` PHP setting](http://www.php.net/manual/en/session.configuration.php#ini.session.save-path).
```yaml
build:
  php_session_save_path: '/tmp/nanobox/sessions'
```

---

##### `php_session_length`
Sets the [`session.gc_maxlifetime` PHP setting](http://www.php.net/manual/en/session.configuration.php#ini.session.gc-maxlifetime).
```yaml
build:
  php_session_length: 3600
```

---

##### `php_session_autostart`
Sets the [`session.autostart` PHP setting](http://www.php.net/manual/en/session.configuration.php#ini.session.auto-start).
```yaml
build:
  php_session_autostart: 'false'
```

---

##### `php_date_timezone`
Sets the [`date.timezone` PHP setting](http://php.net/manual/en/datetime.configuration.php#ini.date.timezone).
```yaml
build:
  php_date_timezone: 'US/central'
```

---

##### `php_iconv_internal_encoding`
Sets the [`iconv.internal_encoding` PHP setting](http://www.php.net/manual/en/iconv.configuration.php#ini.iconv.internal-encoding).
```yaml
build:
  php_iconv_internal_encoding: 'UTF-8'
```

---

### JS Runtime Settings
Many PHP applications utilize Javascript tools in some way. The most common use is static asset compilation. This engine allows you to specify which JS runtime you'l like to use.

---

##### `js_runtime`
Specifies which JS runtime and version to use. The following runtimes are available:

- nodejs-0.8
- nodejs-0.10
- nodejs-0.12
- iojs-2.3

```yaml
build:
  js_runtime: 'nodejs-0.12'
```

---

### Apache Settings
The following settings are used to configure Apache. These only apply when using `apache` as your `webserver`.

- [apache_document_root](#apache_document_root)
- [apache_index_list](#apache_index_list)
- [apache_default_gateway](#apache_default_gateway)
- [apache_php_interpreter](#apache_php_interpreter)
- [apache_modules](#apache_modules)
- [apache_max_spares](#apache_max_spares)
- [apache_max_clients](#apache_max_clients)
- [apache_server_limit](#apache_server_limit)
- [apache_max_requests](#apache_max_requests)
- [apache_static_expire](#apache_static_expire)
- [apache_log_level](#apache_log_level)
- [apache_access_log](#apache_access_log)

---

##### `apache_document_root`
The public root of your web application. For instance, if you like to house your app in `/public` for security or organizational purposes, you can specify that here. The default is the `/`.

**Note:** If both this setting and the [global `document_root`](#document_root) are set, the `builtin_document_root` will take precedence.

```yaml
build:
  apache_document_root: '/'
```

---

##### `apache_index_list`
When a path is not specified in the url, these files are served in order in which they're listed.
```yaml
build:
  apache_index_list:
    - index.php
    - index.html
```

---

##### `apache_default_gateway`
When a path is not specified in the url, this files is served. *This is similar to [`apache_index_list`](#apache_index_list) except it only accepts a single argument.*
```yaml
build:
  apache_default_gateway: "index.php"
```

---

##### `apache_php_interpreter`

Specify which PHP interpreter you would like Apache to use.

- fpm *(default)*
- mod_php

```yaml
build:
  apache_php_interpreter: fpm
```

---

##### `apache_modules`

Specify which Apache modules to enable or disable. View the [full list of available Apache Modules](https://github.com/pagodabox/nanobox-engine-php/blob/master/doc/apache-modules.md). By default, all modules are enabled.
```yaml
build:
  apache_modules
```

---

##### `apache_max_spares`

Sets Apaches [`MaxSpareServers` directive](http://httpd.apache.org/docs/2.2/mod/prefork.html#maxspareservers).
```yaml
build:
  apache_max_spares: 10
```

---

##### `apache_max_clients`
Sets Apache's [`MaxClients` directive](http://httpd.apache.org/docs/2.2/mod/mpm_common.html#maxclients). **Note:**This configuration must be less than or equal to the [`apache_server_limit`](#apache_server_limit).
```yaml
build:
  apache_max_clients: 128
```

---

##### `apache_server_limit`
Sets Apaches [`ServerLimit` directive](http://httpd.apache.org/docs/2.2/mod/mpm_common.html#serverlimit). **Note:** This configuration must be greater than or equal to the [`apache_max_clients`](#apache_max_clients).
```yaml
build:
  apache_server_limit: 128
```

---

##### `apache_max_requests`
Sets Apache's [`MaxRequestsPerChild` directive](http://httpd.apache.org/docs/2.2/mod/mpm_common.html#maxrequestsperchild).
```yaml
build:
  apache_max_requests: 10000
```

---

##### `apache_static_expire`
Adds far future expires to your header, setting the number of seconds static assets are cached. By default, static asset caching is not enabled. We only recommend using this directive on apps whose static assets do not change often.
```yaml
build:
  apache_static_expire: 86400
```

---

##### `apache_log_level`
Sets Apache's [`LogLevel` directive](http://httpd.apache.org/docs/2.2/mod/core.html#loglevel).
```yaml
build:
  apache_log_level: warn
```

---

##### `apache_access_log`
Enables or disables the Apache Access log.
```yaml
build:
  apache_access_log: false
```

---

### Nginx Settings
These settings are used to configure nginx. They only apply when using `nginx` as your `webserver`.

- [nginx_document_root](#nginx_document_root)
- [nginx_index_list](#nginx_index_list)
- [nginx_default_gateway](#nginx_default_gateway)

---

##### `nginx_document_root`
The public root of your web application. For instance, if you like to house your app in `/public` for security or organizational purposes, you can specify that here. The default is the `/`.

**Note:** If both this setting and the [global `document_root`](#document_root) are set, the `nginx_document_root` will take precedence.

```yaml
build:
  nginx_document_root: '/'
```

---

##### `nginx_index_list`
When a path is not specified in the url, these files are served in order in which they're listed.
```yaml
build:
  nginx_index_list:
    - index.php
    - index.html
```

---

##### `nginx_default_gateway`
When a path is not specified in the url, this files is served. *This is similar to [`nginx_index_list`](#nginx_index_list) except it only accepts a single argument.*
```yaml
build:
  nginx_default_gateway: 'index.php'
```

---

### Built-In PHP Web Server Settings
The following setting is used to configure the built-in PHP web server available in PHP 5.4+. These settings only apply when using `builtin` as your `webserver`.

---

##### `builtin_document_root`
The public root of your web application. For instance, if you like to house your app in `/public` for security or organizational purposes, you can specify that here. The default is the `/`.

**Note:** If both this setting and the [global `document_root`](#document_root) are set, the `builtin_document_root` will take precedence.

```yaml
build:
  builtin_document_root: '/'
```

---

### PHP-FPM Settings
These settings only apply when using `fpm` as your `apache_php_interpreter`.

- [php_fpm_events_mechanism](#php_fpm_events_mechanism)
- [php_fpm_max_children](#php_fpm_max_children)
- [php_fpm_max_spare_servers](#php_fpm_max_spare_servers)
- [php_fpm_max_requests](#php_fpm_max_requests)

---

##### `php_fpm_events_mechanism`
Sets `events.mechanism` setting in the `php-fpm.conf` which specifies the events mechanism FPM will use. More information is available in [PHP's documentation](http://php.net/manual/en/install.fpm.configuration.php#events-mechanism).
```yaml
build:
  php_fpm_events_mechanism: 'epoll'
```

---

##### `php_fpm_max_children`
Sets the maximum number of child processes that can be created by PHP.
```yaml
build:
  php_fpm_max_children: 20
```

---

##### `php_fpm_max_spare_servers`
The desired maximum number of idle server processes.
```yaml
build:
  php_fpm_max_spare_servers: 1
```

---

##### `php_fpm_max_requests`
Sets the number of requests each child process should execute before respawning. This can be useful to work around memory leaks in 3rd party libraries.
```yaml
build:
  php_fpm_max_requests: 128
```

---

### PHP GeoIP Settings
The following settings are used to configure the GeoIP PHP extension.

---

##### `php_geoip_custom_directory`
Sets the [`geoip.custom_directory` PHP setting](http://php.net/manual/en/geoip.configuration.php). When specifying the path to the directory, it should be relative to the root of your repo.

**Note:** When using the `geoip` php extension, you need to provide your own GeoIP database. Free databases are [available for download from Maxmind]http://dev.maxmind.com/geoip/legacy/geolite/#Downloads. Maxmind also provides subscription databases that tend to be more accurate.
```yaml
build:
  php_geoip_custom_directory: 'app/GeoIP/'
```

---

### PHP Memcache Settings
The following settings are used to configure the PHP Memcache driver.

- [php_memcache_chunk_size](#php_memcache_chunk_size)
- [php_memcache_hash_strategy](#php_memcache_hash_strategy)

---

##### `php_memcache_chunk_size`
Sets the [`memcache.chunk_size` PHP setting](http://php.net/manual/en/memcache.ini.php#ini.memcache.chunk-size).
```yaml
build:
  php_memcache_chunk_size: 8192
```

---

##### `php_memcache_hash_strategy`
Sets the [`memcache.hash_strategy` PHP setting](http://php.net/manual/en/memcache.ini.php#ini.memcache.hash-strategy)
```yaml
build:
  php_memcache_hash_strategy: 'standard'
```

---

### PHP Mongo Settings
The following settings are used to configure the PHP Mongo driver.

- [php_mongo_native_long](#php_mongo_native_long)
- [php_mongo_allow_empty_keys](#php_mongo_allow_empty_keys)
- [php_mongo_cmd](#php_mongo_cmd)
- [php_mongo_long_as_object](#php_mongo_long_as_object)

---

##### `php_mongo_native_long`
Sets the [`mongo.native_long` PHP setting](http://php.net/manual/en/mongo.configuration.php#ini.mongo.native-long).
```yaml
build:
  php_mongo_native_long: 1
```

---

##### `php_mongo_allow_empty_keys`
Sets the [`mongo.allow_empty_keys` PHP setting](http://php.net/manual/en/mongo.configuration.php#ini.mongo.allow-empty-keys)
```yaml
build:
  php_mongo_allow_empty_keys: 0
```

---

##### `php_mongo_cmd`
Sets the [`mongo.cmd` PHP setting](http://php.net/manual/en/mongo.configuration.php#ini.mongo.cmd).
```yaml
build:
  php_mongo_cmd: '$'
```

---

##### `php_mongo_long_as_object`
Sets the [`mongo.long_as_object` PHP setting](http://php.net/manual/en/mongo.configuration.php#ini.mongo.long-as-object).
```yaml
build:
  php_mongo_long_as_object: 0
```

---

### PHP APC Settings
The following settings are used to configure APC, a PHP byte-code caching engine available in PHP versions 5.3 and 5.4.

- [php_apc_shm_size](#php_apc_shm_size)
- [php_apc_num_files_hint](#php_apc_num_files_hint)
- [php_apc_user_entries_hint](#php_apc_user_entries_hint)
- [php_apc_filters](#php_apc_filters)

---

##### `php_apc_shm_size`
Sets the [`apc.shm_size` PHP setting](http://php.net/manual/en/apc.configuration.php#ini.apc.shm-size).
```yaml
build:
  php_apc_shm_size: '32M'
```

##### `php_apc_num_files_hint`
Sets the [`apc.num_files_hint` PHP setting](http://php.net/manual/en/apc.configuration.php#ini.apc.num-files-hint).
```yaml
build:
  php_apc_num_files_hint: 1000
```

---

##### `php_apc_user_entries_hint`
Sets the [`apc.user_entries_hint` PHP setting](http://php.net/manual/en/apc.configuration.php#ini.apc.user-entries-hint).
```yaml
build:
  php_apc_user_entries_hint: 4096
```

---

##### `php_apc_filters`
Sets the [`apc.filters` PHP setting](http://php.net/manual/en/apc.configuration.php#ini.apc.filters).
```yaml
build:
  php_apc_filters: ''
```

---

### PHP eAccelerator Settings
The following settings are used to configure eAccelerator, a PHP byte-code caching engine available in PHP versions 5.3 and 5.4.

- [php_eaccelerator_shm_max](#php_eaccelerator_shm_max)
- [php_eaccelerator_shm_size](#php_eaccelerator_shm_size)
- [php_eaccelerator_filter](#php_eaccelerator_filter)

---

##### `php_eaccelerator_shm_max`
Sets the [`eaccelerator.shm_max` setting](https://github.com/eaccelerator/eaccelerator/wiki/Settings#eacceleratorshm_max).
```yaml
build:
  php_eaccelerator_shm_max: '0'
```

---

##### `php_eaccelerator_shm_size`
Sets the [`eaccelerator.shm_size` setting](https://github.com/eaccelerator/eaccelerator/wiki/Settings#eacceleratorshm_size).
```yaml
build:
  php_eaccelerator_shm_size: '0'
```

---

##### `php_eaccelerator_filter`
Sets the [`eaccelerator.filter` setting](https://github.com/eaccelerator/eaccelerator/wiki/Settings#eacceleratorfilter).
```yaml
build:
   php_eaccelerator_filter: ''
```

---

### PHP Opcache Settings
The following settings are used to configure the OPcache PHP byte-code caching engine.

- [php_opcache_memory_consumption](#php_opcache_memory_consumption)
- [php_opcache_validate_timestamps](#php_opcache_validate_timestamps)
- [php_opcache_revalidate_freq](#php_opcache_revalidate_freq)
- [php_opcache_revalidate_path](#php_opcache_revalidate_path)
- [php_opcache_save_comments](#php_opcache_save_comments)
- [php_opcache_load_comments](#php_opcache_load_comments)
- [php_opcache_enable_file_override](#php_opcache_enable_file_override)
- [php_opcache_optimization_level](#php_opcache_optimization_level)
- [php_opcache_inherited_hack](#php_opcache_inherited_hack)
- [php_opcache_dups_fix](#php_opcache_dups_fix)
- [php_opcache_blacklist_filename](#php_opcache_blacklist_filename)

---

##### `php_opcache_memory_consumption`
Sets the [`opcache.memory_consumption` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.memory-consumption).
```yaml
build:
  php_opcache_memory_consumption: 64
```

---

##### `php_opcache_validate_timestamps`
Sets the [`opcache.validate_timestamps` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.validate-timestamps).
```yaml
build:
  php_opcache_validate_timestamps: 1
```

---

##### `php_opcache_revalidate_freq`
Sets the [`opcache.revalidate_freq` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.revalidate-freq)
```yaml
build:
  php_opcache_revalidate_freq: 2
```

---

##### `php_opcache_revalidate_path`
Sets the [`opcache.revalidate_path` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.revalidate-path).
```yaml
build:
  php_opcache_revalidate_path: 0
```

---

##### `php_opcache_save_comments`
Sets the [`opcache.save_comments` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.save-comments).
```yaml
build:
  php_opcache_save_comments: 1
```

---

##### `php_opcache_load_comments`
Sets the [`opcache_load_comments` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.load-comments).
```yaml
build:
  php_opcache_load_comments: 1
```

---

##### `php_opcache_enable_file_override`
Sets the [`opcache.enable_file_override` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.enable-file-override).
```yaml
build:
  php_opcache_enable_file_override: 0
```

---

##### `php_opcache_optimization_level`
Sets the [`opcache.optimization_level` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.optimization-level).
```yaml
build:
  php_opcache_optimization_level: '0xffffffff'
```

---

##### `php_opcache_inherited_hack`
Sets the [`opcache.inherited_hack` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.inherited-hack).
```yaml
build:
  php_opcache_inherited_hack: 1
```

---

##### `php_opcache_dups_fix`
Sets the [`opcache.dups_fix` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.dups-fix).
```yaml
build:
  php_opcache_dups_fix: 0
```

---

##### `php_opcache_blacklist_filename`
Sets the [`opcache.blacklist_filename` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.blacklist-filename).
```yaml
build:
  php_opcache_blacklist_filename: ''
```

---

### PHP XCache Settings
The following settings are used to configure the XCache PHP byte-code caching engine.

- [php_xcache_size](#php_xcache_size)
- [php_xcache_var_size](#php_xcache_var_size)
- [php_xcache_admin_user](#php_xcache_admin_user)
- [php_xcache_admin_pass](#php_xcache_admin_pass)

---

##### `php_xcache_size`
Sets the [`xcache.size` setting](http://xcache.lighttpd.net/wiki/XcacheIni#XCacheCacher).
```yaml
build:
  php_xcache_size: 0
```

---

##### `php_xcache_var_size`
Sets the [`xcache.var_size` setting](http://xcache.lighttpd.net/wiki/XcacheIni#XCacheCacher).
```yaml
build:
  php_xcache_var_size: 0
```

---

##### `php_xcache_admin_user`
Sets the [`xcache.admin.user` setting](http://xcache.lighttpd.net/wiki/XcacheIni#XCacheAdministration).
```yaml
build:
  php_xcache_admin_user: 'mOo'
```

---

##### `php_xcache_admin_pass`
Sets the [`xcache_admin_pass` setting](http://xcache.lighttpd.net/wiki/XcacheIni#XCacheAdministration).
```yaml
build:
  php_xcache_admin_pass: ''
```

---

### PHP New Relic Settings
The following settings are used to configure the [PHP New Relic Agent](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration).

- [php_newrelic_capture_params](#php_newrelic_capture_params)
- [php_newrelic_ignored_params](#php_newrelic_ignored_params)
- [php_newrelic_loglevel](#php_newrelic_loglevel)
- [php_newrelic_framework](#php_newrelic_framework)
- [php_newrelic_framework_drupal_modules](#php_newrelic_framework_drupal_modules)
- [php_newrelic_browser_monitoring_auto_instrument](#php_newrelic_browser_monitoring_auto_instrument)
- [php_newrelic_transaction_tracer_enabled](#php_newrelic_transaction_tracer_enabled)
- [php_newrelic_transaction_tracer_detail](#php_newrelic_transaction_tracer_detail)
- [php_newrelic_transaction_tracer_record_sql](#php_newrelic_transaction_tracer_record_sql)
- [php_newrelic_transaction_tracer_threshold](#php_newrelic_transaction_tracer_threshold)
- [php_newrelic_transaction_tracer_stack_trace_threshold](#php_newrelic_transaction_tracer_stack_trace_threshold)
- [php_newrelic_transaction_tracer_explain_threshold](#php_newrelic_transaction_tracer_explain_threshold)
- [php_newrelic_transaction_tracer_slow_sql](#php_newrelic_transaction_tracer_slow_sql)
- [php_newrelic_transaction_tracer_custom](#php_newrelic_transaction_tracer_custom)
- [php_newrelic_error_collector_enabled](#php_newrelic_error_collector_enabled)
- [php_newrelic_error_collector_record_database_errors](#php_newrelic_error_collector_record_database_errors)
- [php_newrelic_webtransaction_name_files](#php_newrelic_webtransaction_name_files)
- [php_newrelic_webtransaction_name_functions](#php_newrelic_webtransaction_name_functions)
- [php_newrelic_webtransaction_name_remove_trailing_path](#php_newrelic_webtransaction_name_remove_trailing_path)

---

##### `php_newrelic_capture_params`
Sets the [`newrelic.capture_params` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-capture_params).
```yaml
build:
  php_newrelic_capture_params: false
```

---

##### `php_newrelic_ignored_params`
Sets the [`newrelic.ignored_params` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-ignored_params).
```yaml
build:
  php_newrelic_ignored_params: ''
```

---

##### `php_newrelic_loglevel`
Sets the [`newrelic.loglevel` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-loglevel).
```yaml
build:
  php_newrelic_loglevel: 'info'
```

---

##### `php_newrelic_framework`
Sets the [`newrelic.framework` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-framework).
```yaml
build:
  php_newrelic_framework: 'laravel'
```

---

##### `php_newrelic_framework_drupal_modules`
Sets the [`newrelic.framework.drupal.modules` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-framework-drupal-modules).
```yaml
build:
  php_newrelic_framework_drupal_modules: true
```

---

##### `php_newrelic_browser_monitoring_auto_instrument`
Sets the [`newrelic.browser_monitoring_auto_instrument` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-autorum).
```yaml
build:
  php_newrelic_browser_monitoring_auto_instrument: true
```

---

##### `php_newrelic_transaction_tracer_enabled`
Sets the [`newrelic.transaction_tracer.enabled` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-enable).
```yaml
build:
  php_newrelic_transaction_tracer_enabled: true
```

---

##### `php_newrelic_transaction_tracer_detail`
Sets the [`newrelic.transaction_tracer.detail` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-detail).
```yaml
build:
  php_newrelic_transaction_tracer_detail: 1
```

---

##### `php_newrelic_transaction_tracer_record_sql`
Sets the [`newrelic.transaction_tracer.record_sql` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-sql).
```yaml
build:
  php_newrelic_transaction_tracer_record_sql: 'obfuscated'
```

---

##### `php_newrelic_transaction_tracer_threshold`
Sets the [`newrelic.transaction_tracer.threshold` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-threshold).
```yaml
build:
  php_newrelic_transaction_tracer_threshold: 'apdex_f'
```

---

##### `php_newrelic_transaction_tracer_explain_threshold`
Sets the [`newrelic.transaction_tracer.explain_threshold` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-epthreshold).
```yaml
build:
  php_newrelic_transaction_tracer_explain_threshold: '500'
```

---

##### `php_newrelic_transaction_tracer_stack_trace_threshold`
Sets the [`newrelic.transaction_tracer.stack_trace_threshold` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-stthreshold).
```yaml
build:
  php_newrelic_transaction_tracer_stack_trace_threshold: '500'
```

---

##### `php_newrelic_transaction_tracer_slow_sql`
Sets the [`newrelic.transaction_tracer.slow_sql` setting](hhttps://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-slowsql).
```yaml
build:
  php_newrelic_transaction_tracer_slow_sql: true
```

---

##### `php_newrelic_transaction.tracer_custom`
Sets the [`newrelic.transaction_tracer.custom` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-custom).
```yaml
build:
  php_newrelic_transaction_tracer_custom: ''
```

---

##### `php_newrelic_error_collector_enabled`
Sets the [`newrelic.error_collector.enabled` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-err-enabled).
```yaml
build:
  php_newrelic_error_collector_enabled: true
```

---

##### `php_newrelic_error_collector_record_database_errors`
Sets the [`newrelic.error_collector.record_database_errors` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-err-db).
```yaml
build:
  php_newrelic_error_collector_record_database_errors: true
```

---

##### `php_newrelic_webtransaction_name_files`
Sets the [`newrelic.webtransaction.name.files` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-wt-files).
```yaml
build:
  php_newrelic_webtransaction_name_files: ''
```

---

##### `php_newrelic_webtransaction_name_functions`
Sets the [`newrelic.webtransaction.name.functions` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-wt-funcs).
```yaml
build:
  php_newrelic_webtransaction_name_functions: ''
```

---

##### `php_newrelic_webtransaction_name_remove_trailing_path`
Sets the [`newrelic.webtransaction.name_remove_trailing_path` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-wt-remove-path).
```yaml
build:
  php_newrelic_webtransaction_name_remove_trailing_path: false
```

---

## Help & Support
This is a generic (non-framework-specific) PHP engine provided by [Nanobox](http://nanobox.io). If you need help with this engine, you can reach out to us in the [#nanobox IRC channel](http://webchat.freenode.net/?channels=nanobox). If you are running into an issue with the engine, feel free to [create a new issue on this project](https://github.com/pagodabox/nanobox-engine-php/issues/new).
