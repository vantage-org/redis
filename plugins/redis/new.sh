#!/bin/sh
set -e

random_string() {
    head /dev/urandom | LC_ALL=C tr -dc a-z0-9 | head -c 12
}

PASSWORD=$(random_string)
NAME=$(random_string)
CONTAINER_NAME="vg-redis-$NAME"

PORT=${VG_REDIS_PORT:-6379}
NETWORK="${VG_DOCKER_NETWORK:-vg_redis}"
docker network create "$NETWORK" > /dev/null 2> /dev/null || true

CONTAINER=$(docker run \
    --detach \
    --label vantage \
    --label vantage-redis \
    --name "$CONTAINER_NAME" \
    --network "$NETWORK" \
    --publish "$PORT" \
    "redis:${VG_REDIS_VERSION:-latest}" redis-server --requirepass "$PASSWORD")

DB="redis://default:$PASSWORD@$CONTAINER_NAME:$PORT"

vg __env "REDIS_URL=$DB"
vg __env "REDIS_HOST=$CONTAINER_NAME"
vg __env "REDIS_PORT=$PORT"
vg __env "REDIS_USERNAME=default"
vg __env "REDIS_PASSWORD=$PASSWORD"

echo "$DB"
