# Import API specifics
use "awscc_base"

resource_name :aws_lambda_event_invoke_config
provides :aws_lambda_event_invoke_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lambda::EventInvokeConfig
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :destination_config, Hash,
         description: ""

property :function_name, String,
         required: true,
         callbacks: {
           "function_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :maximum_event_age_in_seconds, Integer,
         callbacks: {
           "maximum_event_age_in_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :maximum_retry_attempts, Integer,
         callbacks: {
           "maximum_retry_attempts is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :qualifier, String,
         required: true,
         callbacks: {
           "qualifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Lambda::EventInvokeConfig"
rest_api_document "/AWS::Lambda::EventInvokeConfig"

rest_property_map({
  destination_config:           "DestinationConfig",
  function_name:                "FunctionName",
  maximum_event_age_in_seconds: "MaximumEventAgeInSeconds",
  maximum_retry_attempts:       "MaximumRetryAttempts",
  qualifier:                    "Qualifier",
})

rest_post_only_properties %i{
  function_name qualifier
}
