#!/bin/bash
set -e

stop_and_remove_all() {
    docker ps --quiet --all --filter "label=vantage-redis" | while IFS='' read -r CONTAINER_ID
    do
        stop_and_remove "$CONTAINER_ID"
    done
}

stop_and_remove() {
    echo "Removing $1"
    docker stop "$1" > /dev/null
    docker rm "$1" > /dev/null
}

while getopts ":a" opt; do
    case $opt in
        a)
            stop_and_remove_all
            exit
            ;;
        *)
            ;;
    esac
done

stop_and_remove "$(vg __env REDIS_HOST)"
