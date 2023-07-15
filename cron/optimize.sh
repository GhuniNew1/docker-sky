#!/bin/bash
#redis-cli -s /var/run/redis/redis.sock <<EOF
#FLUSHALL
#quit
#EOF
sudo -u www-data php /var/www/html/html/occ files:scan --all
sudo -u www-data php /var/www/html/html/occ files:scan-app-data
#sudo -u www-data php /var/www/html/occ files:scan admin2 bbs-02 bbs-01
#sudo -u www-data bash /var/www/html/nextcloud-file-sync.sh --all

exit 0