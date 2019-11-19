#!/bin/sh
# ---
# requires:
#   - test
# ---
tar -cvzf redis.tar.gz -C "$VG_APP_DIR"/plugins/redis .
