resource "helm_release" "helm_deployment" {
  name      = var.deployment_name
  namespace = var.deployment_namespace
  chart     = var.deployment_path
  force_update = true
  wait = false
  recreate_pods = true
  max_history   = 1


  values = [
    var.values_yaml
  ]
}