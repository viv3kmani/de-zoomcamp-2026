
variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "de-zoomcamp-26-485316"
}


variable "bq_dataset_name" {
  description = "The name of the BigQuery dataset"
  type        = string
  default     = "demo_dataset"
}

variable "location" {
  description = "The location for GCP resources"
  type        = string
  default     = "US"

}


variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}