resource "aws_cloudfront_distribution" "cloudfront" {
    enabled = true
    comment = "CloudFront distribution for ${var.bucket_domain_name}"

    origin {
        origin_id   = "${var.origin_id}"
        domain_name = "${var.bucket_domain_name}"

        custom_origin_config {
            http_port              = 80
            https_port             = 443
            origin_protocol_policy = "http-only"
            origin_ssl_protocols   = ["TLSv1"]
        }
    }

    default_cache_behavior {
        target_origin_id = "${var.origin_id}"
        allowed_methods = ["GET", "HEAD"]
        cached_methods  = ["GET", "HEAD"]

        forwarded_values {
            query_string = false
            cookies {
                forward = "all"
            }
        }

        min_ttl                = 0
        default_ttl            = 0
        max_ttl                = 0
        viewer_protocol_policy = "redirect-to-https"
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }
    price_class = "PriceClass_200"
}