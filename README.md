# Auto backup on Yandex.Disk
![curl](https://img.shields.io/badge/curl-7.64.1-blue)
![MySQL](https://img.shields.io/badge/mysql-5.7.31-blue)
![jq](https://img.shields.io/badge/jq-1.6-orange)

Instructions for setting up automatic database backup on a server with initial loading of archives to Yandex.Disk

## Links

- Yandex.Disk API documentation - https://yandex.ru/dev/disk/api/reference/upload.html
- curl documentation - https://curl.se/docs/manpage.html
    
## Backend 

- curl 7.64.1(not tested on versions below)
- MySQL 5.7.31(mysqldump)
- jq 1.6 (json parser)

## Setting instructions

##### Steps
- get an authorization token, according to the instructions https://yandex.ru/dev/oauth/doc/dg/reference/web-client.html#web-client__js
> NOTE: Пример токена AgAAAAAbME1aAAbX4ZR7-U_gzU5hq5IMEcBlaa1
- clone the project to the project folder
```bash
$ git clone git@gitlab.com:rocketfirm/teva-cbg/teva-back.git
```
- go to the "backups" folder and replace the data for connecting to the database in the dump.sh file
```bash
$ sed -i 's/{%project%}/project' backups/dump.sh
$ sed -i 's/{%db_user%}/username' backups/dump.sh
$ sed -i 's/{%db_password%}/password' backups/dump.sh
$ sed -i 's/{%db_name%}/db_name' backups/dump.sh
$ sed -i 's/{%auth_token%}/auth_token' backups/dump.sh
```
- set Healthchecker to check folder creation and file upload
```bash
$ sed -i 's/{%healthchecker%}/healthchecker' backups/dump.sh
```
## Comments
