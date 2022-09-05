# Import API specifics
use "awscc_base"

resource_name :aws_connect_task_template
provides :aws_connect_task_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::TaskTemplate.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :client_token, Hash,
         callbacks: {
           "client_token is not a String" => lambda { |v| v.is_a? String },
           "client_token must match pattern ^[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12}$/") },
         },
         description: ""

property :constraints, Hash,
         description: <<~'DESCRIPTION'
           The constraints for the task template
         DESCRIPTION

property :contact_flow_arn, String,
         callbacks: {
           "contact_flow_arn is not a String" => lambda { |v| v.is_a? String },
           "contact_flow_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/contact-flow/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/contact-flow/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The identifier of the contact flow.
         DESCRIPTION

property :defaults, Array,
         callbacks: {
           "defaults is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'

         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..255 characters" => lambda { |v| v.length >= 0 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The description of the task template.
         DESCRIPTION

property :fields, Array,
         callbacks: {
           "fields is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of task template's fields
         DESCRIPTION

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The identifier (arn) of the instance.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
         },
         description: <<~'DESCRIPTION'
           The name of the task template.
         DESCRIPTION

property :status, Hash,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ACTIVE`, `INACTIVE`" => lambda { |v| %w{ACTIVE INACTIVE}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more tags.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Connect::TaskTemplate"
rest_api_document "/AWS::Connect::TaskTemplate"

rest_property_map({
  client_token:     "ClientToken",
  constraints:      "Constraints",
  contact_flow_arn: "ContactFlowArn",
  defaults:         "Defaults",
  description:      "Description",
  fields:           "Fields",
  instance_arn:     "InstanceArn",
  name:             "Name",
  status:           "Status",
  tags:             "Tags",
})

