
locals {
  network = "kubernetes-the-hard-way-${element(split("-", var.subnet), 0)}"
}

resource "google_compute_instance" "compute_kubernetes_control_plane" {
  count           = 3
  name            = "controller-${count.index}"
  zone            = "us-west1-a"
  machine_type    = "n1-standard-1"
  can_ip_forward  = true
  
  tags = ["kubernetes-the-hard-way-dev", "controller"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = "200"
    }
  }

  network_interface {
    network = "${local.network}"
    network_ip = "10.240.0.1${count.index}"
    subnetwork = "${var.env}-subnet-01"
  }

  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}

resource "google_compute_instance" "compute_kubernetes_workers" {
  count           = 3
  name            = "worker-${count.index}"
  zone            = "us-west1-a"
  machine_type    = "n1-standard-1"
  can_ip_forward  = true
  
  tags = ["kubernetes-the-hard-way-dev", "worker"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = "200"
    }
  }

  network_interface {
    network = "${local.network}"
    network_ip = "10.240.0.2${count.index}"
    subnetwork = "${var.env}-subnet-01"
  }

  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  metadata = {
    pod-cidr = "10.240.0.2${count.index}"
  }  
}
