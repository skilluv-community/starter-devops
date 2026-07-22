# Example OpenTofu configuration provisioning a single Hetzner Cloud VM to host
# the Coolify PaaS. Adapt the provider, region, and image to your cloud of choice.
#
# Usage:
#   cd infra/tofu
#   tofu init
#   tofu plan  -var="hcloud_token=REDACTED" -var="ssh_key=YOUR_SSH_KEY_NAME"
#   tofu apply -var="hcloud_token=REDACTED" -var="ssh_key=YOUR_SSH_KEY_NAME"

terraform {
  required_version = ">= 1.8"
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.48"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_ssh_key" "default" {
  name       = "${var.project_name}-ssh"
  public_key = file(var.ssh_public_key_path)
}

resource "hcloud_server" "coolify" {
  name        = "${var.project_name}-coolify"
  image       = "debian-12"
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.default.id]
  labels      = { project = var.project_name, role = "coolify" }
}
