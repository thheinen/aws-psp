# Import API specifics
use "awscc_base"

resource_name :aws_cognito_identity_pool_principal_tag
provides :aws_cognito_identity_pool_principal_tag, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Cognito::IdentityPoolPrincipalTag
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :identity_pool_id, String,
         required: true,
         callbacks: {
           "identity_pool_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :identity_provider_name, String,
         required: true,
         callbacks: {
           "identity_provider_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :principal_tags, Hash,
         callbacks: {
           "principal_tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :use_defaults, [TrueClass, FalseClass],
         callbacks: {
           "use_defaults is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Cognito::IdentityPoolPrincipalTag"
rest_api_document "/AWS::Cognito::IdentityPoolPrincipalTag"

rest_property_map({
  identity_pool_id:       "IdentityPoolId",
  identity_provider_name: "IdentityProviderName",
  principal_tags:         "PrincipalTags",
  use_defaults:           "UseDefaults",
})

rest_post_only_properties %i{
  identity_pool_id identity_provider_name
}
