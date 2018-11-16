#!/bin/bash
env=$1
pkill ssh-agent
eval `keychain --quiet --quick --eval --agents ssh`
export JSESSIONID_FILE=~/.ssh/$env/JSESSIONID
find `dirname $JSESSIONID_FILE` -name `basename $JSESSIONID_FILE` -mmin -18 -not -empty 2>/dev/null >/dev/null

if [[ $? = 0 ]]; then
	if [[ $env = "test" ]]; then
		var=1
	fi
	if [[ $env = "inf" ]]; then
		var=9
	fi
	rm -rf ~/.ssh/$env/id_rsa-cert.pub		
	ssh-add -d 2>/dev/null 

	curl -k -v --cookie "JSESSIONID=`cat $JSESSIONID_FILE`"  https://totskey$var.moneysupermarketgroup.com/totskey/v1/ssh 2>/dev/null |  grep '^ *"data"' | sed -e 's/^ *"data" : "//;s/",$//' >~/.ssh/$env/id_rsa-cert.pub  
	chmod 600 ~/.ssh/$env/id_rsa-cert.pub 
	ssh-add 2>/dev/null
	ssh-add ~/.ssh/inf/msmkey03.pem 2>/dev/null
  	touch $JSESSIONID_FILE 
fi
unset JSESSIONID_FILE
