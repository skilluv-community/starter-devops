variable "hcloud_token" {
  type        = string
  description = "Hetzner Cloud API token."
  sensitive   = true
}

variable "project_name" {
  type    = string
  default = "skilluv-starter"
}

variable "server_type" {
  type    = string
  default = "cpx11"
}

variable "location" {
  type    = string
  default = "nbg1"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}
