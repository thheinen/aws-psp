# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_connect_contact_flow_module
provides :aws_connect_contact_flow_module, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::ContactFlowModule.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :content, String,
         required: true,
         callbacks: {
           "content is not a String" => lambda { |v| v.is_a? String },
           "content needs to be 1..256000 characters" => lambda { |v| v.length >= 1 && v.length <= 256000 },
         },
         description: <<~'DESCRIPTION'
           The content of the contact flow module in JSON format.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern .*\S.*" => lambda { |v| v =~ Regexp.new("/.*\S.*/") },
         },
         description: <<~'DESCRIPTION'
           The description of the contact flow module.
         DESCRIPTION

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "instance_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The identifier of the Amazon Connect instance (ARN).
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
           "name must match pattern .*\S.*" => lambda { |v| v =~ Regexp.new("/.*\S.*/") },
         },
         description: <<~'DESCRIPTION'
           The name of the contact flow module.
         DESCRIPTION

property :state, String,
         callbacks: {
           "state is not a String" => lambda { |v| v.is_a? String },
           "stateis not one of `ACTIVE`, `ARCHIVED`" => lambda { |v| %w{ACTIVE ARCHIVED}.include? v },
         },
         description: <<~'DESCRIPTION'
           The state of the contact flow module.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more tags.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Connect::ContactFlowModule"
rest_api_document "/AWS::Connect::ContactFlowModule"

rest_property_map({
  content:      "Content",
  description:  "Description",
  instance_arn: "InstanceArn",
  name:         "Name",
  state:        "State",
  tags:         "Tags",
})

