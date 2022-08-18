provider "google" {
  region = local.region
  alias  = "product_admin"
}

provider "google-beta" {
  region = local.region
  alias  = "product_admin"
}

provider "google" {
  project     = local.project
  region      = local.region
  zone        = local.zone
  credentials = module.project.owner_service_account_credentials
}

provider "google-beta" {
  project     = local.project
  region      = local.region
  zone        = local.zone
  credentials = module.project.owner_service_account_credentials
}

