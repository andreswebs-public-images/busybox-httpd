# syntax=docker/dockerfile:1
FROM busybox:latest

LABEL org.opencontainers.image.authors="Andre Silva <andreswebs@pm.me>" \
      org.opencontainers.image.title="busybox-httpd" \
      org.opencontainers.image.description="Minimal Docker image for serving static files using BusyBox httpd" \
      org.opencontainers.image.source="https://github.com/andreswebs-public-images/busybox-httpd" \
      org.opencontainers.image.licenses="Unlicense"

ARG SRV_DIR="/srv/www"
ENV SRV_DIR="${SRV_DIR}"

ARG PORT="8080"
ENV PORT="${PORT}"

ARG PUID="2000"
ARG PGID="2000"
ARG USERNAME="static"

RUN \
  addgroup -g "${PGID}" "${USERNAME}" && \
  adduser \
    -u "${PUID}" \
    -G "${USERNAME}" \
    -g "${USERNAME}" \
    -s "/bin/sh" \
    -D \
    "${USERNAME}"

RUN mkdir -p "${SRV_DIR}" && \
    chown "${USERNAME}:${USERNAME}" "${SRV_DIR}" && \
    chmod 0555 "${SRV_DIR}"

COPY --chown="${USERNAME}:${USERNAME}" index.html "${SRV_DIR}/"

RUN chmod 0644 "${SRV_DIR}/index.html"

COPY entrypoint.sh /entrypoint.sh

RUN chmod 0755 /entrypoint.sh

COPY healthcheck.sh /healthcheck.sh

RUN chmod 0755 /healthcheck.sh

EXPOSE "${PORT}"

USER "${USERNAME}"

WORKDIR "${SRV_DIR}"

HEALTHCHECK --interval=10s --timeout=5s --start-period=2s --retries=2 CMD "/healthcheck.sh"

ENTRYPOINT ["/entrypoint.sh"]
