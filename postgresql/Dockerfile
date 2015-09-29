# Postgresql docker image to be used with moodle
FROM postgres
MAINTAINER Martin Vuk <martin.vuk@fri.uni-lj.si>
RUN localedef -i sl_SI -c -f UTF-8 -A /usr/share/locale/locale.alias sl_SI.UTF-8
ENV LANG sl_SI.utf8
ADD init-database.sql /docker-entrypoint-initdb.d/
