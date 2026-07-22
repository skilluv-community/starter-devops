# Getting started — starter-devops

## Prerequisites

- Docker + Docker Compose 2.24+
- OpenTofu 1.8+ (for `infra/tofu/`)
- Optional: a Hetzner Cloud account (or adapt the provider)

## Local stack

```bash
cp .env.example .env
docker compose up --build
```

- App: <http://localhost:8000>
- Prometheus: <http://localhost:9090>
- Grafana: <http://localhost:3000> — default admin `admin` / `${GRAFANA_ADMIN_PASSWORD}`
- Loki: <http://localhost:3100>

Grafana has one dashboard provisioned automatically: `starter-devops · app overview`.

## Provisioning a VM

```bash
cp infra/tofu/terraform.tfvars.example infra/tofu/terraform.tfvars
cd infra/tofu
tofu init
tofu plan
tofu apply
```

Then install Coolify on the returned IP:

```bash
ssh root@<ip> "curl -fsSL https://cdn.coollabs.io/coolify/install.sh | bash"
```

Open Coolify at `http://<ip>:8000`, create a Docker Compose resource pointing at this repo, and set the environment variables listed in `.env.example`.

## Deploying via GitHub Actions

`.github/workflows/deploy.yml` builds a multi-arch image for `linux/amd64` + `linux/arm64`, pushes to GHCR, and pings a Coolify webhook.

Set these repo variables/secrets:

- `vars.COOLIFY_WEBHOOK_URL` — Coolify redeploy webhook URL
- `secrets.COOLIFY_WEBHOOK_TOKEN` — Bearer token for the webhook
