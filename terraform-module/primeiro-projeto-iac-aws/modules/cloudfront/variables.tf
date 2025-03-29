variable "origin_id" {
  description = "The ID of the origin (S3 bucket) for the CloudFront distribution."
  type        = string
}

variable "bucket_domain_name" {
  description = "The domain name of the S3 bucket."
  type        = string
}

variable "cdn_price_class" {
  description = "The price class for the CloudFront distribution."
  type        = string
  default     = "PriceClass_200"
}

variable "cdn_tags" {
  description = "Tags to be applied to the CloudFront distribution."
  type        = map(string)
  default     = {}
}