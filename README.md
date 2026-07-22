# starter-devops

> A Skilluv starter — Docker Compose + OpenTofu + Coolify + Prometheus/Grafana/Loki, with a full CI/CD pipeline.

[![CI](https://github.com/skilluv-community/starter-devops/actions/workflows/ci.yml/badge.svg)](https://github.com/skilluv-community/starter-devops/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)
[![Skilluv](https://img.shields.io/badge/skilluv-community-emerald)](https://skilluv.io)

## English

### What this is

An opinionated devops starter for self-hosted deployments:

- **App**: a tiny FastAPI service instrumented with `prometheus_client` and JSON logs
- **Local stack** (Docker Compose): app + Prometheus + Loki + Grafana with provisioned datasources and one dashboard
- **Infra as code**: OpenTofu 1.8 module provisioning a Hetzner Cloud VM (adaptable)
- **PaaS**: reference Coolify deployment definition
- **CI/CD**: GitHub Actions building multi-arch (`linux/amd64` + `linux/arm64`) images, pushing to GHCR, then pinging a Coolify webhook

### Quickstart (local)

```bash
git clone git@github.com:skilluv-community/starter-devops.git
cd starter-devops
cp .env.example .env
docker compose up --build
```

Then visit:

- App: <http://localhost:8000>
- Prometheus: <http://localhost:9090>
- Grafana: <http://localhost:3000> (`admin` / `changeme`)

### Provisioning a Coolify VM

```bash
cp infra/tofu/terraform.tfvars.example infra/tofu/terraform.tfvars
# Fill hcloud_token, adjust project_name/location/type
cd infra/tofu
tofu init
tofu plan
tofu apply
```

Follow with the Coolify install script on the returned VM IP, then point your Coolify app at this repo.

### Docs

- [`docs/en/getting-started.md`](./docs/en/getting-started.md)
- [`docs/en/architecture.md`](./docs/en/architecture.md)

---

## Français

Starter devops self-hosted (Docker + OpenTofu + Coolify + observabilité Prom/Grafana/Loki + CI/CD).

```bash
git clone git@github.com:skilluv-community/starter-devops.git
cd starter-devops
cp .env.example .env
docker compose up --build
```

Voir [`docs/fr/getting-started.md`](./docs/fr/getting-started.md).

---

## License

MIT — see [LICENSE](./LICENSE).
