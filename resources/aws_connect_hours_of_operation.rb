# Import API specifics
use "awscc_base"

resource_name :aws_connect_hours_of_operation
provides :aws_connect_hours_of_operation, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::HoursOfOperation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :config, Array,
         required: true,
         callbacks: {
           "config is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Configuration information for the hours of operation: day, start time, and end time."

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..250 characters" => lambda { |v| v.length >= 1 && v.length <= 250 },
         },
         description: "The description of the hours of operation."

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: "The identifier of the Amazon Connect instance."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
         },
         description: "The name of the hours of operation."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "One or more tags."

property :time_zone, String,
         required: true,
         callbacks: {
           "time_zone is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The time zone of the hours of operation."

# API URLs and mappings
rest_api_collection "/AWS::Connect::HoursOfOperation"
rest_api_document "/AWS::Connect::HoursOfOperation"

rest_property_map({
  config:       "Config",
  description:  "Description",
  instance_arn: "InstanceArn",
  name:         "Name",
  tags:         "Tags",
  time_zone:    "TimeZone",
})

