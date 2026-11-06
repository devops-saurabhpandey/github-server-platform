#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
[ -f .env ] || { echo "Missing apps/shivasha/.env; copy .env.example and configure it first." >&2; exit 1; }
mkdir -p backups
stamp="$(date +%Y%m%d-%H%M%S)"
backup_file="backups/shivasha-mongo-${stamp}.archive.gz"
docker compose exec -T mongo sh -lc 'mongodump --archive --gzip --username "$MONGO_INITDB_ROOT_USERNAME" --password "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase admin' > "$backup_file"
echo "Backup created: $backup_file"
echo "Copy this file to a separate physical drive. Do not commit it to Git."
