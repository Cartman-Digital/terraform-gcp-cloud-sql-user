# Terraform GCP Cloud SQL users setup

Module creates users for Cloud SQL instance, add permissions and exports users to GCP Secret Manager.

Only PSQL is supported.

## Usage

```hcl
module "database_users" {
  source = "git::ssh://git@github.com/AckeeCZ/terraform-gcp-cloud-sql-user.git"
  users = {
    "ackee.fella" : {
      permissions : ["DELETE", "SELECT", "INSERT", "REFERENCES", "TRIGGER", "TRUNCATE", "UPDATE"]
      seq_permissions : ["USAGE", "UPDATE", "SELECT"]
      seq_objects : [
        "audits_id_seq",
        "countries_id_seq",
        "discounts_id_seq",
        "ga_callbacks_id_seq",
        "invoices_id_seq",
        "languages_id_seq",
        "merchants_id_seq",
        "mf_callbacks_id_seq",
        "shops_id_seq"
      ]
    }
    "reader-sa" : {
      permissions : ["SELECT"]
      create_sa : true
    }
    "mr.unicorn@ackee.cz" : {
      permissions : ["SELECT"]
      type : "CLOUD_IAM_USER"
    }
  }
  database               = local.postgres_database_name
  postgres_instance_name = local.instance_name
  project                = var.project
}
```

See `example` folder for more details.

## Users variable

Users variable is a map of users. Each user has following attributes:

 * `permissions` - list of permissions for objects
 * `seq_permissions` - list of permissions for sequences
 * `seq_objects` - list of sequences objects
 * `create_sa` - create service account for user
 * `type` - type of user, default is `BUILT_IN`, other is `CLOUD_IAM_USER`
 * `special` - use special characters for the password
 * `override_special` - override special characters for the password
 * `role` - role for the user, default is the key in the `users` map

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_postgresql"></a> [postgresql](#provider\_postgresql) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.assign_cloudsql_client](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.test](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.test_cloudsql_client](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_secret_manager_secret.database_credentials](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.database_credentials](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_service_account.sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.sa_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [google_sql_user.user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [postgresql_default_privileges.permissions](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/default_privileges) | resource |
| [postgresql_default_privileges.seq_permissions](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/default_privileges) | resource |
| [postgresql_grant.permissions](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_grant.seq_permissions](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database"></a> [database](#input\_database) | Database name used for permission setup | `string` | n/a | yes |
| <a name="input_expose_password"></a> [expose\_password](#input\_expose\_password) | Expose password to Terraform output | `bool` | `false` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | If set, default privileges will be set for users | `string` | `""` | no |
| <a name="input_postgres_instance_name"></a> [postgres\_instance\_name](#input\_postgres\_instance\_name) | Cloud SQL instance name | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project ID | `string` | n/a | yes |
| <a name="input_save_credentials"></a> [save\_credentials](#input\_save\_credentials) | Save credentials to GCP Secret Manager | `bool` | `true` | no |
| <a name="input_users"></a> [users](#input\_users) | Map of users and their attributes, key is the user login | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_passwords"></a> [passwords](#output\_passwords) | Passwords generated |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
