#!/bin/bash
# enable mooodle to write its data
chown www-data /moodledata

# initial moodle config
if [ ! -f /app/config.php ]; then
    if [ -z $WWWROOT ]; then
	WWWROOT="localhost"
    fi
    #This is so the passwords show up in logs.
    env
    echo moodle db password: $DB_PASSWORD
  echo moodle address: http://$WWWROOT
  echo $DB_PASSWORD > /moodle-db-pw.txt

  sed -e "s/username/$DB_ENV_POSTGRES_USER/
  s/password/$DB_ENV_POSTGRES_PASSWORD/
  s/localhost/$DB_PORT_5432_TCP_ADDR/
  s/example.com\/moodle/$WWWROOT/
  s/\/home\/example\/moodledata/\/moodledata/" /app/config-dist.php > /app/config.php


  chown www-data:www-data /app/config.php
fi

chown www-data:www-data /app -R

if [ "$ALLOW_OVERRIDE" = "**False**" ]; then
    unset ALLOW_OVERRIDE
else
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
    a2enmod rewrite
fi

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
