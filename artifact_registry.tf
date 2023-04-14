resource "kubernetes_secret" "artifact-registry" {
  metadata {
    name      = "artifact-registry"
    namespace =  module.artemis-namespace.namespace
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.region}-docker.pkg.dev" = {
          "username" = var.registry_username
          "password" = module.service_accounts.key
          "email"    = module.service_accounts.service_account.email
          "auth"     = base64encode("${var.registry_username}:${module.service_accounts.key}")
        }
      }
    })
  }
}


module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 3.0"
  project_id    = var.project_id
  prefix        = ""
  generate_keys = true
  names = [
    "artemis-${var.environment}"
  ]
  project_roles = [
    "${var.project_id}=>roles/owner",
  ]
}
