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

variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "de-zoomcamp-26-485316"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

resource "google_storage_bucket" "demo-bucket" {
    name          = "${var.project_id}-bucket"
    location      = var.region
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