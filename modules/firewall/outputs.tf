
output "internal_firewall_rule" {
  value = "${google_compute_firewall.kkubernetes-the-hard-way-allow-internal.name}"
}

output "external" {
  value = "${google_compute_firewall.kubernetes-the-hard-way-allow-external.name}"
}