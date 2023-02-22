# Import API specifics
use "awscc_base"

resource_name :aws_networkmanager_transitgateway_route_table_attachment
provides :aws_networkmanager_transitgateway_route_table_attachment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::NetworkManager::TransitGatewayRouteTableAttachment Resource Type definition.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :peering_id, String,
         required: true,
         callbacks: {
           "peering_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Id of peering between transit gateway and core network.
         DESCRIPTION

property :proposed_segment_change, Hash,
         callbacks: {
           "Subproperty `Tags` is not a Array" => lambda { |v| v[:Tags].is_a? Array },
           "Subproperty `AttachmentPolicyRuleNumber` is not a Integer" => lambda { |v| v[:AttachmentPolicyRuleNumber].is_a? Integer },
           "Subproperty `SegmentName` is not a String" => lambda { |v| v[:SegmentName].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The attachment to move from one segment to another.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :transitgateway_route_table_arn, String,
         required: true,
         callbacks: {
           "transitgateway_route_table_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Arn of transit gateway route table.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::TransitGatewayRouteTableAttachment"
rest_api_document "/AWS::NetworkManager::TransitGatewayRouteTableAttachment"

rest_property_map({
  peering_id:                     "PeeringId",
  proposed_segment_change:        "ProposedSegmentChange",
  tags:                           "Tags",
  transitgateway_route_table_arn: "TransitGatewayRouteTableArn",
})

rest_post_only_properties %i{
  peering_id transitgateway_route_table_arn
}
