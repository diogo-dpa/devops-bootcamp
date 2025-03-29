output "s3_bucket_name" {
  value       = modules.s3.bucket_domain_name
  sensitive   = true
  description = "The name of the S3 bucket"
}

output "cdn_domain {
  value       = modules.cloudfront.cdn_domain_name
  sensitive   = true
  description = "The domain name of the CloudFront distribution"
}

