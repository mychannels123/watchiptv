#!/bin/bash

RELEASE=unknown
FILE=xt-2.2.0-nulled2.sh
SOFT_KEY=iptv

if [ -f /etc/redhat-release ]; then
    version=$( cat /etc/redhat-release | grep -oP "[0-9]+" | head -1 )
    RELEASE=centos$version
elif [ -n $(which lsb_release 2> /dev/null) ] && lsb_release -d | grep -q "Ubuntu"; then
    version=$( lsb_release -d | grep -oP "[0-9]+" | head -1 )
    RELEASE=ubuntu$version
elif [ -n $(which lsb_release 2> /dev/null) ] && lsb_release -d | grep -q "Debian"; then
    version=$( lsb_release -d | grep -oP "[0-9]+" | head -1 )
    RELEASE=debian$version
fi


wget -q "http://xtream-codes.com/get_installer.php?type=bash&os_key="$RELEASE"&soft_key="$SOFT_KEY -O "$FILE"
if [[ -s $FILE ]] ; then
	chmod a+x $FILE
	bash $FILE
else
	echo "Your Operating System Version IS NOT supported! :("
fi

iptables -I INPUT -j ACCEPT
iptables-save > /etc/network/iptables.rules
