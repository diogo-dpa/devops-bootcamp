module "s3" {
  source         = "./modules/s3"
  s3_bucket_name = "diogo-bucket"
}

module "cloudfront" {
  source             = "./modules/cloudfront"
  origin_id          = module.s3.bucket_id # it reference the output from the s3 module
  bucket_domain_name = module.s3.bucket_domain_name
  depends_on         = [module.s3] # Ensure the S3 bucket is created before CloudFront
}