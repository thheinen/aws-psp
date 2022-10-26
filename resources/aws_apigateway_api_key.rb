# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_api_key
provides :aws_apigateway_api_key, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::ApiKey
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :customer_id, String,
         callbacks: {
           "customer_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           An AWS Marketplace customer identifier to use when integrating with the AWS SaaS Marketplace.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description of the purpose of the API key.
         DESCRIPTION

property :enabled, [TrueClass, FalseClass],
         callbacks: {
           "enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the API key can be used by clients.
         DESCRIPTION

property :generate_distinct_id, [TrueClass, FalseClass],
         callbacks: {
           "generate_distinct_id is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether the key identifier is distinct from the created API key value. This parameter is deprecated and should not be used.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A name for the API key. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the API key name.
         DESCRIPTION

property :stage_keys, Array,
         callbacks: {
           "stage_keys is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of stages to associate with this API key.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of arbitrary tags (key-value pairs) to associate with the API key.
         DESCRIPTION

property :value, String,
         callbacks: {
           "value is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The value of the API key. Must be at least 20 characters long.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::ApiKey"
rest_api_document "/AWS::ApiGateway::ApiKey"

rest_property_map({
  customer_id:          "CustomerId",
  description:          "Description",
  enabled:              "Enabled",
  generate_distinct_id: "GenerateDistinctId",
  name:                 "Name",
  stage_keys:           "StageKeys",
  tags:                 "Tags",
  value:                "Value",
})

rest_post_only_properties %i{
  generate_distinct_id name value
}
