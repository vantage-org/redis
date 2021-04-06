#!/bin/sh
set -e

random_string() {
    head /dev/urandom | LC_ALL=C tr -dc a-z0-9 | head -c 12
}

PASSWORD=$(random_string)
CONTAINER_NAME="vg-redis-$PASSWORD"

PORT=${VG_REDIS_PORT:-6379}
NETWORK="${VG_DOCKER_NETWORK:-bridge}"

CONTAINER=$(docker run \
    --detach \
    --label vantage \
    --label vantage-redis \
    --name "$CONTAINER_NAME" \
    --network "$NETWORK" \
    --publish "$PORT" \
    "redis:${VG_REDIS_VERSION:-latest}" redis-server --requirepass "$PASSWORD")

if [ -n "$VG_DOCKER_NETWORK" ]; then
    HOST="$CONTAINER_NAME"
else
    HOST='localhost'
    PORT=$(docker inspect --format '{{(index (index .NetworkSettings.Ports "6379/tcp") 0).HostPort}}' "$CONTAINER")
fi

DB="redis://default:$PASSWORD@$HOST:$PORT"

$VG_BINARY __env "REDIS_URL=$DB"

echo "$DB"
