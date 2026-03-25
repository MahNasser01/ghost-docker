#!/bin/sh
set -e

if [ "${storage__active}" = "s3" ]; then
    DEST=/var/lib/ghost/content/adapters/storage/s3
    echo "[s3-setup] Installing S3 adapter..."
    mkdir -p "$DEST"
    # Always overwrite so patches from image rebuilds are applied
    cp -r /opt/ghost-adapters/storage/s3/. "$DEST/"
    chown -R node:node /var/lib/ghost/content/adapters
    echo "[s3-setup] Done."
fi

exec docker-entrypoint.sh "$@"
