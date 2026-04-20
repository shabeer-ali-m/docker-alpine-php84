# PHP 8.4 FPM Alpine Docker Image

Lightweight Docker image based on Alpine Linux with PHP 8.4 FPM, commonly used for Laravel and other modern PHP applications.

## 📦 Features

* Alpine 3.23 base (small & fast)
* PHP 8.4 with FPM
* Pre-installed common PHP extensions:

  * mbstring, openssl, PDO, pdo_mysql
  * tokenizer, xml, ctype, json
  * phar, session, fileinfo, dom
  * curl, zip, simplexml, xmlwriter
  * gd, opcache
* Composer pre-installed
* OPcache enabled with optimized defaults
* Configured for Docker (listens on `0.0.0.0:9000`)

---

## 🚀 Usage

### Build the image

```bash
docker build -t php84-fpm-alpine .
```

### Run the container

```bash
docker run -d \
  -p 9000:9000 \
  -v $(pwd):/var/www \
  php84-fpm-alpine
```

---

## 📁 Working Directory

```
/var/www
```

Mount your application here.

---

## 🔌 Exposed Port

```
9000 (PHP-FPM)
```

Use this with Nginx or another web server.

---

## ⚙️ PHP Configuration

### FPM

* Listens on: `0.0.0.0:9000`
* Ready for use in Docker environments

### OPcache Settings

```ini
opcache.enable=1
opcache.enable_cli=1
opcache.memory_consumption=128
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=10000
opcache.validate_timestamps=1
opcache.revalidate_freq=2
```

These settings are optimized for development and moderate production workloads.

---

## 📦 Composer

Composer is installed globally:

```bash
composer install
```

---

## 🧩 Example with Nginx (Docker Compose)

```yaml
version: '3.8'

services:
  app:
    build: .
    container_name: php
    volumes:
      - .:/var/www

  nginx:
    image: nginx:alpine
    container_name: nginx
    ports:
      - "8080:80"
    volumes:
      - .:/var/www
      - ./nginx.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - app
```

---

## 📝 Notes

* This image is suitable for Laravel, Symfony, and other PHP frameworks.
* For production:

  * Consider disabling `opcache.validate_timestamps`
  * Tune OPcache memory based on your app size
* Add additional PHP extensions as needed via `apk add`

---

## 📄 License

This project is open-source and available under the MIT License.
