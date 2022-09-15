#!/bin/bash
echo "Moodle Container Instance Launched. Starting Post Create commands."

echo "Starting Service: APACHE2"
systemctl enable apache2
service apache2 start 
echo "APACHE2 Started"

echo "Starting Service: postgresql"
systemctl enable postgresql
service postgresql start
echo "postgresql Started"