# Import API specifics
use "awscc_base"

resource_name :aws_work_spaces_web_identity_provider
provides :aws_work_spaces_web_identity_provider, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::WorkSpacesWeb::IdentityProvider Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :identity_provider_details, Hash,
         required: true,
         callbacks: {
           "identity_provider_details is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :identity_provider_name, String,
         required: true,
         callbacks: {
           "identity_provider_name is not a String" => lambda { |v| v.is_a? String },
           "identity_provider_name needs to be 1..32 characters" => lambda { |v| v.length >= 1 && v.length <= 32 },
           "identity_provider_name must match pattern ^[^_][\p{L}\p{M}\p{S}\p{N}\p{P}][^_]+$" => lambda { |v| v =~ Regexp.new("/^[^_][\p{L}\p{M}\p{S}\p{N}\p{P}][^_]+$/") },
         },
         description: ""

property :identity_provider_type, Hash,
         required: true,
         callbacks: {
           "identity_provider_type is not a String" => lambda { |v| v.is_a? String },
           "identity_provider_typeis not one of `SAML`, `Facebook`, `Google`, `LoginWithAmazon`, `SignInWithApple`, `OIDC`" => lambda { |v| %w{SAML Facebook Google LoginWithAmazon SignInWithApple OIDC}.include? v },
         },
         description: ""

property :portal_arn, String,
         callbacks: {
           "portal_arn is not a String" => lambda { |v| v.is_a? String },
           "portal_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "portal_arn must match pattern ^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$" => lambda { |v| v =~ Regexp.new("/^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WorkSpacesWeb::IdentityProvider"
rest_api_document "/AWS::WorkSpacesWeb::IdentityProvider"

rest_property_map({
  identity_provider_details: "IdentityProviderDetails",
  identity_provider_name:    "IdentityProviderName",
  identity_provider_type:    "IdentityProviderType",
  portal_arn:                "PortalArn",
})

rest_post_only_properties %i{
  portal_arn
}
