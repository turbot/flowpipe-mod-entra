pipeline "delete_user" {
  title       = "Delete User"
  description = "Delete Entra ID user."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "user_id" {
    type        = string
    description = "The object ID or principal name of the user for which to get information."
  }

  step "container" "delete_user" {
    image = "ghcr.io/turbot/flowpipe-image-azure-cli"
    cmd   = ["ad", "user", "delete", "--id", param.user_id]

    env = credential.azure[param.cred].env
  }
}
