
terraform {
  backend "gcs" {
    bucket = "kubernetes-hard-way-262920-tfstate"
    prefix = "env/dev"
  }
}
