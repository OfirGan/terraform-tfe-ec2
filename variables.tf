##################################################################################
# Terraform Cloud
##################################################################################

variable "tfe_oauth_token_id" {
  description = "Terraform Cloud VCS Token ID"
  type        = string
  sensitive   = true
}


##################################################################################
# VPC Workspace Environment Variables
##################################################################################

variable "aws_acess_key_id" {
  description = "AWS Acess Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_acess_key" {
  description = "AWS Secret Acess Key"
  type        = string
  sensitive   = true
}

variable "aws_default_region" {
  description = "AWS Default Region"
  type        = string
}


##################################################################################
# VPC Workspace Variables
##################################################################################

variable "aws_ec2_key_pair_name" {
  type = string
}

variable "instance_count" {
  description = "Web & DB servers Pairs Count"
  type        = number
}

variable "instance_type" {
  type = string
}

variable "s3_logs_bucket_name" {
  type = string
}

variable "s3_logs_folder" {
  type = string
}

variable "owner_tag" {
  type = string
}

variable "purpose_tag" {
  type = string
}
