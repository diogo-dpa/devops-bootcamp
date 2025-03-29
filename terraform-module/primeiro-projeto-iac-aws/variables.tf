variable "state_bucket" {
  type        = string
  default     = "rocketseat-state-bucket-tf-diogo"
  description = "The name of the S3 bucket to store the Terraform state file"
}
