#!/bin/bash

#Variables

#Where ever we land
LANDING=$(pwd)
ERROR_LOG="${LANDING}/error.log"

#MAIN
apt install -y openssh-server
apt install -y gawk socat
apt install -y libaio1 libcgi-fast-perl libcgi-pm-perl libdbd-mysql-perl libdbi-perl libencode-locale-perl libfcgi-perl libhtml-parser-perl;
apt install -y libhtml-tagset-perl libhtml-template-perl libhttp-date-perl libhttp-message-perl libio-html-perl liblwp-mediatypes-perl libmysqlclient20;
apt install -y libreadline5 libterm-readkey-perl libtimedate-perl liburi-perl mysql-common;
apt remove nano -y
apt install vim -y
apt remove vim-tiny -y
cat ${LANDING}/sources.list > /etc/apt/sources.list
for i in $(dpkg --list | egrep -i "mysql|maria" | awk {'print $2'});
	do apt remove ${i} -y;
done;
apt update
apt upgrade -y
mkdir /opt/debs/maria
mv ${LANDING}/*.debs /opt/deb/maria/
cd /opt/debs/maria
dpkg -i mysql-common_10.3.8+maria~xenial_all.deb 2>${LANDING}/${ERROR_LOG}
dpkg -i mariadb-common_10.3.8+maria~xenial_all.deb 2>${LANDING}/${ERROR_LOG}
dpkg -i mariadb-client-core-10.3_10.3.8+maria~xenial_amd64.deb 2>${LANDING}/${ERROR_LOG}
dpkg -i mariadb-client-10.3_10.3.8+maria~xenial_amd64.deb 2>${LANDING}/${ERROR_LOG}
dpkg -i galera-3_25.3.23-xenial_amd64.deb 2>${LANDING}/${ERROR_LOG}
dpkg -i mariadb-server-core-10.3_10.3.8+maria~xenial_amd64.deb 2>${LANDING}/${ERROR_LOG}
dpkg -i mariadb-server-10.3_10.3.8+maria~xenial_amd64.deb 2>${LANDING}/${ERROR_LOG}
dpkg -i mariadb-plugin-spider_10.3.8+maria~xenial_amd64.deb 2>${LANDING}/${ERROR_LOG}
