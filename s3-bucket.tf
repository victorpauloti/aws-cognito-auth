resource "aws_s3_bucket" "site" {
  bucket = "cognito-quicksight-validation"

  tags = {
    Name        = "site-cognito"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "bucket_site" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}


resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket_website_configuration.bucket_site.id
  policy = data.aws_iam_policy_document.allow_access_from.json
}


data "aws_iam_policy_document" "allow_access_from" {
  statement {
    sid = "PolicyForCloudFrontPrivateContent"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::cognito-quicksight-validation/*",
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cloudfront::730335411417:distribution/E1EYBMYZ3L9A90"]
    }


  }

}