module  "artemis-namespace" {
    source = "./modules/terraform-k8s-namespace"
    name = "artemis-${var.environment}"
}

module "artemis-terraform-helm" {
    source = "./modules/terraform-helm"
    deployment_name = "artemis-${var.environment}"
    deployment_namespace = module.artemis-namespace.namespace
    deployment_path = "charts/artemis"
    values_yaml = <<EOF

replicaCount: 1

image:
  repository: "${var.repository}"
  tag: "${var.app_version}"

service:
  type: ClusterIP
  port: "${var.app_port}"

ingress:
  enabled: true
  
  annotations: 
    kubernetes.io/ingress.class: "nginx"
    ingress.kubernetes.io/ssl-redirect: "false"
    cert-manager.io/cluster-issuer: letsencrypt-prod
    acme.cert-manager.io/http01-edit-in-place: "true"
    
  hosts:
    - host: "artemis-${var.environment}.${var.google_domain_name}"
      paths:
        - path: /
          pathType: Prefix

  # tls: 
  #   - secretName: artemis-tls
  #     hosts:
  #       - "artemis-${var.environment}.${var.google_domain_name}"
EOF
}