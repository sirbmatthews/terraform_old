variable "region" {
  type        = string
  description = "The region for AWS VPC"
}

variable "shared_credentials_file" {
  type        = string
  description = "The authentication file used to access AWS resources"
}

variable "root_domain" {
  type        = string
  description = "The root domain name for a website"
}

variable "blog_bucket_subdomain" {
  type        = string
  description = "The subdomain of the website"
}
