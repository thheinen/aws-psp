# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_cloudfront_function
provides :aws_cloudfront_function, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudFront::Function
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auto_publish, [TrueClass, FalseClass],
         callbacks: {
           "auto_publish is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :function_code, String,
         required: true,
         callbacks: {
           "function_code is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :function_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `Comment` is not a String" => lambda { |v| v[:Comment].is_a? String },
           "Subproperty `Runtime` is not a String" => lambda { |v| v[:Runtime].is_a? String },
         },
         description: ""

property :function_metadata, Hash,
         callbacks: {
           "Subproperty `FunctionARN` is not a String" => lambda { |v| v[:FunctionARN].is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudFront::Function"
rest_api_document "/AWS::CloudFront::Function"

rest_property_map({
  auto_publish:      "AutoPublish",
  function_code:     "FunctionCode",
  function_config:   "FunctionConfig",
  function_metadata: "FunctionMetadata",
  name:              "Name",
})

