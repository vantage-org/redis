#!/bin/sh
set -e

printf "\nTEST: Creating a new database\n"
"$VG_BINARY" redis new

printf "\nTEST: Pinging the database\n"
"$VG_BINARY" redis ping

printf "\nTEST: Creating some data\n"
"$VG_BINARY" redis run incr mycounter

printf "\nTEST: Removing the database\n"
"$VG_BINARY" redis rm

printf "\nTEST: Trying to ping again (should fail)\n"
set +e
if "$VG_BINARY" redis ping; then
    exit 1
fi
set -e

printf "\nTEST: Creating two new databases\n"
"$VG_BINARY" redis new
"$VG_BINARY" redis new

printf "\nTEST: Removing both running databases\n"
"$VG_BINARY" redis rm -a
