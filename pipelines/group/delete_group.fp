pipeline "delete_group" {
  title       = "Delete Group"
  description = "Delete a group from the directory."

  param "conn" {
    type        = connection.azure
    description = local.conn_param_description
    default     = connection.azure.default
  }

  param "group" {
    type        = string
    description = "Group's object id or display name (prefix also works if there is a unique match)."
  }

  step "container" "delete_group" {
    image = "ghcr.io/turbot/flowpipe-image-azure-cli"
    cmd   = ["ad", "group", "delete", "--group", param.group]

    env = param.conn.env
  }
}
