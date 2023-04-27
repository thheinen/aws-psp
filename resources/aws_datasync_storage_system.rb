# Import API specifics
use "awscc_base"

resource_name :aws_datasync_storage_system
provides :aws_datasync_storage_system, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::StorageSystem.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :agent_arns, Array,
         required: true,
         callbacks: {
           "agent_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ARN of the DataSync agent that connects to and reads from the on-premises storage system's management interface.
         DESCRIPTION

property :cloudwatch_log_group_arn, String,
         callbacks: {
           "cloudwatch_log_group_arn is not a String" => lambda { |v| v.is_a? String },
           "cloudwatch_log_group_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):logs:[a-z\-0-9]+:[0-9]{12}:log-group:([^:\*]*)(:\*)?$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):logs:[a-z\-0-9]+:[0-9]{12}:log-group:([^:\*]*)(:\*)?$/") },
         },
         description: <<~'DESCRIPTION'
           The ARN of the Amazon CloudWatch log group used to monitor and log discovery job events.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "name must match pattern ^[a-zA-Z0-9\s+=._:@/-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9\s+=._:@/-]+$/") },
         },
         description: <<~'DESCRIPTION'
           A familiar name for the on-premises storage system.
         DESCRIPTION

property :server_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `ServerHostname` is not a String" => lambda { |v| v[:ServerHostname].is_a? String },
           "Subproperty `ServerHostname` must match pattern ^(([a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9\-]*[A-Za-z0-9])$" => lambda { |v| v[:ServerHostname] =~ Regexp.new("/^(([a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9\-]*[A-Za-z0-9])$/") },
           "Subproperty `ServerPort` is not a Integer" => lambda { |v| v[:ServerPort].is_a? Integer },
         },
         description: ""

property :server_credentials, Hash,
         callbacks: {
           "Subproperty `Username` is not a String" => lambda { |v| v[:Username].is_a? String },
           "Subproperty `Password` is not a String" => lambda { |v| v[:Password].is_a? String },
         },
         description: ""

property :system_type, String,
         required: true,
         callbacks: {
           "system_type is not a String" => lambda { |v| v.is_a? String },
           "system_typeis not one of `NetAppONTAP`" => lambda { |v| %w{NetAppONTAP}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of on-premises storage system that DataSync Discovery will analyze.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DataSync::StorageSystem"
rest_api_document "/AWS::DataSync::StorageSystem"

rest_property_map({
  agent_arns:               "AgentArns",
  cloudwatch_log_group_arn: "CloudWatchLogGroupArn",
  name:                     "Name",
  server_configuration:     "ServerConfiguration",
  server_credentials:       "ServerCredentials",
  system_type:              "SystemType",
  tags:                     "Tags",
})

