output "bucket_domain_name" {
  value       = data.aws_s3_bucket.bucket.bucket_domain_name # this value comes from the aws_s3_bucket resource, from the ./main.tf file
  sensitive   = false
  description = "The domain name of the bucket"
}

output "bucket_id" {
  value       = data.aws_s3_bucket.bucket.id # same as above
  sensitive   = false
  description = "The ID of the bucket"
}

