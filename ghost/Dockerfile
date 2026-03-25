ARG GHOST_VERSION=6-alpine
FROM ghost:${GHOST_VERSION}

# Install S3 adapter to a path outside the content bind-mount so it isn't
# hidden when ./data/ghost is mounted over /var/lib/ghost/content.
RUN mkdir -p /opt/ghost-adapters/storage/s3 \
    && cd /opt/ghost-adapters/storage/s3 \
    && npm install ghost-storage-adapter-s3 \
    && chown -R node:node /opt/ghost-adapters

# Custom entrypoint copies the adapter into the content dir on each start
COPY ghost/docker-entrypoint-custom.sh /usr/local/bin/docker-entrypoint-custom.sh
RUN chmod +x /usr/local/bin/docker-entrypoint-custom.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint-custom.sh"]
CMD ["node", "current/index.js"]
