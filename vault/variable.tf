variable "google_domain_name" {}

variable "app_name" {}

variable "secret_name" {}

variable "project_id" {}

variable "service_account" {
  type        = map(any)
}

variable "sonar_token" {}
