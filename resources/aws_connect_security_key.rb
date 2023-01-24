# Import API specifics
use "awscc_base"

resource_name :aws_connect_security_key
provides :aws_connect_security_key, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::SecurityKey
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :instance_id, Hash,
         required: true,
         callbacks: {
           "instance_id is not a String" => lambda { |v| v.is_a? String },
           "instance_id needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "instance_id must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: ""

property :key, Hash,
         required: true,
         callbacks: {
           "key is not a String" => lambda { |v| v.is_a? String },
           "key needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Connect::SecurityKey"
rest_api_document "/AWS::Connect::SecurityKey"

rest_property_map({
  instance_id: "InstanceId",
  key:         "Key",
})

rest_post_only_properties %i{
  instance_id key
}
