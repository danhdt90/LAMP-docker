# Use ARG to accept PHP version from build context
ARG PHP_VERSION=8.4
FROM php:${PHP_VERSION}-fpm

# Install mysqli extension
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install additional extensions WordPress might need
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    && docker-php-ext-install zip

# Install Xdebug (compatible version based on PHP version)
ARG PHP_VERSION
RUN pecl uninstall xdebug || true && \
    if [ "${PHP_VERSION}" = "7.4" ]; then \
        pecl install xdebug-3.1.6; \
    elif [ "${PHP_VERSION}" = "8.0" ]; then \
        pecl install xdebug-3.2.2; \
    elif [ "${PHP_VERSION}" = "8.1" ]; then \
        pecl install xdebug-3.3.2; \
    elif [ "${PHP_VERSION}" = "8.2" ]; then \
        pecl install xdebug-3.3.2; \
    elif [ "${PHP_VERSION}" = "8.3" ]; then \
        pecl install xdebug-3.3.2; \
    else \
        pecl install xdebug; \
    fi \
    && docker-php-ext-enable xdebug

# Copy appropriate Xdebug configuration
COPY xdebug*.ini /tmp/
RUN if [ "${PHP_VERSION}" = "7.4" ] && [ -f "/tmp/xdebug-7.4.ini" ]; then \
        cp /tmp/xdebug-7.4.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    else \
        cp /tmp/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    fi

# Create session directory and set proper permissions
RUN mkdir -p /tmp && chmod 1777 /tmp

# Create log directory for PHP errors
RUN mkdir -p /var/log && chmod 755 /var/log