# Import API specifics
use "awscc_base"

resource_name :aws_iot_authorizer
provides :aws_iot_authorizer, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Creates an authorizer.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :authorizer_function_arn, String,
         required: true,
         callbacks: {
           "authorizer_function_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :authorizer_name, String,
         callbacks: {
           "authorizer_name is not a String" => lambda { |v| v.is_a? String },
           "authorizer_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "authorizer_name must match pattern [\w=,@-]+" => lambda { |v| v =~ Regexp.new("/[\w=,@-]+/") },
         },
         description: ""

property :enable_caching_for_http, [TrueClass, FalseClass],
         callbacks: {
           "enable_caching_for_http is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :signing_disabled, [TrueClass, FalseClass],
         callbacks: {
           "signing_disabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :status, String,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ACTIVE`, `INACTIVE`" => lambda { |v| %w{ACTIVE INACTIVE}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :token_key_name, String,
         callbacks: {
           "token_key_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :token_signing_public_keys, Hash,
         callbacks: {
           "token_signing_public_keys is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoT::Authorizer"
rest_api_document "/AWS::IoT::Authorizer"

rest_property_map({
  authorizer_function_arn:   "AuthorizerFunctionArn",
  authorizer_name:           "AuthorizerName",
  enable_caching_for_http:   "EnableCachingForHttp",
  signing_disabled:          "SigningDisabled",
  status:                    "Status",
  tags:                      "Tags",
  token_key_name:            "TokenKeyName",
  token_signing_public_keys: "TokenSigningPublicKeys",
})

rest_post_only_properties %i{
  authorizer_name signing_disabled
}
