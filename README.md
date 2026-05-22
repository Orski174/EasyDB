# EasyDB

EasyDB is a database-backed factory management application with a React frontend, an Express backend API, and a PostgreSQL database.

## Architecture

The application runs as three Docker Compose services:

- `frontend`: builds the React app and serves it through nginx.
- `backend`: runs the Express API on port `5000` inside the Compose network.
- `database`: runs PostgreSQL and initializes the schema/data from `Tables/InitializeTables.sql`.

The frontend is exposed on your machine. The backend and database communicate internally through Docker Compose.

## Prerequisites

Install Docker Desktop or Docker Engine with Docker Compose support.

You do not need to install Node.js, npm, or PostgreSQL locally when running with Docker Compose.

## Run The Application

From the project root, build and start all services:

```bash
docker compose up --build
```

Open the application:

```text
http://localhost:3000
```

The frontend proxies API requests to the backend automatically.

## Stop The Application

```bash
docker compose down
```

## Configuration

The Compose file supports these optional environment variables:

```env
POSTGRES_DB=EasyDB
POSTGRES_USER=postgres
POSTGRES_PASSWORD=123
FRONTEND_PORT=3000
```

You can place them in a local `.env` file next to `docker-compose.yml`.

Example:

```env
FRONTEND_PORT=3001
POSTGRES_PASSWORD=my_password
```

Then run:

```bash
docker compose up --build
```

## Database Reset

PostgreSQL initializes the database only when the Docker volume is first created. If you change the initialization SQL or want a fresh seeded database, remove the volume:

```bash
docker compose down -v
docker compose up --build
```

Warning: `docker compose down -v` deletes the local database volume.

## Useful Commands

View running services:

```bash
docker compose ps
```

View backend logs:

```bash
docker compose logs -f backend
```

Open a PostgreSQL shell:

```bash
docker compose exec database psql -U postgres -d EasyDB
```

Rebuild from scratch:

```bash
docker compose build --no-cache
docker compose up
```

## Contributors

- [Hadi Mchawrab](https://github.com/HadiMchawrab)
- [Omar El Jamal](https://github.com/Orski174)
- [Khaled Nasser](https://github.com/khldnsser)
