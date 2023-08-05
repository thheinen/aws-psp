# Import API specifics
use "awscc_base"

resource_name :aws_vpc_lattice_service_network_vpc_association
provides :aws_vpc_lattice_service_network_vpc_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Associates a VPC with a service network.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :security_group_ids, Array,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :service_network_identifier, String,
         callbacks: {
           "service_network_identifier is not a String" => lambda { |v| v.is_a? String },
           "service_network_identifier needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "service_network_identifier must match pattern ^((sn-[0-9a-z]{17})|(arn:[a-z0-9\-]+:vpc-lattice:[a-zA-Z0-9\-]+:\d{12}:servicenetwork/sn-[0-9a-z]{17}))$" => lambda { |v| v =~ Regexp.new("/^((sn-[0-9a-z]{17})|(arn:[a-z0-9\-]+:vpc-lattice:[a-zA-Z0-9\-]+:\d{12}:servicenetwork/sn-[0-9a-z]{17}))$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :vpc_identifier, String,
         callbacks: {
           "vpc_identifier is not a String" => lambda { |v| v.is_a? String },
           "vpc_identifier needs to be 5..2048 characters" => lambda { |v| v.length >= 5 && v.length <= 2048 },
           "vpc_identifier must match pattern ^vpc-(([0-9a-z]{8})|([0-9a-z]{17}))$" => lambda { |v| v =~ Regexp.new("/^vpc-(([0-9a-z]{8})|([0-9a-z]{17}))$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VpcLattice::ServiceNetworkVpcAssociation"
rest_api_document "/AWS::VpcLattice::ServiceNetworkVpcAssociation"

rest_property_map({
  security_group_ids:         "SecurityGroupIds",
  service_network_identifier: "ServiceNetworkIdentifier",
  tags:                       "Tags",
  vpc_identifier:             "VpcIdentifier",
})

rest_post_only_properties %i{
  service_network_identifier vpc_identifier
}
