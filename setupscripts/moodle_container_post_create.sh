#!/bin/bash
echo "Moodle Container Instance Launched. Starting Post Create commands."

echo "Copying Custom Config File."
cp /moodle_docker_config.php /workspaces/moodle_container_instance/config.php
echo "Custom Config File Copied!"

echo "Starting Service: APACHE2"
systemctl enable apache2
#service apache2 start 
echo "APACHE2 Started"

echo "Starting Service: postgresql"
systemctl enable postgresql
#service postgresql start
echo "postgresql Started"
