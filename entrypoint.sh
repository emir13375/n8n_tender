#!/bin/sh
set -e

# Railway монтирует volume от root при каждом старте контейнера,
# поэтому chown нужно делать в рантайме, а не в Dockerfile
mkdir -p /home/node/.n8n
chown -R node:node /home/node/.n8n

# Дальше передаём управление оригинальному entrypoint n8n, но уже от node
exec su-exec node docker-entrypoint.sh "$@"
