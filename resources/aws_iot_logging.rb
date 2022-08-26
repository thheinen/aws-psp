# Import API specifics
use "awscc_base"

resource_name :aws_iot_logging
provides :aws_iot_logging, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Logging Options enable you to configure your IoT V2 logging role and default logging level so that you can monitor progress events logs as it passes from your devices through Iot core service.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :account_id, String,
         required: true,
         callbacks: {
           "account_id is not a String" => lambda { |v| v.is_a? String },
           "account_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
           "account_id must match pattern ^[0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9]{12}$/") },
         },
         description: "Your 12-digit account ID (used as the primary identifier for the CloudFormation resource)."

property :default_log_level, String,
         required: true,
         callbacks: {
           "default_log_level is not a String" => lambda { |v| v.is_a? String },
           "default_log_levelis not one of `ERROR`, `WARN`, `INFO`, `DEBUG`, `DISABLED`" => lambda { |v| %w{ERROR WARN INFO DEBUG DISABLED}.include? v },
         },
         description: "The log level to use. Valid values are: ERROR, WARN, INFO, DEBUG, or DISABLED."

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
         },
         description: "The ARN of the role that allows IoT to write to Cloudwatch logs."

# API URLs and mappings
rest_api_collection "/AWS::IoT::Logging"
rest_api_document "/AWS::IoT::Logging"

rest_property_map({
  account_id:        "AccountId",
  default_log_level: "DefaultLogLevel",
  role_arn:          "RoleArn",
})

rest_post_only_properties %i{
  account_id
}
