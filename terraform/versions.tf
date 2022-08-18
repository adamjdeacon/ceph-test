terraform {
  required_version = "~> 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.72"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 3.72"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 3.6"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20"
    }
    # This is a bit rubbish, the terraform-google-sql postgresql module is forcing us to stay at v2.
    random = {
      source  = "hashicorp/random"
      version = "~> 2.0"
    }
  }
}
