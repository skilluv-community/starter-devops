.PHONY: dev up down test lint tofu-init tofu-plan help

help:
	@echo "Targets: dev / up / down / test / lint / tofu-init / tofu-plan"

dev: up

up:
	docker compose up --build

down:
	docker compose down

test:
	cd app && python -m pytest -q

lint:
	docker compose config -q
	cd infra/tofu && tofu fmt -check -recursive
	cd infra/monitoring && yamllint prometheus.yml loki-config.yml || true

tofu-init:
	cd infra/tofu && tofu init

tofu-plan:
	cd infra/tofu && tofu plan
