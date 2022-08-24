#!/bin/bash
echo "Moodle Container Instance Launched. Starting Post Create commands."

echo "Starting Service: APACHE2"
system apache2 start 
echo "APACHE2 Started"
