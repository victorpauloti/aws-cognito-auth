resource "aws_cognito_user_pool" "cognito_user_pool" {
  name = "QuickSightUsers_v2"
  auto_verified_attributes = [
    "email"
  ]

}

resource "aws_cognito_user_pool_client" "userpool_client" {
  name                                 = "client"
  user_pool_id                         = aws_cognito_user_pool.cognito_user_pool.id
  callback_urls                        = ["https://example.com"]
  logout_urls                          = ["https://example.com"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["implicit"] #"code",
  allowed_oauth_scopes                 = ["openid"]   #"email",
  supported_identity_providers         = ["COGNITO"]
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "vpaulodomain"
  user_pool_id = aws_cognito_user_pool.cognito_user_pool.id
}

resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = "cognito-vpaulo"
  allow_unauthenticated_identities = false
  allow_classic_flow               = false

#   cognito_identity_providers {
#     client_id = "153ig1eq466a7eabuts1m3j0h2"
#     provider_name = aws_cognito_user_pool.cognito_user_pool.name
#   }
}


# resource "aws_cognito_user_pool_ui_customization" "example" {
#   client_id = aws_cognito_user_pool.cognito_user_pool.id

#   css        = ".label-customizable {font-weight: 400;}"
#   image_file = filebase64("logo.png")

#   # Refer to the aws_cognito_user_pool_domain resource's
#   # user_pool_id attribute to ensure it is in an 'Active' state
#   user_pool_id = aws_cognito_user_pool_domain.example.user_pool_id
# }
