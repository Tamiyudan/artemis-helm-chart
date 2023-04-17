module "uptime_check" {
  source             = "./modules/monitoring"
  app_name           = var.app_name
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  environment        = var.environment
  email              = var.email_list
  display_name       = "Uptime Check https://${var.app_name}-${var.environment}.${var.google_domain_name} - Check Failed"
}
