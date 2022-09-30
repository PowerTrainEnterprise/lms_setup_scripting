#!/bin/bash
echo "Moodle Container Instance Launched. Starting Post Create commands."

echo "Copying CODESPACE_NAME."
#echo "https://"$CODESPACE_NAME"-8081.githubpreview.dev" >> /codespace_url.txt
echo "Copied CODESPACE_NAME."


IFS='/'
read -a strarr <<< "$GITHUB_REPOSITORY"
$container_directory = ${strarr[1]}

echo "Copying Custom Config File."
cp /moodle_docker_config.php /workspaces/$container_directory/config.php
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

su -c "psql -c \"CREATE USER root WITH PASSWORD 'root'\"" postgres
su -c "psql -c \"CREATE USER moodle WITH PASSWORD 'moodle';\"" postgres
su -c "psql -c \"CREATE DATABASE moodle WITH OWNER moodle;\"" postgres
su -c "psql -c \"moodle < /moodle_preconfigured_database.sql\"" postgres
#su postgres psql -c "CREATE USER root WITH PASSWORD 'root';"
#psql postgres -c "CREATE USER moodle WITH PASSWORD 'moodle';"
#psql postgres -c "CREATE DATABASE moodle WITH OWNER moodle;"
#psql moodle < /moodle_preconfigured_database.sql
