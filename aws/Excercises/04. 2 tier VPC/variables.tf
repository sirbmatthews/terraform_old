variable "region" {
  type        = string
  description = "The region for AWS VPC"
}

variable "shared_credentials_file" {
  type        = string
  description = "The authentication file used to access AWS resources"
}

variable "cidr_block" {
  type        = string
  description = "The Classless Inter-Domain Routing for the VPC"
}
