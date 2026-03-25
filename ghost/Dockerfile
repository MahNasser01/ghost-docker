ARG GHOST_VERSION=6-alpine
FROM ghost:${GHOST_VERSION}

# Install the S3 adapter into a staging area outside the content bind-mount.
# Ghost's require() resolves the adapter as a directory, so we must place the
# package files at the ROOT of /opt/ghost-adapters/storage/s3/ (not inside
# node_modules/) and keep all transitive dependencies in node_modules/ alongside.
RUN mkdir -p /tmp/s3-build \
    && cd /tmp/s3-build \
    && npm install ghost-storage-adapter-s3 \
    && mkdir -p /opt/ghost-adapters/storage/s3 \
    # Copy the adapter package files to the adapter root
    && cp -r /tmp/s3-build/node_modules/ghost-storage-adapter-s3/. /opt/ghost-adapters/storage/s3/ \
    # Copy all dependencies (aws-sdk etc.) into the adapter's node_modules
    && cp -r /tmp/s3-build/node_modules /opt/ghost-adapters/storage/s3/ \
    && rm -rf /tmp/s3-build \
    # Patch adapter to not send ACL header (required for buckets with ACLs disabled)
    && sed -i '/ACL:/d' /opt/ghost-adapters/storage/s3/index.js \
    && chown -R node:node /opt/ghost-adapters

COPY ghost/docker-entrypoint-custom.sh /usr/local/bin/docker-entrypoint-custom.sh
RUN chmod +x /usr/local/bin/docker-entrypoint-custom.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint-custom.sh"]
CMD ["node", "current/index.js"]
