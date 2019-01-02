#!/bin/sh

set -e

if [ -z "$EMAIL" ]; then
    echo "Email is required to install certificates"
    exit 1
fi

container_name=`openssl rand -base64 12`

if [ -z "$container_name" ]; then
    echo "Failed to create container name."
    exit 1
fi

## Just appends the args to the end of the command
## supply domain list to be added to this command:
## -d example.com [[-d arg], ...]
docker run -p80:80 --rm --name $container_name verdude/certbot certbot certonly --agree-tos -m $EMAIL --keep --standalone --no-eff-email -n $@
exitcode=$?

if [ $exitcode -eq 0 ]; then
    docker cp $container_name:/etc/letsencrypt/ /etc/
fi

exit $exitcode

