resource "google_artifact_registry_repository" "artifact-repo" {
  location      = var.region
  repository_id = var.repository_id
  description   = "Docker Repository"
  format        = "DOCKER"
}