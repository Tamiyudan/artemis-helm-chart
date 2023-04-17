resource "google_monitoring_uptime_check_config" "https" {
  display_name = "https://${var.app_name}-${var.environment}.${var.google_domain_name}"
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
      host       = "${var.app_name}-${var.environment}.${var.google_domain_name}"
    }
  }

  content_matchers {
    content = "\"status\":\"UP\""
  }
}

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

resource "google_monitoring_alert_policy" "uptime-check" {
  project      = var.project_id
  display_name = "Uptime Check"
  enabled      = true 
  combiner     = "OR"

  notification_channels = google_monitoring_notification_channel.email.*.name


  conditions {
    display_name = var.display_name
    condition_threshold {
      filter     = "resource.type = \"uptime_url\" AND metric.type = \"monitoring.googleapis.com/uptime_check/check_passed\" AND metric.labels.check_id = \"${google_monitoring_uptime_check_config.https.uptime_check_id}\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_NEXT_OLDER"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
      }
      threshold_value = "1"
      trigger {
          count = 1
      }
    }  
  }
}