resource "google_sql_database_instance" "project-db" {
  name                = "${var.app_name}-${var.environment}-db"
  database_version    = var.db_version
  region              = var.region
  deletion_protection = false

  settings {
    tier = var.db_tier_type
  }
}

resource "google_sql_user" "users" {
  name     = "${var.app_name}-db"
  instance = google_sql_database_instance.project-db.name
  host     = "db.${var.google_domain_name}"
  password = var.db_password
}