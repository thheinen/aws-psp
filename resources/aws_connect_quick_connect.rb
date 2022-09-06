# Import API specifics
use "awscc_base"

resource_name :aws_connect_quick_connect
provides :aws_connect_quick_connect, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::QuickConnect
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..250 characters" => lambda { |v| v.length >= 1 && v.length <= 250 },
         },
         description: <<~'DESCRIPTION'
           The description of the quick connect.
         DESCRIPTION

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The identifier of the Amazon Connect instance.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
         },
         description: <<~'DESCRIPTION'
           The name of the quick connect.
         DESCRIPTION

property :quick_connect_config, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           Configuration settings for the quick connect.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more tags.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Connect::QuickConnect"
rest_api_document "/AWS::Connect::QuickConnect"

rest_property_map({
  description:          "Description",
  instance_arn:         "InstanceArn",
  name:                 "Name",
  quick_connect_config: "QuickConnectConfig",
  tags:                 "Tags",
})

