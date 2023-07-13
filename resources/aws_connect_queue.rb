# Import API specifics
use "awscc_base"

resource_name :aws_connect_queue
provides :aws_connect_queue, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::Queue
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
           The description of the queue.
         DESCRIPTION

property :hours_of_operation_arn, String,
         required: true,
         callbacks: {
           "hours_of_operation_arn is not a String" => lambda { |v| v.is_a? String },
           "hours_of_operation_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/operating-hours/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/operating-hours/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The identifier for the hours of operation.
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

property :max_contacts, Integer,
         callbacks: {
           "max_contacts is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The maximum number of contacts that can be in the queue before it is considered full.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
         },
         description: <<~'DESCRIPTION'
           The name of the queue.
         DESCRIPTION

property :outbound_caller_config, Hash,
         description: <<~'DESCRIPTION'
           The outbound caller ID name, number, and outbound whisper flow.
         DESCRIPTION

property :quick_connect_arns, Array,
         callbacks: {
           "quick_connect_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The quick connects available to agents who are working the queue.
         DESCRIPTION

property :status, String,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v },
         },
         description: <<~'DESCRIPTION'
           The status of the queue.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Connect::Queue"
rest_api_document "/AWS::Connect::Queue"

rest_property_map({
  description:            "Description",
  hours_of_operation_arn: "HoursOfOperationArn",
  instance_arn:           "InstanceArn",
  max_contacts:           "MaxContacts",
  name:                   "Name",
  outbound_caller_config: "OutboundCallerConfig",
  quick_connect_arns:     "QuickConnectArns",
  status:                 "Status",
  tags:                   "Tags",
})

