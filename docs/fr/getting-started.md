# Démarrage — starter-devops

## Prérequis

- Docker + Docker Compose 2.24+
- OpenTofu 1.8+ (pour `infra/tofu/`)
- Optionnel : compte Hetzner Cloud (ou adapter le provider)

## Stack locale

```bash
cp .env.example .env
docker compose up --build
```

- App : <http://localhost:8000>
- Prometheus : <http://localhost:9090>
- Grafana : <http://localhost:3000> — admin `admin` / `${GRAFANA_ADMIN_PASSWORD}`
- Loki : <http://localhost:3100>

Un dashboard Grafana est provisionné auto : `starter-devops · app overview`.

## Provisionner une VM

```bash
cp infra/tofu/terraform.tfvars.example infra/tofu/terraform.tfvars
cd infra/tofu
tofu init
tofu plan
tofu apply
```

Installer Coolify :

```bash
ssh root@<ip> "curl -fsSL https://cdn.coollabs.io/coolify/install.sh | bash"
```

## Déploiement via GitHub Actions

`.github/workflows/deploy.yml` build multi-arch, push GHCR, ping webhook Coolify. Variables/secrets :

- `vars.COOLIFY_WEBHOOK_URL`
- `secrets.COOLIFY_WEBHOOK_TOKEN`
