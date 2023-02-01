# Import API specifics
use "awscc_base"

resource_name :aws_ec2_ipam_resource_discovery_association
provides :aws_ec2_ipam_resource_discovery_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema of AWS::EC2::IPAMResourceDiscoveryAssociation Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :ipam_id, String,
         required: true,
         callbacks: {
           "ipam_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Id of the IPAM this Resource Discovery is associated to.
         DESCRIPTION

property :ipam_resource_discovery_id, String,
         required: true,
         callbacks: {
           "ipam_resource_discovery_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the IPAM Resource Discovery Association.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::IPAMResourceDiscoveryAssociation"
rest_api_document "/AWS::EC2::IPAMResourceDiscoveryAssociation"

rest_property_map({
  ipam_id:                    "IpamId",
  ipam_resource_discovery_id: "IpamResourceDiscoveryId",
  tags:                       "Tags",
})

rest_post_only_properties %i{
  ipam_id ipam_resource_discovery_id
}
