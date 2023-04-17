resource "google_monitoring_alert_policy" "uptime-check" {
  project      = var.project_id
  display_name = "Uptime Check"
  enabled      = true 
  combiner     = "OR"

  notification_channels = google_monitoring_notification_channel.email.*.name


  conditions {
    display_name = "Uptime Check https://${var.app_name}-${var.environment}.${var.google_domain_name} - Check Failed"
    condition_threshold {
      filter     = "resource.type = \"uptime_url\" AND metric.type = \"monitoring.googleapis.com/uptime_check/check_passed\" AND metric.labels.check_id = \"${module.uptime_check.uptime_check_id}\""
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