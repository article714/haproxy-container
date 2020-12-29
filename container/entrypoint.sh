#!/bin/bash

PATH=/sbin:/usr/sbin:/bin:/usr/bin

#set -x

start() {
    if [[ ! -f "/container/config/ssl/00_haproxy.crt" ]]; then
        # Build self-signed Certificate
        chown haproxy.root /container/ssl
        cd /container/config/ssl
        chpst -u haproxy openssl req -newkey rsa:4096 -days 1001 -nodes -x509 -subj "/C=FR/O=Article714/CN=haproxy.localhost" -keyout "00_haproxy.key" -out "00_haproxy.crt"
        cd /
    fi

    exec runsvdir -P /container/services
}

case "$1" in
start)
    start
    ;;
shell)
    exec "/bin/bash"
    ;;
--)
    start
    ;;
*)
    exec "$@"
    ;;
esac

exit 1
