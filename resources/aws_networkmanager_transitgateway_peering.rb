# Import API specifics
use "awscc_base"

resource_name :aws_networkmanager_transitgateway_peering
provides :aws_networkmanager_transitgateway_peering, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::NetworkManager::TransitGatewayPeering Resoruce Type.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :core_network_id, String,
         required: true,
         callbacks: {
           "core_network_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Id of the core network that you want to peer a transit gateway to.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :transitgateway_arn, String,
         required: true,
         callbacks: {
           "transitgateway_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN (Amazon Resource Name) of the transit gateway that you will peer to a core network
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::TransitGatewayPeering"
rest_api_document "/AWS::NetworkManager::TransitGatewayPeering"

rest_property_map({
  core_network_id:    "CoreNetworkId",
  tags:               "Tags",
  transitgateway_arn: "TransitGatewayArn",
})

rest_post_only_properties %i{
  core_network_id transitgateway_arn
}
