# Launch stack wordpress + ftp server + adminer + lets encrypt
Auto Install Wordpress with docker and lets encrypt

in debug mode with: `docker-compose up`

## Create FTP user(s)
Create FTP users: `docker exec -it ftp-server pure-pw useradd USERNAME -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u 31 -g 31 -d /home/ftpusers/www-data`

or connect directly to console: `pure-pw useradd USERNAME -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u 31 -g 31 -d /home/ftpusers/www-data`

## To create a new website
Redirect domain name to ip in DNS

Log to your virtual server:
`ssh root@virtual.server`

go to dokers folder: `cd /home/virtual/dockers/web`

## Clone repository :
`git clone https://github.com/ts-sz/docker-wordpress.git my_domain.com`

Go to my_domain.com 
Edit with nano .env
save modifications with `CTRL + X`

## Launch dockers
`docker-compose -d up` or with alias: `dc -d up`

## Backup Database
`docker exec some-mariadb sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > /some/path/on/your/host/all-databases.sql`
## Enjoy
