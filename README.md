# Homelable on Railway

A Railway template for [Homelable](https://github.com/Pouzor/homelable), the self-hosted homelab infrastructure visualizer: an interactive network diagram with inventory, documentation and live status checks.

**Version:** Homelable 3.7.1, built from the official images pinned by digest:

| Service | Folder | Base image |
|---|---|---|
| `backend` (private) | [`backend/`](backend) | `ghcr.io/pouzor/homelable-backend:3.7.1@sha256:f0f5f264…f7f188` |
| `frontend` (public) | [`frontend/`](frontend) | `ghcr.io/pouzor/homelable-frontend:3.7.1@sha256:2e52e1ba…56a518` |

## What it deploys

- **backend**: FastAPI API, scanner and status checker, with a Railway volume at `/app/data` (SQLite database, uploads, scan settings). Health check `/api/v1/health`. The start script ([`backend/start.sh`](backend/start.sh)) refuses to start without `SECRET_KEY` and `ADMIN_PASSWORD`, and bcrypt-hashes the password at every start, so the upstream `admin`/`admin` default is never used.
- **frontend**: upstream nginx with the React app, the only public service. It listens on `PORT` (IPv4 and IPv6) and proxies `/api`, the WebSocket and `/docs` to the backend over Railway's private network, re-resolving the backend's address so backend redeploys need no frontend restart.

## Variables

| Service | Variable | Default | Notes |
|---|---|---|---|
| backend | `SECRET_KEY` | `${{secret(64)}}` | Signs login tokens. Changing it signs everyone out |
| backend | `ADMIN_PASSWORD` | `${{secret(24)}}` | Password of the admin user. Edit and redeploy to change it |
| backend | `AUTH_USERNAME` | `admin` | Login user name |
| backend | `PORT` | `8000` | Port the API listens on |
| frontend | `PORT` | `8080` | Port nginx listens on (the public domain targets it) |
| frontend | `BACKEND_UPSTREAM` | `${{backend.RAILWAY_PRIVATE_DOMAIN}}:${{backend.PORT}}` | Where nginx sends API traffic |

Sign in at the frontend's domain with `admin` and the backend's `ADMIN_PASSWORD`.

Optional upstream features (`LIVEVIEW_KEY`, `HOMEPAGE_API_KEY`, OpenID Connect via `AUTH_MODE=oidc` and `OIDC_*`, Git sync via `GIT_SYNC_*`) are backend variables; see upstream's [`.env.example`](https://github.com/Pouzor/homelable/blob/main/.env.example). Scans and status checks run from Railway's network, so they reach public addresses only, not your home LAN. The MCP server is not included.

## Updates

Each change to this repo's `main` branch (for example a new Homelable version) shows up as an "update available" notice on projects deployed from the template, and you choose when to apply it. Read [`CHANGELOG.md`](CHANGELOG.md) first: breaking changes are listed first in each entry. Back up the backend volume before major upgrades.

## Local test

`docker compose up --build` builds both folders and serves the app on http://localhost:8080 (user `admin`, password `local-test-password`).
