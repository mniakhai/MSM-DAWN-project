#!/bin/bash
mkdir -p ~/.ssh/inf
mkdir -p ~/.ssh/test

#crontab -e && echo '3-59/5 * * * * /bin/sleep $[$RANDOM\%60]s && /vagrant/Update_id_rsa-cert.sh inf'
#crontab -e && echo '3-59/5 * * * * /bin/sleep $[$RANDOM\%60]s && /vagrant/Update_id_rsa-cert.sh test' 
#touch ~/.ssh/inf/JSESSIONID
#touch ~/.ssh/inf/JSESSIONID

cp id_rsa* ~/.ssh/inf/
cp id_rsa* ~/.ssh/test/
cp msmkey03.pem ~/.ssh/inf
cp config ~/.ssh/	
chmod 600 -R ~/.ssh/inf/*
chmod 600 -R ~/.ssh/test/*
chmod 644 ~/.ssh/config	
