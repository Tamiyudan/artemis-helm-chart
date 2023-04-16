variable "project_id" {}

variable "region" {}

variable "google_domain_name" {}

variable "environment" {}

variable "repository" {}

variable "app_version" {}

variable "app_port" {}

variable "registry_username" {
  default = "_json_key"
}

variable "email" {
  type    = list(string)
  default = []
  description = "List of email addresses."
}

