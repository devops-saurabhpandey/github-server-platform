# GitHub Server Platform (Self-hosted)

A central, reusable home-server foundation for multiple repositories and apps owned by `devops-saurabhpandey`.

## Important
- GitHub stores source code; it is **not** the physical server.
- This platform runs on your own computer/server with Docker Engine + Docker Compose.
- It can avoid monthly hosting/database bills, but needs electricity, internet, backups, and basic maintenance.
- A home internet connection may not allow public access without router configuration, a public IP, or a tunnel. Do not expose admin ports directly to the internet.
- This starter does not automatically deploy every GitHub repository yet. It provides the shared foundation and a documented pattern for adding apps safely.

## Included
- `compose.yaml`: Caddy reverse proxy + Portainer admin UI + Uptime Kuma monitor.
- `Caddyfile`: local hostnames for the admin tools.
- `.env.example`: safe defaults; no credentials.
- `apps/README.md`: isolated per-app deployment pattern.
- `scripts/`: start/stop/status helper scripts for Linux/macOS.
- `SECURITY.md`: setup and security checklist.

## Quick start (Linux server / Ubuntu)
1. Install Docker Engine and the Docker Compose plugin from the official Docker documentation.
2. Copy `.env.example` to `.env` and change every sample password/secret before exposing anything.
3. Run:
   ```bash
   docker compose up -d
   docker compose ps
   ```
4. For first-time Portainer setup, open `http://portainer.localhost` on the server itself. For access from another device, configure local DNS/hosts or your router; do not forward port 9000 to the public internet.
5. Uptime Kuma: `http://status.localhost`.

> `.localhost` names resolve to loopback on most modern systems. On a second device they resolve to that device itself, so configure LAN DNS or use the server's IP with a carefully configured reverse proxy.

## Shivasha self-hosted database

A private MongoDB Community Server template for Shivasha is available in [apps/shivasha](apps/shivasha/README.md). It uses a dedicated Docker network, persistent volume, separate least-privilege app user, and no public database port.

On the Linux server, open `apps/shivasha`, copy `.env.example` to `.env`, replace both sample passwords, then run:

```sh
docker compose up -d
docker compose ps
docker compose logs --tail=80 mongo
```

Wait for the MongoDB health status to become `healthy`. For backup instructions, see [apps/shivasha/README.md](apps/shivasha/README.md) and run `sh backup.sh` from that folder. Keep backups on a separate physical drive.

This database is not yet connected to the live Shivasha backend. The backend must be deployed on the same host and attached to the external Docker network `shivasha_data` before it can use the private MongoDB service.

## Adding a new app
Keep each app in its own folder/repository and Docker Compose project. Use a unique project name, unique internal network, and separate database/credentials. See `apps/README.md`.

## Free hosting expectations
The platform software is free/open source, but 24/7 service is not guaranteed: electricity outages, ISP outages, hardware failure, and dynamic IP changes can interrupt it. Keep backups on a separate drive. Never commit `.env`, database dumps, private keys, tokens, or user data to GitHub.
