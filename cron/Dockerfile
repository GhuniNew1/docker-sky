FROM ubuntu:22.04

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        wget \
        busybox-static \
        tzdata \
        cifs-utils \
        sudo \
    ; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

RUn cp /usr/share/zoneinfo/Asia/Bangkok /etc/localtime

RUN wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | bash >/dev/null 2>&1

RUN apt-get update && apt-get install -y lsphp82 lsphp82-pspell lsphp82-common lsphp82-curl lsphp82-imagick lsphp82-imap lsphp82-intl lsphp82-memcached lsphp82-mysql lsphp82-pgsql lsphp82-opcache lsphp82-redis lsphp82-igbinary lsphp82-dev lsphp82-apcu lsphp82-modules-source lsphp82-pear

COPY .smbcredentials /root/.smbcredentials
RUN chown -R root:root /root/.smbcredentials && chmod -R 600 /root/.smbcredentials
RUN mkdir -p /var/spool/cron/crontabs
RUN mkdir -p /mnt/data && chmod 775 -R /mnt/data && chown -R www-data:www-data /mnt/data
RUN echo '5 1 * * * /root/optimize.sh -vv ' > /var/spool/cron/crontabs/root
RUN echo '*/5 * * * * /usr/local/lsws/lsphp82/bin/php -f /var/www/html/cron.php ' > /var/spool/cron/crontabs/www-data
RUN echo "//brainqnap.bigbrainp.com/sky /mnt/data cifs vers=3.11,credentials=/root/.smbcredentials,uid=www-data,gid=www-data,file_mode=0770,dir_mode=0770,nounix,noserverino 0 0" >> /etc/fstab

COPY optimize.sh /root/optimize.sh
COPY cron.sh /cron.sh
RUN chmod +x /root/optimize.sh && chmod +x /cron.sh

COPY cron.ini /usr/local/lsws/lsphp82/etc/php/8.2/mods-available/cron.ini
RUN chmod -R 775 /usr/local/lsws/lsphp82/etc/php/8.2/mods-available/cron.ini

RUN ln -sf /usr/local/lsws/lsphp82/bin/php /usr/bin/php
RUN /usr/local/lsws/lsphp82/bin/pecl install apcu
ENTRYPOINT ["/cron.sh"]
WORKDIR /var/www/html/
