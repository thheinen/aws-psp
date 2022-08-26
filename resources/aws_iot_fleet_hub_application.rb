# Import API specifics
use "awscc_base"

resource_name :aws_iot_fleet_hub_application
provides :aws_iot_fleet_hub_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTFleetHub::Application
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_description, String,
         callbacks: {
           "application_description is not a String" => lambda { |v| v.is_a? String },
           "application_description needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "application_description must match pattern ^[ -~]*$" => lambda { |v| v =~ Regexp.new("/^[ -~]*$/") },
         },
         description: "Application Description, should be between 1 and 2048 characters."

property :application_name, String,
         required: true,
         callbacks: {
           "application_name is not a String" => lambda { |v| v.is_a? String },
           "application_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "application_name must match pattern ^[ -~]*$" => lambda { |v| v =~ Regexp.new("/^[ -~]*$/") },
         },
         description: "Application Name, should be between 1 and 256 characters."

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 1..1600 characters" => lambda { |v| v.length >= 1 && v.length <= 1600 },
           "role_arn must match pattern ^arn:[!-~]+$" => lambda { |v| v =~ Regexp.new("/^arn:[!-~]+$/") },
         },
         description: "The ARN of the role that the web application assumes when it interacts with AWS IoT Core. For more info on configuring this attribute, see https://docs.aws.amazon.com/iot/latest/apireference/API_iotfleethub_CreateApplication.html#API_iotfleethub_CreateApplication_RequestSyntax"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of key-value pairs that contain metadata for the application."

# API URLs and mappings
rest_api_collection "/AWS::IoTFleetHub::Application"
rest_api_document "/AWS::IoTFleetHub::Application"

rest_property_map({
  application_description: "ApplicationDescription",
  application_name:        "ApplicationName",
  role_arn:                "RoleArn",
  tags:                    "Tags",
})

