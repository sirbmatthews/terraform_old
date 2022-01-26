output "s3_ip" {
  value = aws_s3_bucket.bucket.website_endpoint
}
