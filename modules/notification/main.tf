resource "google_monitoring_notification_channel" "email" {
  count        = "${length(var.email)}"
  project      = var.project_id
  enabled      = true
  display_name = "Send email to ${element(var.email, count.index)}"
  type         = "email"
  labels = {
    email_address = "${element(var.email, count.index)}"
  }
  force_delete = false
}
