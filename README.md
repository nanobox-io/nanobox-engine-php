# PHP

This is a generic PHP engine used to launch PHP web and worker services when using [Nanobox](http://nanobox.io). It exposes has a wide collection configuration options generally handled in the php.ini and other configuration files. Both PHP settings and web server settings are available. In theory, anything that can be done with a PHP framework engine can be done with this engine.

## Basic Configuration Options

This engine exposes configuration option through the [Boxfile](http://docs.nanobox.io/boxfile/), a yaml config file used to provision and configure your app's infrastructure when using Nanobox. 

##### *Advanced Configuration Options*
This Readme outlines only the most basic and commonly used settings. For the full list of available configuration options, view the **[Advanced PHP Configuration options](https://github.com/pagodabox/nanobox-engine-php/blob/master/doc/advanced-php-config.md)**.

#### Overview of Basic Boxfile Configuration Options
```yaml
build:
  # Web Server Settings
  webserver: 'apache'

  # PHP Settings
  php_version: 5.6
  php_extensions:
    - curl
    - gd
    - mbstring
    - pdo_mysql
  php_zend_extensions:
    - ioncube_loader
    - opcache
  php_max_execution_time: 30
  php_max_input_time: 30
  php_error_reporting: E_ALL
  php_display_errors: 'stderr'
  php_post_max_size: '8M'
  php_upload_max_filesize: '2M'
  php_file_uploads: true

  # Apache Settings
  apache_document_root: '/'
  apache_php_interpreter: fpm
  apache_access_log: false

  # Nginx Settings
  nginx_document_root: '/'
```

##### Quick Links
[Web Server Settings](#web-server-settings)  
[PHP Settings](#php-settings)  
[Apache Settings](#apache-settings)  
[Nginx Settings](#nginx-settings)  

### Web Server Settings
The following setting is used to select which web server to use in your application.

---

##### `webserver`
The following web servers are available:

- apache *(default)*
- nginx
- builtin *([PHP's built-in web server](http://php.net/manual/en/features.commandline.webserver.php) available in 5.4+)*

```yaml
build:
  webserver: 'apache'
```

*Web server specific settings are available in the [Apache Settings](#apache-settings) & [Nginx Settings](#nginx-settings) sections below.*

---

### PHP Settings
The following settings are typically configured in the php.ini. When using Nanobox, these are configured in the Boxfile.

- [php_version](#php_version)
- [php_extensions](#php_extensions)
- [php_zend_extensions](#php_zend_extensions)
- [php_max_execution_time](#php_max_execution_time)
- [php_max_input_time](#php_max_input_time)
- [php_error_reporting](#php_error_reporting)
- [php_display_errors](#php_display_errors)
- [php_post_max_size](#php_post_max_size)
- [php_upload_max_filesize](#php_upload_max_filesize)
- [php_file_uploads](#php_file_uploads)
- [php_date_timezone](#php_date_timezone)

---

##### `php_version`
Specifies which version of PHP to use. The following versions are available:

- 5.3
- 5.4
- 5.5
- 5.6

```yaml
build:
  php_version: 5.6
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

##### `php_date_timezone`
Sets the [`date.timezone` PHP setting](http://php.net/manual/en/datetime.configuration.php#ini.date.timezone).
```yaml
build:
  php_date_timezone: 'US/central'
```

---

### Apache Settings
The following settings are used to configure Apache. These only apply when using `apache` as your `webserver`.

- [apache_document_root](#apache_document_root)
- [apache_php_interpreter](#apache_php_interpreter)
- [apache_access_log](#apache_access_log)

---

##### `apache_document_root`
The public root of your web application. For instance, if you like to house your app in `/public` for security or organizational purposes, you can specify that here. The default is the `/`.
```yaml
build:
  apache_document_root: '/'
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

---

##### `nginx_document_root`
The public root of your web application. For instance, if you like to house your app in `/public` for security or organizational purposes, you can specify that here. The default is the `/`.
```yaml
build:
  nginx_document_root: '/'
```

---
