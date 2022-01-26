resource "aws_s3_bucket_object" "object" {
  for_each     = fileset("html/", "*")
  bucket       = aws_s3_bucket.bucket.id
  key          = each.value
  source       = "html/${each.value}"
  etag         = filemd5("html/${each.value}")
  content_type = "text/html"
}
