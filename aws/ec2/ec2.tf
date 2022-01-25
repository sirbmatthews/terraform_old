provider "aws" {
  region                  = "af-south-1"
  shared_credentials_file = "%HOME%/.aws/credentials"
}

resource "aws_instance" "ec2" {
  ami           = "ami-0afe7f8bc76b877ea"
  instance_type = "t3.micro"
}
