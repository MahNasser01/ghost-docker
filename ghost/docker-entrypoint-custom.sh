#!/bin/sh
set -e

if [ "${storage__active}" = "s3" ]; then
    DEST=/var/lib/ghost/content/adapters/storage/s3
    if [ ! -f "$DEST/index.js" ]; then
        echo "[s3-setup] Copying S3 adapter to content directory..."
        mkdir -p "$DEST"
        cp -r /opt/ghost-adapters/storage/s3/. "$DEST/"
        chown -R node:node /var/lib/ghost/content/adapters
        echo "[s3-setup] Done."
    else
        echo "[s3-setup] S3 adapter already present, skipping."
    fi
fi

exec docker-entrypoint.sh "$@"
