

output "instance_name" {
  value = "${google_compute_instance.compute_kubernetes_control_plane.*.name}"
}