#!/bin/bash
 
cp -f /etc/httpd/httpd-http.conf /etc/httpd/conf/apache2.conf

sed -i -e "s/{WEB_HOSTNAME}/$RAW_HOSTNAME/g" /etc/httpd/conf/apache2.conf

echo "apache2 Built"
