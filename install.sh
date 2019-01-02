#!/bin/sh

set -e

if [ -n "$EMAIL" ]; then
    echo "Email is required to install certificates"
    exit 1
fi

## Just appends the args to the end of the command
## supply domain list to be added to this command:
## -d example.com [[-d arg], ...]
docker run -p80:80 verdude/certbot certbot certonly --agree-tos -m $EMAIL --keep --standalone --no-eff-email -n $@

