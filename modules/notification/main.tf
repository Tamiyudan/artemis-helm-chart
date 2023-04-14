resource "google_monitoring_notification_channel" "email" {
  display_name = "Send email to ${var.email}"
  project      = var.project_id
  type         = "email"
  enabled      = true
  labels = {
    email_address = var.email
  }
  force_delete = false
}
