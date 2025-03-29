# The datasource will work only if the distribution is already created
# The ideal is to create the distribution and then use the datasource to get the distribution id
data "aws_cloudfront_distribution" "cloudfront" {
    id = "${aws_cloudfront_distribution.cloudfront.id}" # it can know this info by the terraform state or by the documentation
}