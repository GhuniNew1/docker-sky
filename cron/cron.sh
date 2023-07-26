#!/bin/sh
set -eu
mount /mnt/data
chmod +x /usr/local/lsws/lsphp82/etc/php/8.2/mods-available/cron.ini
exec busybox crond -f -l 0 -L /dev/stdout
