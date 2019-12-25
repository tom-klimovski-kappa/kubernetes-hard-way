
locals {
  network = "${element(split("-", var.subnet), 0)}"
}

resource "google_compute_firewall" "allow-http" {
  name    = "${local.network}-allow-http"
  network = "local.network"
  project = "var.project"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # target_tags   = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "kubernetes-the-hard-way-allow-internal" {
  name    = "${local.network}-allow-internal"
  network = "local.network"
  project = "var.project}"
  allow {
    protocol = "tcp,udp,icmp"
    ports    = ["80"]
  }

  source_ranges = ["10.240.0.0/24","10.200.0.0/16"]
}

resource "google_compute_firewall" "kubernetes-the-hard-way-allow-external" {
  name    = "${local.network}-allow-external"
  network = "local.network"
  project = "var.project"

  allow {
    protocol = "tcp,icmp"
    ports    = ["22", "6443"]
  }

  source_ranges = ["0.0.0.0/0"]
}