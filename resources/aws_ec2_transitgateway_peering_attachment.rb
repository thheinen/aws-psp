# Import API specifics
use "awscc_base"

resource_name :aws_ec2_transitgateway_peering_attachment
provides :aws_ec2_transitgateway_peering_attachment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::EC2::TransitGatewayPeeringAttachment type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :peer_account_id, String,
         required: true,
         callbacks: {
           "peer_account_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the peer account
         DESCRIPTION

property :peer_region, String,
         required: true,
         callbacks: {
           "peer_region is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Peer Region
         DESCRIPTION

property :peer_transitgateway_id, String,
         required: true,
         callbacks: {
           "peer_transitgateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the peer transit gateway.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags for the transit gateway peering attachment.
         DESCRIPTION

property :transitgateway_id, String,
         required: true,
         callbacks: {
           "transitgateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the transit gateway.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::TransitGatewayPeeringAttachment"
rest_api_document "/AWS::EC2::TransitGatewayPeeringAttachment"

rest_property_map({
  peer_account_id:        "PeerAccountId",
  peer_region:            "PeerRegion",
  peer_transitgateway_id: "PeerTransitGatewayId",
  tags:                   "Tags",
  transitgateway_id:      "TransitGatewayId",
})

rest_post_only_properties %i{
  peer_account_id peer_region peer_transitgateway_id transitgateway_id
}
