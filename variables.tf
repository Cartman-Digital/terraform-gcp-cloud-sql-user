variable "postgres_instance_name" {
  description = "Cloud SQL instance name"
  type        = string
}

variable "users" {
  description = "Map of users and their attributes, key is the user login"
  default     = {}
}

variable "owner" {
  description = "If set, default privileges will be set for users"
  type        = string
  default     = ""
}

variable "database" {
  description = "Database name used for permission setup"
  type        = string
}

variable "save_credentials" {
  description = "Save credentials to GCP Secret Manager"
  type        = bool
  default     = true
}
variable "expose_password" {
  description = "Expose password to Terraform output"
  default     = false
  type        = bool
}

variable "project" {
  description = "Project ID"
  type        = string
}
