#!/bin/sh
# Runs before upstream's 18-homelable-config.envsh. The upstream image deletes
# nginx's stock conf.d/default.conf in a build layer, but on Railway that file
# was still present at runtime, which made upstream's hook skip our template and
# serve nginx's default site on port 80. Remove it at start-up instead.
if [ -e /etc/nginx/conf.d/default.conf ]; then
    rm /etc/nginx/conf.d/default.conf && echo "05-railway-default-conf.sh: removed stock conf.d/default.conf"
fi
