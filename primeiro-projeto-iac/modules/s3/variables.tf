variable "s3_bucket_name" {
  type        = string
  description = "Bucket name"
}

variable "s3_tags" {
  description = "Tags to be applied to the S3."
  type        = map(string)
  default     = {}
}