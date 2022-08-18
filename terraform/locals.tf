locals {
  is_production = terraform.workspace == "production"
  slug          = "playground"
  short_workspace = lookup(
    {
      development = "devel"
      staging     = "test"
      production  = "prod"
    },
    terraform.workspace,
    substr(terraform.workspace, 0, 4)
  )
  display_name    = "Playground"
  project         = module.project.project_id
  region          = "europe-west2"
  zone            = "europe-west2-c"
  product_folder  = "folders/774389258180"
  billing_account = "019DE3-7487E9-30C7D0"

  additional_services = [
    "iam.googleapis.com",
    "run.googleapis.com",
    "sqladmin.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "dns.googleapis.com",
    "secretmanager.googleapis.com",
    "compute.googleapis.com",
    "artifactregistry.googleapis.com"
  ]

  default_image           = "centos-cloud/centos-stream-9"
  compute_service_account = "${module.project.project_number}-compute@developer.gserviceaccount.com"
  node_count              = 3
  #  sql_instance = {
  #    db_name         = "webapp"
  #    user_name       = "admin"
  #    production_tier = "db-f1-micro"
  #  }
  #
  #  source_image_tag = "latest"
}
