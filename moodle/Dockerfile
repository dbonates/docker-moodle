# This is a comment
FROM tutum/apache-php
MAINTAINER Martin Vuk <martin.vuk@fri.uni-lj.si>
VOLUME ["/moodledata"]
# install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install php5-mcrypt php5-gd php5-curl php5-xmlrpc php5-intl php5-pgsql php5-ldap git
# clone moodle to /var/www/html dir
RUN rm -rf /app && cd / && git clone --depth=1 -b MOODLE_29_STABLE git://git.moodle.org/moodle.git /app

# copy config.php
#RUN chmod -R 0755 /app
#ADD config.php /app/config.php
#RUN chmod -R 0644 /app/config.php

#ADD moodle_run.sh /moodle_run.sh
#RUN chmod +x /moodle_run.sh
RUN mkdir -p /moodledata
RUN chown www-data /moodledata
ADD init.sh /init.sh
RUN chmod +x /init.sh

#EXPOSE 80
WORKDIR /app
CMD ["/init.sh"]
