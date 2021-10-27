variable "postgres_instance_name" {}

variable "users" {
  default = {}
}

variable "database" {}

variable "vault_secret_path" {}

variable "expose_password" {
  default = false
}