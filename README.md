# Auto backup on Yandex.Disk
![curl](https://img.shields.io/badge/curl-7.64.1-blue)
![MySQL](https://img.shields.io/badge/mysql-5.7.31-blue)
![jq](https://img.shields.io/badge/jq-1.6-orange)

Инструкция для настройки автоматического бэкапирования БД на сервере с последующей загрузкой архивов на Яндекс.Диск

## Ссылки

- Документация API Яндекс.Диска - https://yandex.ru/dev/disk/api/reference/upload.html
- Документация curl - https://curl.se/docs/manpage.html
    
## Стэк Backend

- curl 7.64.1(на версиях ниже не проверено)
- MySQL 5.7.31(mysqldump)
- jq 1.6 (json parser)

## Инструкция по настройке

##### Шаги
- получить токен авторизации, по инструкции https://yandex.ru/dev/oauth/doc/dg/reference/web-client.html#web-client__js
> NOTE: Пример токена AgAAAAAbME1aAAbX4ZR7-U_gzU5hq5IMEcBlaa1
- склонировать проект в папку проекта 
```bash
$ git clone git@gitlab.com:rocketfirm/teva-cbg/teva-back.git
```
- зайти в папку backups и заменить в файле dump.sh данные для подключения к БД: название проекта, пользователь БД, пароль, название БД, токен авторизации на Яндекс.Диск
```bash
$ sed -i 's/{%project%}/project' backups/dump.sh
$ sed -i 's/{%db_user%}/username' backups/dump.sh
$ sed -i 's/{%db_password%}/password' backups/dump.sh
$ sed -i 's/{%db_name%}/db_name' backups/dump.sh
$ sed -i 's/{%auth_token%}/auth_token' backups/dump.sh
```

## Комментарии
- установлен Healthchecker на проверку создания папки и загрузки файла
