# Import API specifics
use "awscc_base"

resource_name :aws_connect_prompt
provides :aws_connect_prompt, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::Prompt
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
           The description of the prompt.
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
           The name of the prompt.
         DESCRIPTION

property :s3_uri, String,
         callbacks: {
           "s3_uri is not a String" => lambda { |v| v.is_a? String },
           "s3_uri needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "s3_uri must match pattern s3://\S+/.+" => lambda { |v| v =~ Regexp.new("/s3://\S+/.+/") },
         },
         description: <<~'DESCRIPTION'
           S3 URI of the customer's audio file for creating prompts resource..
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Connect::Prompt"
rest_api_document "/AWS::Connect::Prompt"

rest_property_map({
  description:  "Description",
  instance_arn: "InstanceArn",
  name:         "Name",
  s3_uri:       "S3Uri",
  tags:         "Tags",
})

