FROM php:7.4-cli

# add basic tools
RUN apt-get update && apt-get install -y git curl wget zip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    chmod +x /usr/local/bin/composer
ENV PATH="/root/.composer/vendor/bin:${PATH}"

COPY ./expose /app
RUN cd /app && composer install --optimize-autoloader --prefer-dist && chmod a+x /app/expose

COPY config.php /root/.expose/config.php

VOLUME [ "/root/.expose/" ]
VOLUME [ "/app/resources/views/server" ]

WORKDIR /app

ENTRYPOINT ["/app/expose"]