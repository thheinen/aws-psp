# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_datasync_agent
provides :aws_datasync_agent, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::Agent.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :activation_key, String,
         required: true,
         callbacks: {
           "activation_key is not a String" => lambda { |v| v.is_a? String },
           "activation_key must match pattern [A-Z0-9]{5}(-[A-Z0-9]{5}){4}" => lambda { |v| v =~ Regexp.new("/[A-Z0-9]{5}(-[A-Z0-9]{5}){4}/") },
         },
         description: <<~'DESCRIPTION'
           Activation key of the Agent.
         DESCRIPTION

property :agent_name, String,
         callbacks: {
           "agent_name is not a String" => lambda { |v| v.is_a? String },
           "agent_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "agent_name must match pattern ^[a-zA-Z0-9\s+=._:@/-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9\s+=._:@/-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name configured for the agent. Text reference used to identify the agent in the console.
         DESCRIPTION

property :security_group_arns, Array,
         callbacks: {
           "security_group_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ARNs of the security group used to protect your data transfer task subnets.
         DESCRIPTION

property :subnet_arns, Array,
         callbacks: {
           "subnet_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ARNs of the subnets in which DataSync will create elastic network interfaces for each data transfer task.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :vpc_endpoint_id, String,
         callbacks: {
           "vpc_endpoint_id is not a String" => lambda { |v| v.is_a? String },
           "vpc_endpoint_id must match pattern ^vpce-[0-9a-f]{17}$" => lambda { |v| v =~ Regexp.new("/^vpce-[0-9a-f]{17}$/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the VPC endpoint that the agent has access to.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DataSync::Agent"
rest_api_document "/AWS::DataSync::Agent"

rest_property_map({
  activation_key:      "ActivationKey",
  agent_name:          "AgentName",
  security_group_arns: "SecurityGroupArns",
  subnet_arns:         "SubnetArns",
  tags:                "Tags",
  vpc_endpoint_id:     "VpcEndpointId",
})

rest_post_only_properties %i{
  activation_key security_group_arns subnet_arns vpc_endpoint_id
}
