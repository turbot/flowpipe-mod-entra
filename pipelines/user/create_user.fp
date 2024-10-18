pipeline "create_user" {
  title       = "Create User"
  description = "Create an Entra ID user."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.azure
    description = local.conn_param_description
    default     = connection.azure.default
  }

  param "user_principal_name" {
    type        = string
    description = "The user principal name (someuser@contoso.com). It must contain one of the verified domains for the tenant."
  }

  param "display_name" {
    type        = string
    description = "Object's display name or its prefix."
  }

  param "password" {
    type        = string
    description = "The password that should be assigned to the user for authentication."
  }

  step "container" "create_user" {
    image = "ghcr.io/turbot/flowpipe-image-azure-cli"
    cmd   = ["ad", "user", "create", "--user-principal-name", param.user_principal_name, "--display-name", param.display_name, "--password", param.password]

    env = param.conn.env
  }

  output "user" {
    description = "Information about the created user."
    value       = jsondecode(step.container.create_user.stdout)
  }
}
