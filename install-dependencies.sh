set -eux; 
	
if command -v a2enmod; then 
    a2enmod rewrite 
fi 

savedAptMark="$(apt-mark showmanual)" 

apt-get update 
apt-get install -y --no-install-recommends libfreetype6-dev libjpeg-dev libpng-dev libpq-dev libzip-dev git unzip zip openssh-client

docker-php-ext-configure gd --with-freetype --with-jpeg  

docker-php-ext-install -j "$(nproc)" gd opcache pdo_mysql pdo_pgsql zip 

# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
apt-mark auto '.*' > /dev/null 
apt-mark manual $savedAptMark 
ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
    | awk '/=>/ { print $3 }' \
    | sort -u \
    | xargs -r dpkg-query -S \
    | cut -d: -f1 \
    | sort -u \
    | xargs -rt apt-mark manual \

apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false
rm -rf /var/lib/apt/lists/*