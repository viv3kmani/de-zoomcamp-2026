terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  credentials = "./keys/my-creds.json"
  project     = var.project_id
  region      = var.region
}


resource "google_storage_bucket" "demo-bucket" {
  name          = "${var.project_id}-bucket"
  location      = var.location
  force_destroy = true

  # lifecycle_rule {
  #     action {
  #         type = "Delete"
  #     }
  #     condition {
  #         age = 3
  #     }
  # }
  lifecycle_rule {
    action {
      type = "AbortIncompleteMultipartUpload"
    }
    condition {
      age = 1
    }
  }
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                 = var.bq_dataset_name
  description                = "Demo BigQuery dataset"
  delete_contents_on_destroy = true
}