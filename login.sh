#!/bin/bash
# A simple shell script that can be used to login to the D-Link DIR-615/DIR-655 router or any other router that uses a similar web interface.
# Pass the router administrator password as the first script argument.
loginSalt=`curl -s http://192.168.0.1/ | grep -o 'var salt = ".*"' | cut -d \" -f2`
pwordSize=`echo -n $(printf "%s" "$1" | wc -m)`
if (($pwordSize < 56))
then
	loginHash=`echo -ne $loginSalt$1`
	for ((i=$pwordSize+1; i<=56; i++))
	do
		loginHash=`echo -ne $loginHash'\01'`
	done
	loginHash=`echo -ne $loginHash | md5sum | tr -d ' *-'`
else
	if (($pwordSize>=56))
	then
		loginHash=`echo -ne $loginSalt${1:0:56} | md5sum | tr -d ' *-'`
	fi
fi
loginAuth=`curl -s http://192.168.0.1/ | grep -o 'auth_id=.*' | cut -d \" -f1`
curl 'http://192.168.0.1/post_login.xml?hash='$loginSalt$loginHash'&auth_code=&'$loginAuth