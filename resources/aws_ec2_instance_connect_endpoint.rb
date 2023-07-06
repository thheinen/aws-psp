# Import API specifics
use "awscc_base"

resource_name :aws_ec2_instance_connect_endpoint
provides :aws_ec2_instance_connect_endpoint, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::InstanceConnectEndpoint
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :client_token, String,
         callbacks: {
           "client_token is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The client token of the instance connect endpoint.
         DESCRIPTION

property :preserve_client_ip, [TrueClass, FalseClass],
         callbacks: {
           "preserve_client_ip is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           If true, the address of the loki client is preserved when connecting to the end resource
         DESCRIPTION

property :security_group_ids, Array,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The security group IDs of the instance connect endpoint.
         DESCRIPTION

property :subnet_id, String,
         required: true,
         callbacks: {
           "subnet_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The subnet id of the instance connect endpoint
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags of the instance connect endpoint.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::InstanceConnectEndpoint"
rest_api_document "/AWS::EC2::InstanceConnectEndpoint"

rest_property_map({
  client_token:       "ClientToken",
  preserve_client_ip: "PreserveClientIp",
  security_group_ids: "SecurityGroupIds",
  subnet_id:          "SubnetId",
  tags:               "Tags",
})

rest_post_only_properties %i{
  client_token preserve_client_ip security_group_ids subnet_id
}
