pipeline "delete_group" {
  title       = "Delete Group"
  description = "Delete a group from the directory."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "group" {
    type        = string
    description = "Group's object id or display name (prefix also works if there is a unique match)."
  }

  step "container" "delete_group" {
    image = "my-azure-image"
    cmd   = ["ad", "group", "delete", "--group", param.group]

    env = credential.azure[param.cred].env
  }
}
