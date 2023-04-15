module "uptime_check" {
  source             = "./modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  environment        = var.environment
}

module "notification" {
  source             = "./modules/notification"
  email              = var.email
  project_id         = var.project_id
}