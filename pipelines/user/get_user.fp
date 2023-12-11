pipeline "get_user" {
  title       = "Get User"
  description = "Show details for an Entra ID user."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "user_id" {
    type        = string
    description = "The object ID or principal name of the user for which to get information."
  }

  step "container" "get_user" {
    image = "my-azure-image"
    cmd   = ["ad", "user", "show", "--id", param.user_id]

    env = credential.azure[param.cred].env
  }

  output "user" {
    description = "User details."
    value       = jsondecode(step.container.get_user.stdout)
  }
}
