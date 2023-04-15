variable "email" {
    type = string

    validation {
    condition     = can(regex("^\\w+@[a-zA-Z_]+?\\.[a-zA-Z]{2,3}$", var.email))
    error_message = "ERROR: Not a valid email."
  }
}

variable "project_id" {}