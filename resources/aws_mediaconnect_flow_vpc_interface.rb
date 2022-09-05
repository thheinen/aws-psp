# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_mediaconnect_flow_vpc_interface
provides :aws_mediaconnect_flow_vpc_interface, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaConnect::FlowVpcInterface
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :flow_arn, String,
         required: true,
         callbacks: {
           "flow_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN), a unique identifier for any AWS resource, of the flow.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Immutable and has to be a unique against other VpcInterfaces in this Flow.
         DESCRIPTION

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Role Arn MediaConnect can assumes to create ENIs in customer's account.
         DESCRIPTION

property :security_group_ids, Array,
         required: true,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Security Group IDs to be used on ENI.
         DESCRIPTION

property :subnet_id, String,
         required: true,
         callbacks: {
           "subnet_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Subnet must be in the AZ of the Flow
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaConnect::FlowVpcInterface"
rest_api_document "/AWS::MediaConnect::FlowVpcInterface"

rest_property_map({
  flow_arn:           "FlowArn",
  name:               "Name",
  role_arn:           "RoleArn",
  security_group_ids: "SecurityGroupIds",
  subnet_id:          "SubnetId",
})

rest_post_only_properties %i{
  flow_arn name
}
