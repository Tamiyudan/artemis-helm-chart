resource "google_monitoring_uptime_check_config" "https" {
  display_name = "https://artemis-${var.environment}.${var.google_domain_name}"
  timeout      = "60s"
  project      = var.project_id

  http_check {
    path         = "/"
    port         = "443"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = "artemis-${var.environment}.${var.google_domain_name}"
    }
  }

  content_matchers {
    content = "\"status\":\"UP\""
  }
}


resource "google_monitoring_notification_channel" "email" {
  project      = var.project_id
  enabled      = true
  display_name = "Send email to ${var.email}"
  type         = "email"
  labels = {
    email_address = "${var.email}"
  }
  force_delete = false
}


resource "google_monitoring_alert_policy" "uptime-check" {
  project      = "${var.project_id}"
  display_name = "Uptime Check"
  enabled      = true 
  combiner     = "OR"

  notification_channels = [
    "${google_monitoring_notification_channel.email.name}",
  ]

  conditions {
    display_name = "Uptime Health Check on https://artemis-${var.environment}.${var.google_domain_name}"
    condition_threshold {
      filter     = "resource.type = \"uptime_url\" AND metric.type = \"monitoring.googleapis.com/uptime_check/check_passed\" AND metric.labels.check_id = \"${google_monitoring_uptime_check_config.https.uptime_check_id}\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = "1"
      trigger {
          count = 1
      }
    }  
  }
}