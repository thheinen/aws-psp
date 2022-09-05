# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ec2_transitgateway
provides :aws_ec2_transitgateway, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::TransitGateway
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :amazon_side_asn, Integer,
         callbacks: {
           "amazon_side_asn is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :association_default_route_table_id, String,
         callbacks: {
           "association_default_route_table_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :auto_accept_shared_attachments, String,
         callbacks: {
           "auto_accept_shared_attachments is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :default_route_table_association, String,
         callbacks: {
           "default_route_table_association is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :default_route_table_propagation, String,
         callbacks: {
           "default_route_table_propagation is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :dns_support, String,
         callbacks: {
           "dns_support is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :multicast_support, String,
         callbacks: {
           "multicast_support is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :propagation_default_route_table_id, String,
         callbacks: {
           "propagation_default_route_table_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :transitgateway_cidr_blocks, Array,
         callbacks: {
           "transitgateway_cidr_blocks is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :vpn_ecmp_support, String,
         callbacks: {
           "vpn_ecmp_support is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::TransitGateway"
rest_api_document "/AWS::EC2::TransitGateway"

rest_property_map({
  amazon_side_asn:                    "AmazonSideAsn",
  association_default_route_table_id: "AssociationDefaultRouteTableId",
  auto_accept_shared_attachments:     "AutoAcceptSharedAttachments",
  default_route_table_association:    "DefaultRouteTableAssociation",
  default_route_table_propagation:    "DefaultRouteTablePropagation",
  description:                        "Description",
  dns_support:                        "DnsSupport",
  multicast_support:                  "MulticastSupport",
  propagation_default_route_table_id: "PropagationDefaultRouteTableId",
  tags:                               "Tags",
  transitgateway_cidr_blocks:         "TransitGatewayCidrBlocks",
  vpn_ecmp_support:                   "VpnEcmpSupport",
})

rest_post_only_properties %i{
  amazon_side_asn multicast_support
}
