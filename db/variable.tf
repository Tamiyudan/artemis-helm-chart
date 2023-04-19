variable "app_name" {}

variable "aenvironment" {}

variable "google_domain_name" {}

variable "db-password" {}

variable "region" {}

variable "db_tier_type" {
    default = "db-f1-micro"
}

variable "db_version" {
    default = "MYSQL_5_7"
}
