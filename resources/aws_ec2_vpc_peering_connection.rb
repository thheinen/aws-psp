# Import API specifics
use "awscc_base"

resource_name :aws_ec2_vpc_peering_connection
provides :aws_ec2_vpc_peering_connection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::VPCPeeringConnection
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :peer_owner_id, String,
         callbacks: {
           "peer_owner_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The AWS account ID of the owner of the accepter VPC.
         DESCRIPTION

property :peer_region, String,
         callbacks: {
           "peer_region is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Region code for the accepter VPC, if the accepter VPC is located in a Region other than the Region in which you make the request.
         DESCRIPTION

property :peer_role_arn, String,
         callbacks: {
           "peer_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the VPC peer role for the peering connection in another AWS account.
         DESCRIPTION

property :peer_vpc_id, String,
         required: true,
         callbacks: {
           "peer_vpc_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the VPC with which you are creating the VPC peering connection. You must specify this parameter in the request.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the VPC.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::VPCPeeringConnection"
rest_api_document "/AWS::EC2::VPCPeeringConnection"

rest_property_map({
  peer_owner_id: "PeerOwnerId",
  peer_region:   "PeerRegion",
  peer_role_arn: "PeerRoleArn",
  peer_vpc_id:   "PeerVpcId",
  tags:          "Tags",
  vpc_id:        "VpcId",
})

rest_post_only_properties %i{
  peer_owner_id peer_region peer_role_arn peer_vpc_id vpc_id
}
