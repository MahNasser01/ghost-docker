#!/bin/sh
set -e

# Copy S3 adapter into the content volume on every start.
# The adapter is staged at /opt/ghost-adapters in the image (outside the
# bind-mounted content dir) so it survives volume mounts.
if [ "${storage__active}" = "s3" ]; then
    DEST=/var/lib/ghost/content/adapters/storage/s3
    if [ ! -f "$DEST/index.js" ]; then
        echo "Copying S3 storage adapter to content directory..."
        mkdir -p "$DEST"
        cp -r /opt/ghost-adapters/storage/s3/. "$DEST/"
        chown -R node:node /var/lib/ghost/content/adapters
    fi
fi

exec docker-entrypoint.sh "$@"
