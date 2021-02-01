today=$(date +"%Y-%m-%d")
project={%project%}
healthchecker={%healthchecker%}
db_user={%db_user%}
db_password={%db_password%}
db_name={%db_name%}
auth_token={%auth_token%}

mysqldump -u ${db_user} -p${db_password} ${db_name} | gzip -c > mysql-monthly/backup_${today}.sql.gz
echo "DB dump was created backup_${today}.sql.gz"

folder=$(curl -X PUT -sH "Authorization: OAuth ${auth_token}" "https://cloud-api.yandex.net/v1/disk/resources?path=%2F${project}" | jq -r '.href')
if [[ ${folder} != null ]]
then
    href=$(curl -sH "Authorization: OAuth ${auth_token}" "https://cloud-api.yandex.net/v1/disk/resources/upload?path=${project}/backup_${today}.sql.gz&overwrite=true" | jq -r '.href')
    if [[ ${href} != null ]]
    then
        echo "Get url for upload ${href}"
        result=$(curl -X PUT -sT "mysql-monthly/backup_${today}.sql.gz" "${href}")
        echo "SUCCESS: File was uploaded ${result}"
    else
        curl -fsS -m 10 --retry 5 -o /dev/null ${healthchecker}
        echo "ERR: Getting url is failed. Check or recreate token!"
    fi
else
    curl -fsS -m 10 --retry 5 -o /dev/null ${healthchecker}
    echo "ERR: Folder ${project} wasn't created. Check or recreate token!"
fi
