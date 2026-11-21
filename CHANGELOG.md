# Changelog

Changes to this Railway template. Breaking changes are listed first in each entry.
Upstream app changes: https://github.com/Pouzor/homelable/blob/main/CHANGELOG.md

## 3.7.1 (2026-11-21)

- First release: Homelable 3.7.1 (`ghcr.io/pouzor/homelable-backend` and `ghcr.io/pouzor/homelable-frontend`, pinned by digest).
- Backend: refuses to start without `SECRET_KEY` and `ADMIN_PASSWORD`; the password is bcrypt-hashed at every boot, so there is no `admin`/`admin` default.
- Frontend: nginx listens on `PORT` (IPv4 and IPv6) and resolves the backend over Railway's private network at request time.
