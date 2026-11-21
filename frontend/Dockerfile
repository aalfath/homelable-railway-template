# Homelable frontend (React SPA behind nginx, proxying /api to the backend), official upstream image.
# Pinned by version and digest; bump both together and add a CHANGELOG.md entry.
FROM ghcr.io/pouzor/homelable-frontend:3.7.1@sha256:2e52e1ba1cd0142c03988b247ca38f1fcbcf668efe39fb5849d432298a56a518

# Railway version of upstream's docker/nginx.conf: listens on $PORT (IPv4 and IPv6)
# and resolves the backend at request time, so a backend redeploy (new private IP)
# never leaves nginx pointing at a stale address.
COPY homelable.conf.template /etc/nginx/templates/homelable.conf.template
COPY 05-railway-default-conf.sh /docker-entrypoint.d/05-railway-default-conf.sh

ENV PORT=8080 \
    BACKEND_UPSTREAM=backend:8000 \
    NGINX_ENTRYPOINT_LOCAL_RESOLVERS=1 \
    NGINX_ENVSUBST_FILTER=^(BACKEND_UPSTREAM|PORT|NGINX_LOCAL_RESOLVERS)\$

# nginx "worker_processes auto" starts one worker per host CPU; Railway hosts have many.
RUN chmod 0755 /docker-entrypoint.d/05-railway-default-conf.sh \
 && sed -i "s/^worker_processes.*/worker_processes 2;/" /etc/nginx/nginx.conf

EXPOSE 8080
