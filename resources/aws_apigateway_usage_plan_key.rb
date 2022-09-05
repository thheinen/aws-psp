# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_apigateway_usage_plan_key
provides :aws_apigateway_usage_plan_key, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::UsagePlanKey
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :key_id, String,
         required: true,
         callbacks: {
           "key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the usage plan key.
         DESCRIPTION

property :key_type, String,
         required: true,
         callbacks: {
           "key_type is not a String" => lambda { |v| v.is_a? String },
           "key_typeis not one of `API_KEY`" => lambda { |v| %w{API_KEY}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of usage plan key. Currently, the only valid key type is API_KEY.
         DESCRIPTION

property :usage_plan_id, String,
         required: true,
         callbacks: {
           "usage_plan_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the usage plan.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::UsagePlanKey"
rest_api_document "/AWS::ApiGateway::UsagePlanKey"

rest_property_map({
  key_id:        "KeyId",
  key_type:      "KeyType",
  usage_plan_id: "UsagePlanId",
})

rest_post_only_properties %i{
  key_id key_type usage_plan_id
}
