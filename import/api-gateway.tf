resource "aws_api_gateway_rest_api" "api_cognito" {
  #id   = "n1cwv9h369"
  name = "QuickSight"
}

resource "aws_api_gateway_resource" "api_cognito_resource" {
  #id = "n1cwv9h369/m1qstirvlb"
  rest_api_id = aws_api_gateway_rest_api.api_cognito.id
  parent_id   = ""
  path_part = ""
  #path = "/"
}

resource "aws_api_gateway_authorizer" "authorizer" {
    #id = "n1cwv9h369/0xfeay"
    name          = "QuickSight"
    type          = "COGNITO_USER_POOLS"
    rest_api_id = aws_api_gateway_rest_api.api_cognito.id
    provider_arns = ["arn:aws:cognito-idp:us-east-1:730335411417:userpool/us-east-1_jU7LCp46y"]
}

resource "aws_api_gateway_method" "api_method" {
    #id = "n1cwv9h369/m1qstirvlb/POST"
  rest_api_id   = aws_api_gateway_rest_api.api_cognito.id
  resource_id   = aws_api_gateway_resource.api_cognito_resource.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.authorizer.id
}

resource "aws_api_gateway_integration" "integration" {
    #id = "n1cwv9h369/m1qstirvlb/POST"
  rest_api_id   = aws_api_gateway_rest_api.api_cognito.id
  resource_id   = aws_api_gateway_resource.api_cognito_resource.id
  http_method          = aws_api_gateway_method.api_method.http_method
  integration_http_method = "POST"
  type                 = "AWS_PROXY"
  content_handling = "CONVERT_TO_TEXT"
  uri = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:730335411417:function:cognito-quicksight-QuickSightFederationFunction-fg57kdMspB5b/invocations"

  }