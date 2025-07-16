#!/usr/bin/env sh

set -o errexit
set -o nounset

wget --quiet --tries=1 --spider "http://localhost:${PORT}/"
