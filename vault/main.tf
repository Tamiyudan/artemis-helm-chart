resource "vault_mount" "engine-mount" {
  path        = var.app_name
  type        = "kv-v2"
  description = "This will create KV Version 2 secret engine mount"
}

resource "vault_generic_secret" "secret" {
  path = "${vault_mount.engine-mount.path}/${var.secret_name}"
  data_json = jsonencode( 
    {
      domain_name = "${var.google_domain_name}"
      project_id = "${var.project_id}"
      service_account = "${jsonencode(var.service_account)}"
      sonar_token = "${var.sonar_token}"
    } 
  )
}
