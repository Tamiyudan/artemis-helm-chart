resource "google_monitoring_notification_channel" "email" {
  count        = "${length(var.email_list)}"
  project      = var.project_id
  enabled      = true
  display_name = "Send email to ${element(var.email_list, count.index)}"
  type         = "email"
  labels = {
    email_address = "${element(var.email_list, count.index)}"
  }
  force_delete = false
}