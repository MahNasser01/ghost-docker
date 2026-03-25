ARG GHOST_VERSION=6-alpine
FROM ghost:${GHOST_VERSION}

# Install the S3 storage adapter into a named-volume-backed path.
# Docker will seed the ghost_adapters named volume from this image layer on
# first run, making the adapter available even though ./data/ghost is bind-
# mounted over /var/lib/ghost/content.
RUN mkdir -p /var/lib/ghost/content/adapters/storage/s3 \
    && cd /var/lib/ghost/content/adapters/storage/s3 \
    && npm install ghost-storage-adapter-s3 \
    && chown -R node:node /var/lib/ghost/content/adapters
