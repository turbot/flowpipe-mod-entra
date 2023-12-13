pipeline "create_group" {
  title       = "Create Group"
  description = "Create a group in the directory."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "display_name" {
    type        = string
    description = "Object's display name or its prefix."
  }

  param "mail_nickname" {
    type        = string
    description = "Mail nickname."
  }

  step "container" "create_group" {
    image = "ghcr.io/turbot/flowpipe-image-azure-cli"
    cmd   = ["ad", "group", "create", "--display-name", param.display_name, "--mail-nickname", param.mail_nickname]

    env = credential.azure[param.cred].env
  }

  output "group" {
    description = "Information about the created group."
    value       = jsondecode(step.container.create_group.stdout)
  }
}
