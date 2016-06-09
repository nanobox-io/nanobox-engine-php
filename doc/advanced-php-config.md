# Advanced PHP Configuration Options

This engine exposes configuration options through the [Boxfile](http://docs.nanobox.io/boxfile/), a yaml config file used to provision and configure your app's infrastructure when using Nanobox. Being a generic PHP engine, there are a lot of configuration options to try to allow compatibility with as many PHP apps as possible. This engine makes the following options available.

#### Overview of Boxfile Configuration Options
```yaml
build:
  # Web Server Settings
  webserver: 'apache'
  document_root: '/'

  # PHP Settings
  runtime: 'php-5.6'
  extensions:
    - curl
    - gd
    - mbstring
    - pdo_mysql
  zend_extensions:
    - ioncube_loader
    - opcache
  short_open_tag: true
  zlib_output_compression: 'Off'
  allow_url_fopen: 'On'
  disable_functions:
    - exec
    - shell_exec
    - system
  expose_php: 'On'
  max_execution_time: 30
  max_input_time: 30
  memory_limit: '128M'
  error_reporting: E_ALL
  display_errors: 'stderr'
  register_globals: 'Off'
  register_argc_argv: 'Off'
  post_max_size: '8M'
  upload_max_filesize: '2M'
  file_uploads: true
  max_file_uploads: 20
  max_input_vars: 1000
  default_mimetype: 'text/html'
  default_locale: 'en_US'
  browscap: 'app/browscap.ini'
  session_save_handler: 'files'
  session_save_path: 'app/sessions'
  session_length: 3600
  session_autostart: false
  date_timezone: 'US/central'
  iconv_internal_encoding: 'UTF-8'

  # Node.js Runtime Settings
  nodejs_runtime: 'nodejs-4.2'

  # Apache Settings
  apache_document_root: '/'
  apache_index_list:
    - index.php
    - index.html
  apache_default_gateway: 'index.php'
  apache_php_interpreter: php_fpm
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
  geoip_custom_directory: 'app/GeoIP/'

  # PHP Memcache Settings
  memcache_chunk_size: 8192
  memcache_hash_strategy: 'standard'

  # PHP Mongo Settings
  mongo_native_long: 1
  mongo_allow_empty_keys: 0
  mongo_cmd: '$'
  mongo_long_as_object: 0

  # PHP APC Settings
  apc_shm_size: '32M'
  apc_num_files_hint: 1000
  apc_user_entries_hint: 4096
  apc_filters: ''

  # PHP eAccelerator Settings
  eaccelerator_shm_max: '0'
  eaccelerator_shm_size: '0'
  eaccelerator_filter: ''

  # PHP OPcache Settings
  opcache_memory_consumption: 64
  opcache_validate_timestamps: 1
  opcache_revalidate_freq: 2
  opcache_revalidate_path: 0
  opcache_save_comments: 1
  opcache_load_comments: 1
  opcache_enable_file_override: 0
  opcache_optimization_level: '0xffffffff'
  opcache_inherited_hack: 1
  opcache_dups_fix: 0
  opcache_blacklist_filename: ''

  # PHP XCache Settings
  xcache_size: 0
  xcache_var_size: 0
  xcache_admin_user: 'mOo'
  xcache_admin_pass: ''

  # PHP New Relic Settings
  newrelic_capture_params: false
  newrelic_ignored_params: ''
  newrelic_loglevel: info
  newrelic_framework: 'laravel'
  newrelic_framework_drupal_modules: true
  newrelic_browser_monitoring_auto_instrument: true
  newrelic_transaction_tracer_enabled: true
  newrelic_transaction_tracer_detail: 1
  newrelic_transaction_tracer_record_sql: 'obfuscated'
  newrelic_transaction_tracer_threshold: 'apdex_f'
  newrelic_transaction_tracer_stack_trace_threshold: '500'
  newrelic_transaction_tracer_explain_threshold: '500'
  newrelic_transaction_tracer_slow_sql: true
  newrelic_transaction_tracer_custom: ''
  newrelic_error_collector_enabled: true
  newrelic_error_collector_record_database_errors: true
  newrelic_webtransaction_name_files: ''
  newrelic_webtransaction_name_functions: ''
  newrelic_webtransaction_name_remove_trailing_path: false
```

##### Quick Links
[Web Server Settings](#web-server-settings)  
[PHP Settings](#php-settings)  
[Node.js Runtime Settings](#nodejs-runtime-settings)  
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

#### webserver
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

#### document_root
The public root of your web application. For instance, if you like to house your app in `/public` for security or organizational purposes, you can specify that here. The default is the `/`.
```yaml
build:
  document_root: '/'
```

---

### PHP Settings
The following settings are typically configured in the php.ini. When using Nanobox, these are configured in the Boxfile.

- [runtime](#runtime)
- [extensions](#extensions)
- [zend_extensions](#zend_extensions)
- [short_open_tag](#short_open_tag)
- [zlib_output_compression](#zlib_output_compression)
- [allow_url_fopen](#allow_url_fopen)
- [disable_functions](#disable_functions)
- [expose_php](#expose_php)
- [max_execution_time](#max_execution_time)
- [max_input_time](#max_input_time)
- [memory_limit](#memory_limit)
- [error_reporting](#error_reporting)
- [display_errors](#display_errors)
- [register_globals](#register_globals)
- [register_argc_argv](#register_argc_argv)
- [post_max_size](#post_max_size)
- [upload_max_filesize](#upload_max_filesize)
- [file_uploads](#file_uploads)
- [max_file_uploads](#max_file_uploads)
- [max_input_vars](#max_input_vars)
- [default_mimetype](#default_mimetype)
- [default_locale](#default_locale)
- [browscap](#browscap)
- [session_save_handler](#session_save_handler)
- [session_save_path](#session_save_path)
- [session_length](#session_length)
- [session_autostart](#session_autostart)
- [date_timezone](#date_timezone)
- [iconv_internal_encoding](#iconv_internal_encoding)

---

#### runtime
Specifies which PHP runtime and version to use. The following runtimes are available:

- php-5.3
- php-5.4
- php-5.5
- php-5.6
- php-7.0

```yaml
build:
  runtime: 'php-5.6'
```

---

#### extensions
Specifies what PHP extensions should be included in your app's environment. To see what PHP extensions are available, view the [full list of available PHP extensions](https://github.com/nanobox-io/nanobox-engine-php/blob/master/doc/php-extensions.md).

```yaml
build:
  extensions:
    - curl
    - gd
    - mbstring
    - pdo_mysql
```

---

#### zend_extensions
Specifies what Zend extensions should be included in your app's environment. To see what Zend extensions are available, view the [Zend Extensions section of the PHP extensions list](https://github.com/nanobox-io/nanobox-engine-php/blob/master/doc/php-extensions.md#zend-extensions).
```yaml
build:
  zend_extensions:
    - ioncube_loader
    - opcache
```

---

#### short_open_tag
Sets the [`short_open_tag` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.short-open-tag).
```yaml
build:
  short_open_tag: true
```

---

#### zlib_output_compression
Sets the [`zlib.output_compression` PHP setting](http://php.net/manual/en/zlib.configuration.php#ini.zlib.output-compression).
```yaml
build:
  zlib_output_compression: 'Off'
```

---

#### allow_url_fopen
Sets the [`allow_url_fopen` PHP setting](http://php.net/manual/en/filesystem.configuration.php#ini.allow-url-fopen).
```yaml
build:
  allow_url_fopen: 'On'
```

---

#### disable_functions
Sets the [`disable_fuctions` PHP setting](http://php.net/manual/en/ini.core.php#ini.disable-functions).
```yaml
build:
  disable_functions:
    - exec
    - shell_exec
    - system
```

---

#### expose_php
Sets the [`expose_php` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.expose-php).
```yaml
build:
  expose_php: 'On'
```

---

#### max_execution_time
Sets the [`max_execution_time` PHP setting](http://www.php.net/manual/en/info.configuration.php#ini.max-execution-time).
```yaml
build:
  max_execution_time: 30
```

---

#### max_input_time
Sets the [`max_input_time` PHP setting](http://www.php.net/manual/en/info.configuration.php#ini.max-input-time).
```yaml
build:
  max_input_time: 60
```

---

#### memory_limit
Sets the [`memory_limit` PHP setting](http://php.net/manual/en/ini.core.php#ini.memory-limit). **Note:** This setting should not exceed the memory available on your PHP server(s).
```yaml
build:
  memory_limit: '128M'
```

---

#### error_reporting
Sets the [`error_reporting` PHP setting](http://www.php.net/manual/en/errorfunc.configuration.php#ini.error-reporting).
```yaml
build:
  error_reporting: E_ALL
```

---

#### display_errors
Sets the [`display_errors` PHP setting](http://us3.php.net/manual/en/errorfunc.configuration.php#ini.display-errors).
```yaml
build:
  display_errors: 'stderr'
```

---

#### register_globals
Sets the [`register_globals` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.register-globals)
```yaml
build:
  register_globals: 'Off'
```

---

#### register_argc_argv
Sets the [`register_argc_argv` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.register-argc-argv).
```yaml
build:
  register_argc_argv: 'Off'
```

---

#### post_max_size
Sets the [`post_max_size` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.post-max-size).
```yaml
build:
  post_max_size: '8M'
```

---

#### upload_max_filesize
Sets the [`upload_max_filesize` PHP setting](http://php.net/manual/en/ini.core.php#ini.upload-max-filesize).
```yaml
build:
  upload_max_filesize: '2M'
```

---

#### file_uploads
Sets the [`file_uploads` PHP setting](http://php.net/manual/en/ini.core.php#ini.file-uploads).
```yaml
build:
  file_uploads: true
```

---

#### max_file_uploads
Sets the [`max_file_uploads` PHP setting](http://php.net/manual/en/ini.core.php#ini.max-file-uploads).
```yaml
build:
  max_file_uploads: 20
```

---

#### max_input_vars
Sets the [`max_input_vars` PHP setting](http://php.net/manual/en/info.configuration.php#ini.max-input-vars).
```yaml
build:
  max_input_vars: 1000
```

---

#### default_mimetype
Sets the [`default_mime_type` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.default-mimetype).
```yaml
build:
  default_mimetype: 'text/html'
```

---

#### default_locale
Sets the [`intl.default_locale` PHP setting](http://php.net/manual/en/intl.configuration.php#ini.intl.default-locale).
```yaml
build:
  default_locale: 'en_US'
```

---

#### browscap
This allows you to specify the filepath to your browser capabilities file (browscap.ini). See [PHP.net Docs](http://php.net/manual/en/misc.configuration.php#ini.browscap) for definition & configuration options. When specifying the path to your browscap.ini in your Boxfile, it should relative to the root of your repo.

***Note:*** You must include your own browscap.ini in your app's repo. They are available for free from [browscap.org](http://browscap.org/).

```yaml
build:
  browscap: 'app/browscap.ini'
```

---

#### session_save_handler
Sets the [`session.save_handler` PHP setting](http://www.php.net/manual/en/session.configuration.php#ini.session.save-handler).
```yaml
build:
  session_save_handler: 'files'
```

---

#### session_save_path
Sets the [`session.save_path` PHP setting](http://www.php.net/manual/en/session.configuration.php#ini.session.save-path).
```yaml
build:
  session_save_path: '/tmp/nanobox/sessions'
```

---

#### session_length
Sets the [`session.gc_maxlifetime` PHP setting](http://www.php.net/manual/en/session.configuration.php#ini.session.gc-maxlifetime).
```yaml
build:
  session_length: 3600
```

---

#### session_autostart
Sets the [`session.autostart` PHP setting](http://www.php.net/manual/en/session.configuration.php#ini.session.auto-start).
```yaml
build:
  session_autostart: 'false'
```

---

#### date_timezone
Sets the [`date.timezone` PHP setting](http://php.net/manual/en/datetime.configuration.php#ini.date.timezone).
```yaml
build:
  date_timezone: 'US/central'
```

---

#### iconv_internal_encoding
Sets the [`iconv.internal_encoding` PHP setting](http://www.php.net/manual/en/iconv.configuration.php#ini.iconv.internal-encoding).
```yaml
build:
  iconv_internal_encoding: 'UTF-8'
```

---

### Node.js Runtime Settings
Many PHP applications utilize Javascript tools in some way. The most common use is static asset compilation. This engine allows you to specify which Node.js runtime you'd like to use.

---

#### nodejs_runtime
Specifies which Node.js runtime and version to use. This engine overlays the Node.js engine. You can view the available Node.js runtimes in the [Node.js engine documentation](https://github.com/nanobox-io/nanobox-engine-nodejs#nodejs_runtime).

```yaml
build:
  nodejs_runtime: 'nodejs-4.2'
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

#### apache_document_root
The public root of your web application. For instance, if you like to house your app in `/public` for security or organizational purposes, you can specify that here. The default is the `/`.

**Note:** If both this setting and the [global `document_root`](#document_root) are set, the `builtin_document_root` will take precedence.

```yaml
build:
  apache_document_root: '/'
```

---

#### apache_index_list
When a path is not specified in the url, these files are served in order in which they're listed.
```yaml
build:
  apache_index_list:
    - index.php
    - index.html
```

---

#### apache_default_gateway
When a path is not specified in the url, this files is served. *This is similar to [`apache_index_list`](#apache_index_list) except it only accepts a single argument.*
```yaml
build:
  apache_default_gateway: "index.php"
```

---

#### apache_php_interpreter

Specify which PHP interpreter you would like Apache to use.

- php_fpm *(default)*
- mod_php

```yaml
build:
  apache_php_interpreter: php_fpm
```

---

#### apache_modules

Specify which Apache modules to enable or disable. View the [full list of available Apache Modules](https://github.com/nanobox-io/nanobox-engine-php/blob/master/doc/apache-modules.md). By default, all modules are enabled.
```yaml
build:
  apache_modules
```

---

#### apache_max_spares

Sets Apaches [`MaxSpareServers` directive](http://httpd.apache.org/docs/2.2/mod/prefork.html#maxspareservers).
```yaml
build:
  apache_max_spares: 10
```

---

#### apache_max_clients
Sets Apache's [`MaxClients` directive](http://httpd.apache.org/docs/2.2/mod/mpm_common.html#maxclients). **Note:**This configuration must be less than or equal to the [`apache_server_limit`](#apache_server_limit).
```yaml
build:
  apache_max_clients: 128
```

---

#### apache_server_limit
Sets Apaches [`ServerLimit` directive](http://httpd.apache.org/docs/2.2/mod/mpm_common.html#serverlimit). **Note:** This configuration must be greater than or equal to the [`apache_max_clients`](#apache_max_clients).
```yaml
build:
  apache_server_limit: 128
```

---

#### apache_max_requests
Sets Apache's [`MaxRequestsPerChild` directive](http://httpd.apache.org/docs/2.2/mod/mpm_common.html#maxrequestsperchild).
```yaml
build:
  apache_max_requests: 10000
```

---

#### apache_static_expire
Adds far future expires to your header, setting the number of seconds static assets are cached. By default, static asset caching is not enabled. We only recommend using this directive on apps whose static assets do not change often.
```yaml
build:
  apache_static_expire: 86400
```

---

#### apache_log_level
Sets Apache's [`LogLevel` directive](http://httpd.apache.org/docs/2.2/mod/core.html#loglevel).
```yaml
build:
  apache_log_level: warn
```

---

#### apache_access_log
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

#### nginx_document_root
The public root of your web application. For instance, if you like to house your app in `/public` for security or organizational purposes, you can specify that here. The default is the `/`.

**Note:** If both this setting and the [global `document_root`](#document_root) are set, the `nginx_document_root` will take precedence.

```yaml
build:
  nginx_document_root: '/'
```

---

#### nginx_index_list
When a path is not specified in the url, these files are served in order in which they're listed.
```yaml
build:
  nginx_index_list:
    - index.php
    - index.html
```

---

#### nginx_default_gateway
When a path is not specified in the url, this files is served. *This is similar to [`nginx_index_list`](#nginx_index_list) except it only accepts a single argument.*
```yaml
build:
  nginx_default_gateway: 'index.php'
```

---

### Built-In PHP Web Server Settings
The following setting is used to configure the built-in PHP web server available in PHP 5.4+. These settings only apply when using `builtin` as your `webserver`.

---

#### builtin_document_root
The public root of your web application. For instance, if you like to house your app in `/public` for security or organizational purposes, you can specify that here. The default is the `/`.

**Note:** If both this setting and the [global `document_root`](#document_root) are set, the `builtin_document_root` will take precedence.

```yaml
build:
  builtin_document_root: '/'
```

---

### PHP-FPM Settings
These settings only apply when using `php_fpm` as your `apache_php_interpreter`.

- [php_fpm_events_mechanism](#php_fpm_events_mechanism)
- [php_fpm_max_children](#php_fpm_max_children)
- [php_fpm_max_spare_servers](#php_fpm_max_spare_servers)
- [php_fpm_max_requests](#php_fpm_max_requests)

---

#### php_fpm_events_mechanism
Sets `events.mechanism` setting in the `php-fpm.conf` which specifies the events mechanism FPM will use. More information is available in [PHP's documentation](http://php.net/manual/en/install.fpm.configuration.php#events-mechanism).
```yaml
build:
  php_fpm_events_mechanism: 'epoll'
```

---

#### php_fpm_max_children
Sets the maximum number of child processes that can be created by PHP.
```yaml
build:
  php_fpm_max_children: 20
```

---

#### php_fpm_max_spare_servers
The desired maximum number of idle server processes.
```yaml
build:
  php_fpm_max_spare_servers: 1
```

---

#### php_fpm_max_requests
Sets the number of requests each child process should execute before respawning. This can be useful to work around memory leaks in 3rd party libraries.
```yaml
build:
  php_fpm_max_requests: 128
```

---

### PHP GeoIP Settings
The following settings are used to configure the GeoIP PHP extension.

---

#### geoip_custom_directory
Sets the [`geoip.custom_directory` PHP setting](http://php.net/manual/en/geoip.configuration.php). When specifying the path to the directory, it should be relative to the root of your repo.

**Note:** When using the `geoip` php extension, you need to provide your own GeoIP database. Free databases are [available for download from Maxmind]http://dev.maxmind.com/geoip/legacy/geolite/#Downloads. Maxmind also provides subscription databases that tend to be more accurate.
```yaml
build:
  geoip_custom_directory: 'app/GeoIP/'
```

---

### PHP Memcache Settings
The following settings are used to configure the PHP Memcache driver.

- [memcache_chunk_size](#memcache_chunk_size)
- [memcache_hash_strategy](#memcache_hash_strategy)

---

#### memcache_chunk_size
Sets the [`memcache.chunk_size` PHP setting](http://php.net/manual/en/memcache.ini.php#ini.memcache.chunk-size).
```yaml
build:
  memcache_chunk_size: 8192
```

---

#### memcache_hash_strategy
Sets the [`memcache.hash_strategy` PHP setting](http://php.net/manual/en/memcache.ini.php#ini.memcache.hash-strategy)
```yaml
build:
  memcache_hash_strategy: 'standard'
```

---

### PHP Mongo Settings
The following settings are used to configure the PHP Mongo driver.

- [mongo_native_long](#mongo_native_long)
- [mongo_allow_empty_keys](#mongo_allow_empty_keys)
- [mongo_cmd](#mongo_cmd)
- [mongo_long_as_object](#mongo_long_as_object)

---

#### mongo_native_long
Sets the [`mongo.native_long` PHP setting](http://php.net/manual/en/mongo.configuration.php#ini.mongo.native-long).
```yaml
build:
  mongo_native_long: 1
```

---

#### mongo_allow_empty_keys
Sets the [`mongo.allow_empty_keys` PHP setting](http://php.net/manual/en/mongo.configuration.php#ini.mongo.allow-empty-keys)
```yaml
build:
  mongo_allow_empty_keys: 0
```

---

#### mongo_cmd
Sets the [`mongo.cmd` PHP setting](http://php.net/manual/en/mongo.configuration.php#ini.mongo.cmd).
```yaml
build:
  mongo_cmd: '$'
```

---

#### mongo_long_as_object
Sets the [`mongo.long_as_object` PHP setting](http://php.net/manual/en/mongo.configuration.php#ini.mongo.long-as-object).
```yaml
build:
  mongo_long_as_object: 0
```

---

### PHP APC Settings
The following settings are used to configure APC, a PHP byte-code caching engine available in PHP versions 5.3 and 5.4.

- [apc_shm_size](#apc_shm_size)
- [apc_num_files_hint](#apc_num_files_hint)
- [apc_user_entries_hint](#apc_user_entries_hint)
- [apc_filters](#apc_filters)

---

#### apc_shm_size
Sets the [`apc.shm_size` PHP setting](http://php.net/manual/en/apc.configuration.php#ini.apc.shm-size).
```yaml
build:
  apc_shm_size: '32M'
```

#### apc_num_files_hint
Sets the [`apc.num_files_hint` PHP setting](http://php.net/manual/en/apc.configuration.php#ini.apc.num-files-hint).
```yaml
build:
  apc_num_files_hint: 1000
```

---

#### apc_user_entries_hint
Sets the [`apc.user_entries_hint` PHP setting](http://php.net/manual/en/apc.configuration.php#ini.apc.user-entries-hint).
```yaml
build:
  apc_user_entries_hint: 4096
```

---

#### apc_filters
Sets the [`apc.filters` PHP setting](http://php.net/manual/en/apc.configuration.php#ini.apc.filters).
```yaml
build:
  apc_filters: ''
```

---

### PHP eAccelerator Settings
The following settings are used to configure eAccelerator, a PHP byte-code caching engine available in PHP versions 5.3 and 5.4.

- [eaccelerator_shm_max](#eaccelerator_shm_max)
- [eaccelerator_shm_size](#eaccelerator_shm_size)
- [eaccelerator_filter](#eaccelerator_filter)

---

#### eaccelerator_shm_max
Sets the [`eaccelerator.shm_max` setting](https://github.com/eaccelerator/eaccelerator/wiki/Settings#eacceleratorshm_max).
```yaml
build:
  eaccelerator_shm_max: '0'
```

---

#### eaccelerator_shm_size
Sets the [`eaccelerator.shm_size` setting](https://github.com/eaccelerator/eaccelerator/wiki/Settings#eacceleratorshm_size).
```yaml
build:
  eaccelerator_shm_size: '0'
```

---

#### eaccelerator_filter
Sets the [`eaccelerator.filter` setting](https://github.com/eaccelerator/eaccelerator/wiki/Settings#eacceleratorfilter).
```yaml
build:
   eaccelerator_filter: ''
```

---

### PHP Opcache Settings
The following settings are used to configure the OPcache PHP byte-code caching engine.

- [opcache_memory_consumption](#opcache_memory_consumption)
- [opcache_validate_timestamps](#opcache_validate_timestamps)
- [opcache_revalidate_freq](#opcache_revalidate_freq)
- [opcache_revalidate_path](#opcache_revalidate_path)
- [opcache_save_comments](#opcache_save_comments)
- [opcache_load_comments](#opcache_load_comments)
- [opcache_enable_file_override](#opcache_enable_file_override)
- [opcache_optimization_level](#opcache_optimization_level)
- [opcache_inherited_hack](#opcache_inherited_hack)
- [opcache_dups_fix](#opcache_dups_fix)
- [opcache_blacklist_filename](#opcache_blacklist_filename)

---

#### opcache_memory_consumption
Sets the [`opcache.memory_consumption` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.memory-consumption).
```yaml
build:
  opcache_memory_consumption: 64
```

---

#### opcache_validate_timestamps
Sets the [`opcache.validate_timestamps` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.validate-timestamps).
```yaml
build:
  opcache_validate_timestamps: 1
```

---

#### opcache_revalidate_freq
Sets the [`opcache.revalidate_freq` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.revalidate-freq)
```yaml
build:
  opcache_revalidate_freq: 2
```

---

#### opcache_revalidate_path
Sets the [`opcache.revalidate_path` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.revalidate-path).
```yaml
build:
  opcache_revalidate_path: 0
```

---

#### opcache_save_comments
Sets the [`opcache.save_comments` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.save-comments).
```yaml
build:
  opcache_save_comments: 1
```

---

#### opcache_load_comments
Sets the [`opcache_load_comments` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.load-comments).
```yaml
build:
  opcache_load_comments: 1
```

---

#### opcache_enable_file_override
Sets the [`opcache.enable_file_override` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.enable-file-override).
```yaml
build:
  opcache_enable_file_override: 0
```

---

#### opcache_optimization_level
Sets the [`opcache.optimization_level` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.optimization-level).
```yaml
build:
  opcache_optimization_level: '0xffffffff'
```

---

#### opcache_inherited_hack
Sets the [`opcache.inherited_hack` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.inherited-hack).
```yaml
build:
  opcache_inherited_hack: 1
```

---

#### opcache_dups_fix
Sets the [`opcache.dups_fix` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.dups-fix).
```yaml
build:
  opcache_dups_fix: 0
```

---

#### opcache_blacklist_filename
Sets the [`opcache.blacklist_filename` PHP setting](http://php.net/manual/en/opcache.configuration.php#ini.opcache.blacklist-filename).
```yaml
build:
  opcache_blacklist_filename: ''
```

---

### PHP XCache Settings
The following settings are used to configure the XCache PHP byte-code caching engine.

- [xcache_size](#xcache_size)
- [xcache_var_size](#xcache_var_size)
- [xcache_admin_user](#xcache_admin_user)
- [xcache_admin_pass](#xcache_admin_pass)

---

#### xcache_size
Sets the [`xcache.size` setting](http://xcache.lighttpd.net/wiki/XcacheIni#XCacheCacher).
```yaml
build:
  xcache_size: 0
```

---

#### xcache_var_size
Sets the [`xcache.var_size` setting](http://xcache.lighttpd.net/wiki/XcacheIni#XCacheCacher).
```yaml
build:
  xcache_var_size: 0
```

---

#### xcache_admin_user
Sets the [`xcache.admin.user` setting](http://xcache.lighttpd.net/wiki/XcacheIni#XCacheAdministration).
```yaml
build:
  xcache_admin_user: 'mOo'
```

---

#### xcache_admin_pass
Sets the [`xcache_admin_pass` setting](http://xcache.lighttpd.net/wiki/XcacheIni#XCacheAdministration).
```yaml
build:
  xcache_admin_pass: ''
```

---

### PHP New Relic Settings
The following settings are used to configure the [PHP New Relic Agent](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration).

- [newrelic_capture_params](#newrelic_capture_params)
- [newrelic_ignored_params](#newrelic_ignored_params)
- [newrelic_loglevel](#newrelic_loglevel)
- [newrelic_framework](#newrelic_framework)
- [newrelic_framework_drupal_modules](#newrelic_framework_drupal_modules)
- [newrelic_browser_monitoring_auto_instrument](#newrelic_browser_monitoring_auto_instrument)
- [newrelic_transaction_tracer_enabled](#newrelic_transaction_tracer_enabled)
- [newrelic_transaction_tracer_detail](#newrelic_transaction_tracer_detail)
- [newrelic_transaction_tracer_record_sql](#newrelic_transaction_tracer_record_sql)
- [newrelic_transaction_tracer_threshold](#newrelic_transaction_tracer_threshold)
- [newrelic_transaction_tracer_stack_trace_threshold](#newrelic_transaction_tracer_stack_trace_threshold)
- [newrelic_transaction_tracer_explain_threshold](#newrelic_transaction_tracer_explain_threshold)
- [newrelic_transaction_tracer_slow_sql](#newrelic_transaction_tracer_slow_sql)
- [newrelic_transaction_tracer_custom](#newrelic_transaction_tracer_custom)
- [newrelic_error_collector_enabled](#newrelic_error_collector_enabled)
- [newrelic_error_collector_record_database_errors](#newrelic_error_collector_record_database_errors)
- [newrelic_webtransaction_name_files](#newrelic_webtransaction_name_files)
- [newrelic_webtransaction_name_functions](#newrelic_webtransaction_name_functions)
- [newrelic_webtransaction_name_remove_trailing_path](#newrelic_webtransaction_name_remove_trailing_path)

---

#### newrelic_capture_params
Sets the [`newrelic.capture_params` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-capture_params).
```yaml
build:
  newrelic_capture_params: false
```

---

#### newrelic_ignored_params
Sets the [`newrelic.ignored_params` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-ignored_params).
```yaml
build:
  newrelic_ignored_params: ''
```

---

#### newrelic_loglevel
Sets the [`newrelic.loglevel` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-loglevel).
```yaml
build:
  newrelic_loglevel: 'info'
```

---

#### newrelic_framework
Sets the [`newrelic.framework` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-framework).
```yaml
build:
  newrelic_framework: 'laravel'
```

---

#### newrelic_framework_drupal_modules
Sets the [`newrelic.framework.drupal.modules` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-framework-drupal-modules).
```yaml
build:
  newrelic_framework_drupal_modules: true
```

---

#### newrelic_browser_monitoring_auto_instrument
Sets the [`newrelic.browser_monitoring_auto_instrument` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-autorum).
```yaml
build:
  newrelic_browser_monitoring_auto_instrument: true
```

---

#### newrelic_transaction_tracer_enabled
Sets the [`newrelic.transaction_tracer.enabled` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-enable).
```yaml
build:
  newrelic_transaction_tracer_enabled: true
```

---

#### newrelic_transaction_tracer_detail
Sets the [`newrelic.transaction_tracer.detail` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-detail).
```yaml
build:
  newrelic_transaction_tracer_detail: 1
```

---

#### newrelic_transaction_tracer_record_sql
Sets the [`newrelic.transaction_tracer.record_sql` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-sql).
```yaml
build:
  newrelic_transaction_tracer_record_sql: 'obfuscated'
```

---

#### newrelic_transaction_tracer_threshold
Sets the [`newrelic.transaction_tracer.threshold` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-threshold).
```yaml
build:
  newrelic_transaction_tracer_threshold: 'apdex_f'
```

---

#### newrelic_transaction_tracer_explain_threshold
Sets the [`newrelic.transaction_tracer.explain_threshold` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-epthreshold).
```yaml
build:
  newrelic_transaction_tracer_explain_threshold: '500'
```

---

#### newrelic_transaction_tracer_stack_trace_threshold
Sets the [`newrelic.transaction_tracer.stack_trace_threshold` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-stthreshold).
```yaml
build:
  newrelic_transaction_tracer_stack_trace_threshold: '500'
```

---

#### newrelic_transaction_tracer_slow_sql
Sets the [`newrelic.transaction_tracer.slow_sql` setting](hhttps://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-slowsql).
```yaml
build:
  newrelic_transaction_tracer_slow_sql: true
```

---

#### newrelic_transaction.tracer_custom
Sets the [`newrelic.transaction_tracer.custom` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-tt-custom).
```yaml
build:
  newrelic_transaction_tracer_custom: ''
```

---

#### newrelic_error_collector_enabled
Sets the [`newrelic.error_collector.enabled` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-err-enabled).
```yaml
build:
  newrelic_error_collector_enabled: true
```

---

#### newrelic_error_collector_record_database_errors
Sets the [`newrelic.error_collector.record_database_errors` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-err-db).
```yaml
build:
  newrelic_error_collector_record_database_errors: true
```

---

#### newrelic_webtransaction_name_files
Sets the [`newrelic.webtransaction.name.files` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-wt-files).
```yaml
build:
  newrelic_webtransaction_name_files: ''
```

---

#### newrelic_webtransaction_name_functions
Sets the [`newrelic.webtransaction.name.functions` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-wt-funcs).
```yaml
build:
  newrelic_webtransaction_name_functions: ''
```

---

#### newrelic_webtransaction_name_remove_trailing_path
Sets the [`newrelic.webtransaction.name_remove_trailing_path` setting](https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration#inivar-wt-remove-path).
```yaml
build:
  newrelic_webtransaction_name_remove_trailing_path: false
```

---

## Help & Support
This is a generic (non-framework-specific) PHP engine provided by [Nanobox](http://nanobox.io). If you need help with this engine, you can reach out to us in the [#nanobox IRC channel](http://webchat.freenode.net/?channels=nanobox). If you are running into an issue with the engine, feel free to [create a new issue on this project](https://github.com/nanobox-io/nanobox-engine-php/issues/new).
