# Architecture — starter-devops

## Opinionated choices

### 1. Self-hosted, Coolify-first

Vercel / Netlify / AWS are excellent, but they lock you in and are expensive at scale in African contexts. Coolify on a single Hetzner CPX or a locally-hosted VM gives you a real PaaS at flat rates.

### 2. OpenTofu, not Terraform

HashiCorp relicensed Terraform to BSL. The community forked to OpenTofu (Linux Foundation). It's the same syntax, same providers, no license risk. All new starters should default to OpenTofu.

### 3. Prometheus + Grafana + Loki

The three-piece observability stack that maps to metrics + dashboards + logs. No SaaS lock-in, deployable on the same VM as the app.

### 4. Multi-arch container images

We build `linux/amd64` and `linux/arm64` from day one. arm64 VMs (Hetzner CAX, AWS Graviton, cheap ARM SBCs for edge) are increasingly the default; not building for them limits deployment options later.

### 5. GHCR over Docker Hub

Free unlimited public storage, tighter GitHub integration, no rate limits for authenticated pulls.

### 6. Coolify webhook for deploy trigger

The `deploy.yml` job pings Coolify after the image is pushed. Coolify then pulls and swaps the container. No SSH keys in CI.

## What's out of scope

- Managed Kubernetes — this starter deliberately targets single-VM deployments. If you need HA, look at k3s + Argo CD.
- Serverless — Coolify + Docker Compose is the philosophical opposite.
- Full alerting — Prometheus + Alertmanager rules are left as an exercise; the starter ships datasources and one dashboard only.
