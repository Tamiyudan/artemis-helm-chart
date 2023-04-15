variable "project_id" {}

variable google_domain_name {}

variable "environment" {}

variable "repository" {}

variable "app_version" {}

variable "app_port" {}

variable "region" {}

variable "registry_username" {
  default = "_json_key"
}

variable "email" {
    type = string

    validation {
    condition     = can(regex("^\\w+@[a-zA-Z_]+?\\.[a-zA-Z]{2,3}$", var.email))
    error_message = "ERROR: Not a valid email."
  }
}