#!/usr/bin/env bash
#title		    :make_website.sh
#description	:
#author		    :Valeriu Stinca
#email		    :ts@strategic.zone
#date		      :2020-09-06
#version	    :0.2
#notes		    :
#===================

read -rp "Website domaine name https://" website_name
read -rp "FTP PASV Port?: " ftp_pasv
project_short_name="$(sed -e 's/[^a-zA-Z0-9_-]/_/g' <<< "${website_name}")"
MYSQL_ROOT_PASSWORD="$(pwgen -n 15 1)"
MYSQL_DATABASE="${project_short_name}"
MYSQL_USER="${project_short_name}"
MYSQL_PASSWORD="$(pwgen -n 15 1)"
FTP_PASV_START=${ftp_pasv}
FTP_PASV_END=$(( ftp_pasv + 9 ))
FTP_USERNAME="${project_short_name}"
FTP_PASSWORD="$(pwgen -n 15 1)"

echo "=============================================="
echo -e "Website URL\t\thttps://${website_name}"
echo -e "Mysql root password:\t${MYSQL_ROOT_PASSWORD}"
echo -e "Mysql database:\t\t${MYSQL_DATABASE}"
echo -e "Mysql User:\t\t${MYSQL_USER}"
echo -e "Mysql user password:\t${MYSQL_PASSWORD}"
echo -e "FTP PASV ports:\t ${FTP_PASV_START}-${FTP_PASV_END}"
echo -e "FTP Username:\t${FTP_USERNAME}"
echo -e "FTP Password:\t${FTP_PASSWORD}"
# git clone https://github.com/ts-sz/docker-wordpress.git "${project_short_name}"
# cd "${project_short_name}"
echo "
SERVICE=${project_short_name}
SERVICE_PORT=80
DOMAIN_NAME=${website_name}

# DB
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
MYSQL_DATABASE=${MYSQL_DATABASE}
MYSQL_USER=${MYSQL_USER}
MYSQL_PASSWORD=${MYSQL_PASSWORD}
WORDPRESS_TABLE_PREFIX=wp_

# FTP Server 
FTP_PASV_START=${FTP_PASV_START}
FTP_PASV_END=${FTP_PASV_END}
FTP_USERNAME=${FTP_USERNAME}
FTP_PASSWORD=${FTP_PASSWORD}

# by default
ADMINER_SERVICE_PORT=80
ADMINER_PATH=adma


# TimeZone
TZ=Europe/Paris
" | tee .env 
# check docker compose run and rm 
# check pure-pw add user and password one line 
# docker-compose run -rm ftp pure-pw useradd ${FTP_USERNAME} -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u 33 -g 33 -d /home/ftpusers/www-data
read -p "Start docker stack?: Y/N " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Starting docker stack with docker-compose!"
    docker-compose up -d
fi
