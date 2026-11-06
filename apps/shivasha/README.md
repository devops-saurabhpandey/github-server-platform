# Shivasha self-hosted database

This folder runs a private MongoDB Community Server for the Shivasha application.

## Requirements

- A Linux machine/server with Docker Engine and the Docker Compose plugin.
- Enough disk space for the database and backups.
- A strong, unique root password and a separate strong application password.

GitHub is only the source-code host. These commands run on the machine you control.

## First-time setup

Run these commands on the Linux server from this folder:

```sh
cp .env.example .env
nano .env
```

Replace both example passwords with different, long random values. Keep the file private.

Start the database:

```sh
docker compose up -d
docker compose ps
docker compose logs --tail=80 mongo
```

Wait until the MongoDB health status is `healthy`.

## Application connection

The MongoDB service is reachable only from containers attached to the Docker network `shivasha_data`. No database port is published on the host or internet.

Use this connection string from the Shivasha backend after it is attached to that network:

```text
mongodb://shivasha_app:<APP_PASSWORD>@mongo:27017/shivasha?authSource=shivasha
```

Replace `<APP_PASSWORD>` with the value of `MONGO_APP_PASSWORD` in the private `.env` file. Do not paste passwords into GitHub, chat, screenshots, or public logs.

The backend's Compose service must join the existing network:

```yaml
networks:
  - shivasha_data
```

And declare it as external:

```yaml
networks:
  shivasha_data:
    external: true
    name: shivasha_data
```

Do not expose port 27017 publicly. Do not use the root account in the application.

## Backups

Create backups on the server and copy them to a separate physical drive. A database volume alone is not a backup. Test restores before relying on the service.

The platform-level backup helper is documented in the repository root; never commit backup files.

## Important behavior

- The initialization script creates the least-privilege application user only when the database volume is first initialized.
- Changing values in `.env` later does not change users already stored in MongoDB.
- If credentials are lost, do not delete the database volume to "reset" passwords; that would destroy data. Recover access deliberately and take a backup first.
- This is a self-hosted foundation, not yet connected to the live Shivasha backend.
