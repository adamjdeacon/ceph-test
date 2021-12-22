terraform {
  backend "gcs" {
    bucket      = "ceph-terraform-state"
    prefix      = "state"
    credentials = "keys/sa.json"
  }
}

provider "google" {
  credentials = file("./keys/sa.json")
  project     = "ceph-test-335910"
  region      = "europe-west2"
  zone        = "europe-west2-c"
}

