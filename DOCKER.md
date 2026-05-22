# EasyDB Docker Setup

This project is split into three containers:

- `frontend`: builds the React app and serves it with nginx.
- `backend`: runs the Express API on port `5000`.
- `database`: runs PostgreSQL and initializes the schema/data from `Tables/InitializeTables.sql`.

## Run

Build and start the full stack:

```bash
docker compose up --build
```

Open the application:

```text
http://localhost:3000
```

The frontend proxies API requests from `/api/*` to the backend container.

## Configuration

The compose file supports these environment variables:

```env
POSTGRES_DB=EasyDB
POSTGRES_USER=postgres
POSTGRES_PASSWORD=123
FRONTEND_PORT=3000
```

You can put them in a local `.env` file next to `docker-compose.yml`.

## Database Initialization

PostgreSQL runs files in `/docker-entrypoint-initdb.d` only when the database volume is first created. If you change `Tables/InitializeTables.sql` and want to reinitialize the development database, remove the volume:

```bash
docker compose down -v
docker compose up --build
```

That deletes the local container database data.

## Useful Commands

Stop the stack:

```bash
docker compose down
```

Open a PostgreSQL shell:

```bash
docker compose exec database psql -U postgres -d EasyDB
```

View backend logs:

```bash
docker compose logs -f backend
```
