#!/bin/bash
echo "Moodle Container Instance Launched. Starting Post Create commands."

echo "Copying CODESPACE_NAME."
#echo "https://"$CODESPACE_NAME"-8081.githubpreview.dev" >> /codespace_url.txt
echo "Copied CODESPACE_NAME."

#update every instance of "moodle_container_instance" to the name of the current repo.
IFS='/'
read -a strarr <<< "$GITHUB_REPOSITORY"

sed -i "s/moodle_container_instance/${strarr[1]}/" /etc/apache2/sites-enabled/000-default.conf

echo "Copying Custom Config File."
cp /moodle_docker_config.php /workspaces/${strarr[1]}/config.php
echo "Custom Config File Copied!"

echo "Starting Service: APACHE2"
systemctl enable apache2
service apache2 start 
echo "APACHE2 Started"

echo "Starting Service: postgresql"
systemctl enable postgresql
service postgresql start
echo "postgresql Started"

chmod -R 777 /moodledata

echo "Copying submodules."
#git submodule update --init
echo "Copied submodules."


mkdir ~/.ssh
chmod -R 600 ~/.ssh
echo "$CODESPACE_PUBLIC_SSH_KEY" > ~/.ssh/id_rsa_powertraininc_codespace.pub
echo "$CODESPACE_PRIVATE_SSH_KEY" > ~/.ssh/id_rsa_powertraininc_codespace
chmod 600 ~/.ssh/id_rsa_powertraininc_codespace
chmod 600 ~/.ssh/id_rsa_powertraininc_codespace.pub

git submodule update --init
git config core.fileMode false
git config core.sharedRepository group
git config --global core.autocrlf true

git submodule foreach --recursive git config core.fileMode false
git submodule foreach --recursive git config core.sharedRepository group
git submodule foreach --recursive git config --global core.autocrlf true

git lfs fetch --all

su -c "psql -c \"CREATE USER root WITH PASSWORD 'root'\"" postgres
su -c "psql -c \"ALTER USER root WITH SUPERUSER\"" postgres
su -c "psql -c \"CREATE USER moodle WITH PASSWORD 'moodle';\"" postgres
su -c "psql -c \"ALTER USER moodle WITH SUPERUSER\"" postgres
su -c "psql -c \"CREATE DATABASE moodle WITH OWNER moodle;\"" postgres

#su -c "psql -c \"CREATE ROLE rdsadmin WITH SUPERUSER;\"" postgres
#su -c "export PGPASSWORD='moodle'; pg_restore -d moodle -U moodle -h localhost -p 5432 < /moodle_preconfigured_database.sql" postgres

#su -c "pg_restore -f \"/moodle_preconfigured_database.sql\"" postgres
#su -c "psql -c \"moodle < /moodle_preconfigured_database.sql\"" postgres
#su postgres psql -c "CREATE USER root WITH PASSWORD 'root';"
#psql postgres -c "CREATE USER moodle WITH PASSWORD 'moodle';"
#psql postgres -c "CREATE DATABASE moodle WITH OWNER moodle;"
#psql moodle < /moodle_preconfigured_database.sql
