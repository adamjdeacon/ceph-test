#provider "google" {
#  credentials = file("./keys/sa.json")
#  project     = "hallowed-zoo-359715"
#  region      = "europe-west2"
#  zone        = "europe-west2-c"
#}

module "project" {
  providers = {
    google      = google.product_admin
    google-beta = google-beta.product_admin
  }

  source              = "git::https://gitlab.developers.cam.ac.uk/uis/devops/infra/terraform/gcp-project.git?ref=v2.4.0"
  project_name        = "${local.display_name} - ${terraform.workspace}"
  project_id          = random_id.project_name.hex
  region              = local.region
  folder_id           = local.product_folder
  billing_account     = local.billing_account
  additional_services = local.additional_services
}

resource "random_id" "configuration_bucket_name" {
  byte_length = 4
  prefix      = "${local.slug}-config-${terraform.workspace}-"
}

# tfsec:ignore:google-storage-enable-ubla
resource "google_storage_bucket" "configuration" {
  name     = random_id.configuration_bucket_name.hex
  location = local.region

  versioning {
    enabled = true
  }
}

resource "random_id" "project_name" {
  byte_length = 4
  prefix      = "${local.slug}-${local.short_workspace}-"
}

