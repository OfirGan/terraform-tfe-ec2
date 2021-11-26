##################################################################################
# Registry Module
##################################################################################

resource "tfe_registry_module" "ec2" {
  vcs_repo {
    display_identifier = "${var.vcs_organization_name}/${var.ec2_module_github_path}"
    identifier         = "${var.vcs_organization_name}/${var.ec2_module_github_path}"
    oauth_token_id     = var.tfe_oauth_token_id
  }
}


##################################################################################
# Workspace
##################################################################################

resource "tfe_workspace" "ec2_workspace" {
  name              = "ec2-workspace"
  organization      = data.tfe_organization.organization.name
  auto_apply        = "false"
  execution_mode    = "remote"
  working_directory = var.ec2_workspace_repo_directory

  vcs_repo {
    identifier     = "${var.vcs_organization_name}/${var.vcs_workspace_repo_name}"
    oauth_token_id = var.tfe_oauth_token_id
  }
}

##################################################################################
# Slack Notification
##################################################################################

resource "tfe_notification_configuration" "slac_notification" {
  name             = "Slac Notification"
  enabled          = true
  destination_type = "slack"
  triggers         = var.notification_triggers
  url              = var.slack_notification_webhook_url
  workspace_id     = resource.tfe_workspace.ec2_workspace.id
}


##################################################################################
# Workspace Environment Variables
##################################################################################

resource "tfe_variable" "aws_access_key_id" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.aws_acess_key_id
  category     = "env"
  sensitive    = "true"
  workspace_id = resource.tfe_workspace.ec2_workspace.id
  description  = "AWS Connection"
}

resource "tfe_variable" "aws_secret_acess_key" {
  key          = "AWS_SECRET_ACCESS_KEY "
  value        = var.aws_secret_acess_key
  category     = "env"
  sensitive    = "true"
  workspace_id = resource.tfe_workspace.ec2_workspace.id
  description  = "AWS Connection"
}

resource "tfe_variable" "aws_default_region" {
  key          = "AWS_DEFAULT_REGION"
  value        = var.aws_default_region
  description  = "AWS Default Region"
  workspace_id = tfe_workspace.ec2_workspace.id
  category     = "env"
}


##################################################################################
# Workspace Variables
##################################################################################

resource "tfe_variable" "aws_ec2_key_pair_name" {
  key          = "aws_ec2_key_pair_name"
  value        = var.aws_ec2_key_pair_name
  description  = "Web & DB aws public key name"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "instance_count" {
  key          = "instance_count"
  value        = var.instance_count
  description  = "Web & DB servers Pairs Count"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "instance_type" {
  key          = "instance_type"
  value        = var.instance_type
  description  = "Web & DB server Type"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "s3_logs_bucket_name" {
  key          = "s3_logs_bucket_name"
  value        = var.s3_logs_bucket_name
  description  = "S3 Logs Bucket Name"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "s3_logs_folder" {
  key          = "s3_logs_folder"
  value        = var.s3_logs_folder
  description  = "S3 Logs Folder"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "owner_tag" {
  key          = "owner_tag"
  value        = var.owner_tag
  description  = "Owner Name"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "purpose_tag" {
  key          = "purpose_tag"
  value        = var.purpose_tag
  description  = "Purpose Tag Name"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}
