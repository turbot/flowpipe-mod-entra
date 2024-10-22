pipeline "get_user" {
  title       = "Get User"
  description = "Show details for an Entra ID user."

  param "conn" {
    type        = connection.azure
    description = local.conn_param_description
    default     = connection.azure.default
  }

  param "user_id" {
    type        = string
    description = "The object ID or principal name of the user for which to get information."
  }

  step "container" "get_user" {
    image = "ghcr.io/turbot/flowpipe-image-azure-cli"
    cmd   = ["ad", "user", "show", "--id", param.user_id]

    env = param.conn.env
  }

  output "user" {
    description = "User details."
    value       = jsondecode(step.container.get_user.stdout)
  }
}
