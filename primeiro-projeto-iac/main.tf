module "s3" {
  source         = "./modules/s3"
  s3_bucket_name = "diogo-bucket"
  s3_tags = {
    Iac = true
  }
}

module "cloudfront" {
  source             = "./modules/cloudfront"
  origin_id          = module.s3.bucket_id # it reference the output from the s3 module
  bucket_domain_name = module.s3.bucket_domain_name
  cdn_price_class    = "PriceClass_200"
  cdn_tags = {
    Iac = true
  }
  depends_on = [module.s3] # Ensure the S3 bucket is created before CloudFront
}

module "sqs" {
  source = "terraform-aws-modules/sqs/aws"

  name = "rocketseat-sqs"

  create_dlq = true

  tags = {
    Iac = true
  }
}