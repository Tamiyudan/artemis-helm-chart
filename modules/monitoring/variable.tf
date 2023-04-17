variable "project_id" {}

variable "google_domain_name" {}

variable "environment" {}

variable "display_name" {}

variable "app_name" {}

variable "email" {
    type = list(string)
    default = []
}

