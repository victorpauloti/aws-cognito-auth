resource "aws_lambda_function" "sso_lambda" {

  filename      = "lambda_function_payload.zip"
  function_name    = "function_cognito_quicksight"
  role             = "arn:aws:iam::730335411417:role/lambda-cognito-role"
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "nodejs16.x"

}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "index.js"
  output_path = "lambda_function_payload.zip"
}

#permission trigger
# resource "aws_lambda_permission" "api_gw" {
#   statement_id  = "AllowExecutionFromAPIGateway"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.sso_lambda.function_name
#   principal     = "apigateway.amazonaws.com"

#   source_arn = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
# }