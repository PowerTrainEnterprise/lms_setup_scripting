#!/bin/bash
echo "Moodle Container Instance Launched. Starting Post Create commands."

echo "Copying CODESPACE_NAME."
echo "https://"$CODESPACE_NAME"-8081.githubpreview.dev" >> /codespace_url.txt
echo "Copied CODESPACE_NAME."

echo "Copying Custom Config File."
cp /moodle_docker_config.php /workspaces/moodle_container_instance/config.php
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

su postgres psql -c "CREATE USER root WITH PASSWORD 'root';"
#psql postgres -c "CREATE USER moodle WITH PASSWORD 'moodle';"
#psql postgres -c "CREATE DATABASE moodle WITH OWNER moodle;"
#psql moodle < /moodle_preconfigured_database.sql
