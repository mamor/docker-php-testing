FROM php:7.2
MAINTAINER mamor <mamor.dev@gmail.com>

# Requirements
RUN apt update && apt install -y \
fonts-migmix \
gnupg \
mysql-client \
libpng-dev \
zlib1g-dev

# PHP
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
curl https://phar.phpunit.de/phpunit.phar -L -o phpunit && chmod +x phpunit && mv phpunit /usr/local/bin && \
docker-php-ext-install opcache pdo_mysql zip

# Chrome
RUN apt update && apt install -y \
fonts-liberation \
libappindicator1 \
libasound2 \
libatk-bridge2.0-0 \
libatk1.0-0 \
libcairo2 \
libcups2 \
libdbus-1-3 \
libexpat1 \
libgdk-pixbuf2.0-0 \
libgtk-3-0 \
libnspr4 \
libnss3 \
libpango-1.0-0 \
libpangocairo-1.0-0 \
libx11-6 \
libx11-xcb1 \
libxcb1 \
libxcomposite1 \
libxcursor1 \
libxdamage1 \
libxext6 \
libxfixes3 \
libxi6 \
libxrandr2 \
libxrender1 \
libxss1 \
libxtst6 \
lsb-release \
wget \
xdg-utils && \
curl -L -o google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
dpkg -i google-chrome.deb && \
rm google-chrome.deb && \
sed -i 's|HERE/chrome\"|HERE/chrome\" --no-sandbox|g' /opt/google/chrome/google-chrome

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
apt update && apt install -y nodejs && \
npm install -g gulp@4 yarn

# Config
RUN echo "opcache.validate_timestamps=0" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
COPY conf/ /

RUN apt autoremove -y
