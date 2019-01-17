#!/usr/bin/env bash
#title		    :make_website.sh
#description	:
#author		    :Valeriu Stinca
#email		    :ts@strategic.zone
#date		    :20190117
#version	    :0.1
#notes		    :
#===================
BASE="/home/virtual/dockers/web"

read -rp "Website name please?: " website_name
MYSQL_ROOT_PASSWORD="$(pwgen -n 15 1)"
MYSQL_DATABASE="$(sed -e 's/[^a-zA-Z0-9_-]/_/g' <<< ${website_name})"
MYSQL_USER="$(sed -e 's/[^a-zA-Z0-9_-]/_/g' <<< ${website_name})"
MYSQL_PASSWORD="$(pwgen -n 15 1)"

echo "=============================================="
echo -e "Website Name:\t\t${website_name}"
echo -e "Mysql root password:\t${MYSQL_ROOT_PASSWORD}"
echo -e "Mysql database:\t\t${MYSQL_DATABASE}"
echo -e "Mysql User:\t\t${MYSQL_USER}"
echo -e "Mysql user password:\t${MYSQL_PASSWORD}"

cd "${$BASE}"
git clone git@github.com:ts-sz/docker-wordpress.git ${website_name}
cd "${website_name}"
cp env.template .env
sed -i "/CONTAINER_NAME*/c\\CONTAINER_NAME=${website_name}" ".env"
sed -i "/WEBSITE_NAME*/c\\WEBSITE_NAME=${website_name}" ".env"
sed -i "/MYSQL_ROOT_PASSWORD*/c\\MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}" ".env"
sed -i "/MYSQL_DATABASE*/c\\MYSQL_DATABASE=${MYSQL_DATABASE}" ".env"
sed -i "/MYSQL_USER*/c\\MYSQL_USER=${MYSQL_USER}" ".env"
sed -i "/MYSQL_PASSWORD*/c\\MYSQL_PASSWORD=${MYSQL_PASSWORD}" ".env"

read -p "Start docker stack?: Y/N " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Starting docker stack with docker-compose!"
    docker-compose up -d
fi
