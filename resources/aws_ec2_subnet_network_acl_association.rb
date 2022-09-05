# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ec2_subnet_network_acl_association
provides :aws_ec2_subnet_network_acl_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::SubnetNetworkAclAssociation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :network_acl_id, String,
         required: true,
         callbacks: {
           "network_acl_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the network ACL
         DESCRIPTION

property :subnet_id, String,
         required: true,
         callbacks: {
           "subnet_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the subnet
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::SubnetNetworkAclAssociation"
rest_api_document "/AWS::EC2::SubnetNetworkAclAssociation"

rest_property_map({
  network_acl_id: "NetworkAclId",
  subnet_id:      "SubnetId",
})

rest_post_only_properties %i{
  network_acl_id subnet_id
}
