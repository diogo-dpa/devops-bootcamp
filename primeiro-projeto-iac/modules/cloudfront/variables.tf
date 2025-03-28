variable "origin_id" {
  description = "The ID of the origin (S3 bucket) for the CloudFront distribution."
  type        = string
}

variable "bucket_domain_name" {
  description = "The domain name of the S3 bucket."
  type        = string
}