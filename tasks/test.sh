#!/bin/sh
set -e

printf "\nTEST: Creating a new database\n"
vg redis new

printf "\nTEST: Pinging the database\n"
vg redis ping

printf "\nTEST: Creating some data\n"
vg redis run incr mycounter

printf "\nTEST: Removing the database\n"
vg redis rm

printf "\nTEST: Trying to ping again (should fail)\n"
set +e
if vg redis ping; then
    exit 1
fi
set -e

printf "\nTEST: Creating two new databases\n"
vg redis new
vg redis new

printf "\nTEST: Removing both running databases\n"
vg redis rm -a
