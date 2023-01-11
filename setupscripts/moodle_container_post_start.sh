#!/bin/bash
systemctl enable apache2
service apache2 start 
systemctl enable postgresql
service postgresql start
echo "Services Restarted: apache2, postgresql"
