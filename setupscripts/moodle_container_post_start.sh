#!/bin/bash

echo "Starting Post Start commands."
echo "Starting Service: APACHE2"
systemctl enable apache2
service apache2 start 
echo "APACHE2 Started"

echo "Starting Service: postgresql"
systemctl enable postgresql
service postgresql start
echo "postgresql Started"
