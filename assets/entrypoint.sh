#!/bin/bash
set -eu

function server_stop {
	echo ""
	echo "SERVER STOP"
	service postfix stop
	service rsyslog stop
	exit 0
}

function server_start {

	cat /passwords | perl -lnE 'if(m#^USERNAME: (.+) / PASSWORD: (.+)#) { say "echo '"'"'$2'"'"' | saslpasswd2 -p -f /var/spool/postfix/etc/sasldb2 -c -u \$(/usr/sbin/postconf -h myhostname) $1" }' | sh -e
	chgrp postfix /var/spool/postfix/etc/sasldb2

	echo "SERVER START"
	service rsyslog start
	service postfix start
	sleep infinity & wait
}

function usage {
	echo "USAGE: $0 [ server | bash ]"
	exit 1
}

case "${1:-}" in
	"server" )
		trap server_stop TERM
		server_start
		;;

	"bash" )
		shift
		exec bash $@	
		;;

	"copy-snakeoil" )
		# openssl genrsa 2048 > /certs/privkey.pem
		# openssl req -new -x509 -days 3650 -key /certs/privkey.pem -out /certs/fullchain.pem
		cp /etc/ssl/certs/ssl-cert-snakeoil.pem /certs/fullchain.pem
		cp /etc/ssl/private/ssl-cert-snakeoil.key /certs/privkey.pem
		chown -R $HUID:$HGID /certs
		;;

	* )
		usage
		;;
esac

