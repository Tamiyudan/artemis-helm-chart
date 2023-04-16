module "uptime_check" {
  source             = "./modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  environment        = var.environment
  email              = var.email
  display_name       = "Uptime Check https://artemis-${var.environment}.${var.google_domain_name} - Check Failed"
}


