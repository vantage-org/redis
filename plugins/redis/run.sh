#!/bin/sh
# ---
# image:
#   tag: "redis:$VG_REDIS_VERSION"
#   network: $VG_DOCKER_NETWORK
# environment:
#   - VG_REDIS_VERSION=latest
#   - VG_DOCKER_NETWORK=vg_redis
# ---
if [ -n "$1" ] ; then
    redis-cli -u "$REDIS_URL" $@
else
    redis-cli -u "$REDIS_URL"
fi
