variable "region" {
  type        = string
  description = "The region for AWS VPC"
}

variable "shared_credential_file" {
  type        = string
  description = "The authentication file used to access AWS resources"
}

variable "ports" {
  type        = list(number)
  description = "The list of ports for ingress rules"
}

variable "ami" {
  type        = map(any)
  description = "The Amazon Machine Image for the selected EC2 instance type"
}

variable "instance_type" {
  type        = map(any)
  description = "The EC2 instance type to be used for the selected region"
}

variable "key_name" {
  type        = map(any)
  description = "The authentication key name that allows SSH connection into an EC2 instance"
}

variable "key_name_path" {
  type        = map(any)
  description = "The authentication key name that allows SSH connection into an EC2 instance"
}
