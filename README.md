# PHP

This is a generic PHP engine used to launch PHP web and worker services on [Nanobox](http://nanobox.io). It exposes a wide collection configuration options generally handled in the php.ini and other configuration files. Both PHP settings and web server settings are available.

## Usage
To use this engine, specify in the boxfile.yml:
```yaml
code.build:
  engine: php
```

## Composer
This engine uses [Composer](https://getcomposer.org) to manage dependencies. If a composer.json file exists at the root of your application, dependencies will be fetched during a build.

## Node.js
If a package.json file exists at the root of the application, nodejs will be installed and an `npm install` will be run during the build.

You can also specify a custom nodejs version:
```yaml
code.build:
  config:
    nodejs_runtime: nodejs-6
```

## Basic Configuration

This engine exposes configuration options through the [boxfile,yml](http://docs.nanobox.io/boxfile/), a yaml config file used to provision and configure your app's platform. 

##### *Advanced Configuration Options*
This Readme outlines only the most basic and commonly used settings. For the full list of available configuration options, view the **[Advanced PHP Configuration options](https://github.com/nanobox-io/nanobox-engine-php/blob/master/doc/advanced-php-config.md)**.

#### Overview of Basic boxfile.yml Configuration Options
```yaml
code.build:
  config:
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
    max_execution_time: 30
    max_input_time: 30
    error_reporting: E_ALL
    display_errors: 'stderr'
    post_max_size: '8M'
    upload_max_filesize: '2M'
    file_uploads: true

    # Web Server Settings
    webserver: 'apache'

    # Apache Settings
    apache_document_root: '/'
    apache_php_interpreter: fpm
    apache_access_log: false
```

##### Quick Links
[Web Server Settings](#web-server-settings)  
[PHP Settings](#php-settings)  
[Apache Settings](#apache-settings)  

### Web Server Settings
The following setting is used to select which web server to use in your application.

- [webserver](#webserver)

---

#### webserver
The following web servers are available:

- apache *(default)*
- nginx
- builtin *([PHP's built-in web server](http://php.net/manual/en/features.commandline.webserver.php) available in 5.4+)*

```yaml
code.build:
  config:
    webserver: 'apache'
```

*Web server specific settings are available in the following sections of the Advanced PHP Configuration doc:*

[Apache Settings](https://github.com/nanobox-io/nanobox-engine-php/blob/master/doc/advanced-php-config.md#apache-settings)  
[Nginx Settings](https://github.com/nanobox-io/nanobox-engine-php/blob/master/doc/advanced-php-config.md#nginx-settings)  
[Built-In PHP Web Server Settings](https://github.com/nanobox-io/nanobox-engine-php/blob/master/doc/advanced-php-config.md#built-in-php-web-server-settings)

---

### PHP Settings
The following settings are typically configured in the php.ini. When using Nanobox, these are configured in the boxfile.yml.

- [runtime](#runtime)
- [extensions](#extensions)
- [zend_extensions](#zend_extensions)
- [max_execution_time](#max_execution_time)
- [max_input_time](#max_input_time)
- [error_reporting](#error_reporting)
- [display_errors](#display_errors)
- [post_max_size](#post_max_size)
- [upload_max_filesize](#upload_max_filesize)
- [file_uploads](#file_uploads)
- [date_timezone](#date_timezone)

---

#### runtime
Specifies which PHP runtime and version to use. The following runtimes are available:

- php-5.3
- php-5.4
- php-5.5
- php-5.6
- php-7.0

```yaml
code.build:
  config:
    runtime: 'php-5.6'
```

---

#### extensions
Specifies what PHP extensions should be included in your app's environment. To see what PHP extensions are available, view the [full list of available PHP extensions](https://github.com/nanobox-io/nanobox-engine-php/blob/master/doc/php-extensions.md).

```yaml
code.build:
  config:
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
code.build:
  config:
    zend_extensions:
      - ioncube_loader
      - opcache
```

---

#### max_execution_time
Sets the [`max_execution_time` PHP setting](http://www.php.net/manual/en/info.configuration.php#ini.max-execution-time).
```yaml
code.build:
  config:
    max_execution_time: 30
```

---

#### max_input_time
Sets the [`max_input_time` PHP setting](http://www.php.net/manual/en/info.configuration.php#ini.max-input-time).
```yaml
code.build:
  config:
    max_input_time: 60
```

---

#### error_reporting
Sets the [`error_reporting` PHP setting](http://www.php.net/manual/en/errorfunc.configuration.php#ini.error-reporting).
```yaml
code.build:
  config:
    error_reporting: E_ALL
```

---

#### display_errors
Sets the [`display_errors` PHP setting](http://us3.php.net/manual/en/errorfunc.configuration.php#ini.display-errors).
```yaml
code.build:
  config:
    display_errors: 'stderr'
```

---

#### post_max_size
Sets the [`post_max_size` PHP setting](http://www.php.net/manual/en/ini.core.php#ini.post-max-size).
```yaml
code.build:
  config:
    post_max_size: '8M'
```

---

#### upload_max_filesize
Sets the [`upload_max_filesize` PHP setting](http://php.net/manual/en/ini.core.php#ini.upload-max-filesize).
```yaml
code.build:
  config:
    upload_max_filesize: '2M'
```

---

#### file_uploads
Sets the [`file_uploads` PHP setting](http://php.net/manual/en/ini.core.php#ini.file-uploads).
```yaml
code.build:
  config:
    file_uploads: true
```

---

#### date_timezone
Sets the [`date.timezone` PHP setting](http://php.net/manual/en/datetime.configuration.php#ini.date.timezone).
```yaml
code.build:
  config:
    date_timezone: 'US/central'
```

---

### Apache Settings
The following settings are used to configure Apache. These only apply when using `apache` as your `webserver`.

- [apache_php_interpreter](#apache_php_interpreter)
- [apache_access_log](#apache_access_log)

---

#### apache_php_interpreter

Specify which PHP interpreter you would like Apache to use.

- fpm *(default)*
- mod_php

```yaml
code.build:
  config:
    apache_php_interpreter: fpm
```

---

#### apache_access_log
Enables or disables the Apache Access log.
```yaml
code.build:
  config:
    apache_access_log: false
```

---

## Help & Support
This is a generic (non-framework-specific) PHP engine provided by [Nanobox](http://nanobox.io). If you need help with this engine, you can reach out to us in the [#nanobox IRC channel](http://webchat.freenode.net/?channels=nanobox). If you are running into an issue with the engine, feel free to [create a new issue on this project](https://github.com/nanobox-io/nanobox-engine-php/issues/new).
