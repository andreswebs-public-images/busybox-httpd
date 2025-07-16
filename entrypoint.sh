#!/usr/bin/env sh

set -o errexit
set -o nounset

PORT="${PORT:-8080}"
SRV_DIR="${SRV_DIR:-/srv/www}"

if [ ! -d "${SRV_DIR}" ]; then
  >&2 echo "error: ${SRV_DIR} directory does not exist"
  exit 1
fi

exec busybox httpd -f -v -p "${PORT}" -h "${SRV_DIR}"
