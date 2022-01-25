provider "aws" {
  region                  = "af-south-1"
  shared_credentials_file = "%HOME%/.aws/credentials"
}

resource "aws_iam_user" "user" {
  name  = "user.${count.index}"
  count = 2
  path  = "/system"
}

output "arns" {
  value = aws_iam_user.user[*].arn
}
