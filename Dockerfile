FROM php:8.1-cli

# add basic tools
RUN apt-get update && apt-get install -y git curl wget zip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY ./expose /app
RUN cd /app && COMPOSER_ALLOW_SUPERUSER=1 composer install --optimize-autoloader --prefer-dist && chmod a+x /app/expose

COPY config.php /root/.expose/config.php

VOLUME [ "/root/.expose/" ]
VOLUME [ "/app/resources/views/server" ]

WORKDIR /app

ENTRYPOINT ["/app/expose"]