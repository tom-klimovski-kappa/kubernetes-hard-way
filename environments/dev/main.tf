
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

resource "google_compute_address" "internal_with_subnet_and_address" {
  name         = "kubernetes-the-hard-way-${local.env}"
  region       = "us-west1"
}

module "compute" {
  source        = "../../modules/compute"
  project       = "${var.project}"
  env           = "${local.env}"
  subnet        = "${module.vpc.subnet}"
}