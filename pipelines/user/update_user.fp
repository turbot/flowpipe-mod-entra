pipeline "update_user" {
  title       = "Update User"
  description = "Update Entra ID user."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "user_id" {
    type        = string
    description = "The object ID or principal name of the user for which to get information."
  }

  param "account_enabled" {
    type        = string
    description = "Enable the user account. Accepted values are true, false."
    optional    = true
  }

  param "display_name" {
    type        = string
    description = "Object's display name or its prefix."
    optional    = true
  }

  step "container" "update_user" {
    image = "ghcr.io/turbot/flowpipe-image-azure-cli"
    cmd = concat(
      ["ad", "user", "update", "--id", param.user_id],
      param.display_name != null ? ["--display-name", param.display_name] : [],
      param.account_enabled != null ? ["--account-enabled", param.account_enabled] : [],
    )

    env = credential.azure[param.cred].env
  }

  output "user" {
    description = "Updated user details."
    value       = jsondecode(step.container.update_user.stdout)
  }
}
