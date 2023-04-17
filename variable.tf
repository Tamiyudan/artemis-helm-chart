variable "project_id" {}

variable "region" {}

variable "google_domain_name" {}

variable "environment" {}

variable "app_name" {}

variable "repository" {}

variable "app_version" {}

variable "app_port" {}

variable "registry_username" {
  default = "_json_key"
}

variable "email" {
    type = list
    default = []
}
