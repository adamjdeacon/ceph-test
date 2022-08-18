terraform {
  backend "gcs" {
    bucket      = "ajd-meta-state"
    prefix      = "state"
  }
}
