# Architecture — starter-devops

## Choix opinionated

### 1. Self-hosted, Coolify-first

Vercel / Netlify / AWS excellents mais lock-in et coûteux à l'échelle en contexte africain. Coolify sur une CPX Hetzner ou une VM locale = vrai PaaS à prix fixe.

### 2. OpenTofu, pas Terraform

HashiCorp relicensé Terraform en BSL. Communauté forkée en OpenTofu (Linux Foundation). Même syntaxe, mêmes providers, zéro risque licence.

### 3. Prometheus + Grafana + Loki

Trio observabilité : métriques + dashboards + logs. Zéro SaaS lock-in, déployable sur la même VM que l'app.

### 4. Images multi-arch

Build `linux/amd64` + `linux/arm64` dès le jour 1. Les VMs ARM (Hetzner CAX, AWS Graviton, SBCs edge) sont de plus en plus la norme.

### 5. GHCR plutôt que Docker Hub

Stockage public illimité gratuit, intégration GitHub, pas de rate limits pour pulls authentifiés.

### 6. Webhook Coolify pour le trigger de déploiement

Le job `deploy.yml` pingue Coolify après push image. Coolify pull et swap le conteneur. Aucune clé SSH en CI.

## Hors scope

- Kubernetes managé — starter volontairement single-VM. Pour HA : k3s + Argo CD.
- Serverless — opposé philosophique à Coolify + Docker Compose.
- Alerting complet — règles Prometheus + Alertmanager laissées en exercice.
