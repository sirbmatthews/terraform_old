resource "aws_s3_bucket" "bucket" {
  bucket = "${var.blog_bucket_subdomain}.${var.root_domain}"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
