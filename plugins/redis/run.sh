#!/bin/sh
# ---
# image:
#   tag: "redis:$VG_REDIS_VERSION"
#   network: $VG_DOCKER_NETWORK
#   interactive: true
#   tty: true
#   rm: true
# defaults:
#   VG_REDIS_VERSION: latest
#   VG_DOCKER_NETWORK: host
# ---
if [ -n "$1" ] ; then
    redis-cli -u "$REDIS_URL" $@
else
    redis-cli -u "$REDIS_URL"
fi
