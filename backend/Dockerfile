# Homelable backend (FastAPI API, scanner, status checker), official upstream image.
# Pinned by version and digest; bump both together and add a CHANGELOG.md entry.
FROM ghcr.io/pouzor/homelable-backend:3.7.1@sha256:f0f5f26461991bb8c14bd835f06244755fed9e63f818fa184b237f2d55f7f188

COPY start.sh /usr/local/bin/homelable-start
RUN chmod 0755 /usr/local/bin/homelable-start

ENV PORT=8000 \
    SQLITE_PATH=/app/data/homelab.db

VOLUME ["/app/data"]
EXPOSE 8000

CMD ["/usr/local/bin/homelable-start"]
