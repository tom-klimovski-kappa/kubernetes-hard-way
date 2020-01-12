
locals {
  "env" = "dev"
}

provider "google" {
  project = "${var.project}"
}

module "vpc" {
  source  = "../../modules/vpc"
  project = "${var.project}"
  env     = "${local.env}"
}

module "firewall" {
  source  = "../../modules/firewall"
  project = "${var.project}"
  subnet  = "${module.vpc.subnet}"
}

module "compute" {
  source        = "../../modules/compute"
  project       = "${var.project}"
  env           = "${local.env}"
  subnet        = "${module.vpc.subnet}"
}

resource "google_compute_instance" "local_exec_create" {
  provisioner "local-exec" {
    when    = "create"
    command = "../../certs/create-certs-keys.sh"
  }  
}

# resource "null_resource" "example1" {
#   provisioner "local-exec" {
#     command = "open WFH, '>completed.txt' and print WFH scalar localtime"
#     interpreter = ["perl", "-e"]
#   }
# }

# resource "google_compute_instance" "local_exec_destroy" {
#   provisioner "local-exec" {
#     when    = "destroy"
#     command = "../../certs/delete-certs-keys.sh"
#   }
# }
