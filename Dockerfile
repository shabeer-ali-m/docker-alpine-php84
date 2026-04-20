FROM alpine:3.23

# Install PHP 8.4 + extensions
RUN apk add --no-cache \
    php84 \
    php84-fpm \
    php84-mbstring \
    php84-openssl \
    php84-pdo \
    php84-intl \
    php84-pdo_mysql \
    php84-tokenizer \
    php84-xml \
    php84-ctype \
    php84-json \
    php84-phar \
    php84-session \
    php84-fileinfo \
    php84-dom \
    php84-curl \
    php84-zip \
    php84-simplexml \
    php84-xmlwriter \
    php84-xmlreader \
    php84-gd \
    php84-opcache \
    curl \
    unzip

# ✅ Fix: allow external connections (important for Docker)
RUN sed -i 's|127.0.0.1:9000|0.0.0.0:9000|g' /etc/php84/php-fpm.d/www.conf

# ✅ Enable & configure OPcache (good defaults for Laravel)
RUN echo "opcache.enable=1" >> /etc/php84/conf.d/00_opcache.ini && \
    echo "opcache.enable_cli=1" >> /etc/php84/conf.d/00_opcache.ini && \
    echo "opcache.memory_consumption=128" >> /etc/php84/conf.d/00_opcache.ini && \
    echo "opcache.interned_strings_buffer=8" >> /etc/php84/conf.d/00_opcache.ini && \
    echo "opcache.max_accelerated_files=10000" >> /etc/php84/conf.d/00_opcache.ini && \
    echo "opcache.validate_timestamps=1" >> /etc/php84/conf.d/00_opcache.ini && \
    echo "opcache.revalidate_freq=2" >> /etc/php84/conf.d/00_opcache.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php84 -- \
    --install-dir=/usr/local/bin \
    --filename=composer

WORKDIR /var/www

EXPOSE 9000

CMD ["php-fpm84", "-F"]
