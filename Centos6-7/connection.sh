#!/bin/bash
env=$1
user=$2
ip=$3
mkdir ~/.ssh
cp /vagrant/id_rsa-cert.pub ~/.ssh/
cp /vagrant/msmkey03.pem ~/.ssh/
chmod -R 600 ~/.ssh
ssh-agent > ~/.ssh/environment
. ~/.ssh/environment
ssh-add
ssh-add ~/.ssh/msmkey03.pem
ssh -o ProxyCommand='ssh -W %h:%p sysadmin@j1.'$env'.gb.moneysupermarket.com' $user@$ip
#scp -o ProxyCommand='ssh -v -W %h:%p sysadmin@j1.'$env'.gb.moneysupermarket.com' $user@$ip:/opt/jfrog/artifactory/etc/artifactory.config.xml .
