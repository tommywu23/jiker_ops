FROM php:7.2-fpm

#更新apt-get源 使用163的源
#RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
#    echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" >/etc/apt/sources.list && \
#    echo "deb http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list && \
#    echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
#    echo "deb-src http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list

RUN apt-get update \
    && apt-get install iputils-ping \
    && docker-php-ext-install \ 
        bcmath \
        bz2 \
        calendar \
        Core \
        ctype \
        curl \
        date \
        dom \
        exif \
        fileinfo \
        filter \
        ftp \
        gd \
        gettext \
        hash \
        iconv \
        json \
        ldap \
        libxml \
        mbstring \
        mcrypt \
        mysqli \
        mysqlnd \
        openssl \
        pcntl \
        pcre \
        PDO \
        pdo_mysql \
        pdo_sqlite \
        Phar \
        posix \
        readline \
        Reflection \
        session \
        shmop \
        SimpleXML \
        soap \
        sockets \
        SPL \
        sqlite3 \
        standard \
        sysvmsg \
        sysvsem \
        sysvshm \
        tokenizer \
        wddx \
        xml \
        xmlreader \
        xmlrpc \
        xmlwriter \
        xsl \
        zip \
        zlib \
    && docker-php-ext-enable \
        bcmath \
        bz2 \
        calendar \
        Core \
        ctype \
        curl \
        date \
        dom \
        exif \
        fileinfo \
        filter \
        ftp \
        gd \
        gettext \
        hash \
        iconv \
        json \
        ldap \
        libxml \
        mbstring \
        mcrypt \
        mysqli \
        mysqlnd \
        openssl \
        pcntl \
        pcre \
        PDO \
        pdo_mysql \
        pdo_sqlite \
        Phar \
        posix \
        readline \
        Reflection \
        session \
        shmop \
        SimpleXML \
        soap \
        sockets \
        SPL \
        sqlite3 \
        standard \
        sysvmsg \
        sysvsem \
        sysvshm \
        tokenizer \
        wddx \
        xml \
        xmlreader \
        xmlrpc \
        xmlwriter \
        xsl \
        zip \
        zlib \
    # 安装 Composer
    && curl -sS https://getcomposer.org/installer \
        | php -- --install-dir=/usr/local/bin --filename=composer \
    # 国内镜像加速
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    && composer global require hirak/prestissimo
