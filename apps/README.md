# Per-app deployment pattern

Do not put KTL Daily Tasks, KTL CRM, and SHIVASHA into one shared application container or one shared database.

For each app:
1. Keep its own GitHub repository.
2. Create a dedicated deployment folder on the server, for example `/opt/apps/shivasha`.
3. Use that app's own `compose.yaml`, a unique Compose project name, and its own named data volumes.
4. Use an app-specific database and credentials. Do not reuse production passwords.
5. Connect the app's frontend to the central reverse proxy through a dedicated Docker network. Do not publish its internal API/database ports unnecessarily.
6. Verify its health endpoint, logs, backup, and restore before relying on it.

Example commands (run from that app's folder):
```bash
docker compose -p shivasha up -d --build
docker compose -p shivasha ps
docker compose -p shivasha logs --tail=100
```

Use `docker compose -p ktl-daily-tasks ...` for KTL Daily Tasks and `docker compose -p ktl-crm ...` for KTL CRM. The project names and volumes remain separate. Review the app's actual Compose file before running commands; these names do not automatically make an incompatible Compose file work.
