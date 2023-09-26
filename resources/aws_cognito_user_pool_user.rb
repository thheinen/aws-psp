# Import API specifics
use "awscc_base"

resource_name :aws_cognito_user_pool_user
provides :aws_cognito_user_pool_user, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Cognito::UserPoolUser
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :client_metadata, Hash,
         callbacks: {
           "client_metadata is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :desired_delivery_mediums, Array,
         callbacks: {
           "desired_delivery_mediums is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :force_alias_creation, [TrueClass, FalseClass],
         callbacks: {
           "force_alias_creation is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :message_action, String,
         callbacks: {
           "message_action is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :user_attributes, Array,
         callbacks: {
           "user_attributes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :user_pool_id, String,
         required: true,
         callbacks: {
           "user_pool_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :username, String,
         callbacks: {
           "username is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :validation_data, Array,
         callbacks: {
           "validation_data is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Cognito::UserPoolUser"
rest_api_document "/AWS::Cognito::UserPoolUser"

rest_property_map({
  client_metadata:          "ClientMetadata",
  desired_delivery_mediums: "DesiredDeliveryMediums",
  force_alias_creation:     "ForceAliasCreation",
  message_action:           "MessageAction",
  user_attributes:          "UserAttributes",
  user_pool_id:             "UserPoolId",
  username:                 "Username",
  validation_data:          "ValidationData",
})

rest_post_only_properties %i{
  client_metadata desired_delivery_mediums force_alias_creation message_action user_attributes user_pool_id username validation_data
}
