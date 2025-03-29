terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.27.0"
    }
  }
}

provider "google" {
  # Configuration options
  project     = "my-project-id"
  region      = "us-central1"
  zone        = "us-central1-a"
}