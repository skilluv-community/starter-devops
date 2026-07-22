output "coolify_ipv4" {
  value       = hcloud_server.coolify.ipv4_address
  description = "Public IPv4 of the Coolify server."
}

output "coolify_url" {
  value       = "https://${hcloud_server.coolify.ipv4_address}:8000"
  description = "Coolify dashboard URL (once installed on the VM)."
}
