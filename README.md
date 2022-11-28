# Terraform GCP Cloud SQL users setup

Module creates users for Cloud SQL instance, add permissions and exports users to Vault.

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
  vault_secret_path      = var.vault_secret_path
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
| google | n/a |
| postgresql | n/a |
| random | n/a |
| vault | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [google_project_iam_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) |
| [google_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) |
| [google_service_account_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) |
| [google_sql_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) |
| [postgresql_grant](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) |
| [random_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) |
| [vault_generic_secret](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| database | Database name used for permission setup | `string` | n/a | yes |
| expose\_password | Expose password to Terraform output | `bool` | `false` | no |
| postgres\_instance\_name | Cloud SQL instance name | `string` | n/a | yes |
| project | Project ID | `string` | n/a | yes |
| users | Map of users and their attributes, key is the user login | `map` | `{}` | no |
| vault\_secret\_path | Path to secret in local vault, used mainly to save the credentials instead of displaying them to the console | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| passwords | Passwords generated |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
