variable "region" {
  type        = string
  description = "Region of AWS VPC"
}

variable "shared_credentials_file" {
  type        = string
  description = "File with Secret Key and Access Key to AWS VPC"
}

variable "key_name" {
  type        = map(any)
  description = "The key used to access instances"
}

variable "ami" {
  type        = map(any)
  description = "ami value matching AWS region"
}

variable "instance_type" {
  type        = map(any)
  description = "Instance type value matching AWS region"
}

variable "ports" {
  type        = list(number)
  description = "List of ports to be added to the security group ingress block"
}
