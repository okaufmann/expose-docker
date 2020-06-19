FROM php:7.4-cli

# add basic tools
RUN apt-get update && apt-get install -y git curl wget zip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    chmod +x /usr/local/bin/composer
ENV PATH="/root/.composer/vendor/bin:${PATH}"

RUN composer global require hirak/prestissimo
RUN composer global require beyondcode/expose

CMD ["expose", "serve"]