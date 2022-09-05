# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_networkmanager_transitgateway_registration
provides :aws_networkmanager_transitgateway_registration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::NetworkManager::TransitGatewayRegistration type registers a transit gateway in your global network. The transit gateway can be in any AWS Region, but it must be owned by the same AWS account that owns the global network. You cannot register a transit gateway in more than one global network.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :global_network_id, String,
         required: true,
         callbacks: {
           "global_network_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the global network.
         DESCRIPTION

property :transitgateway_arn, String,
         required: true,
         callbacks: {
           "transitgateway_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the transit gateway.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::TransitGatewayRegistration"
rest_api_document "/AWS::NetworkManager::TransitGatewayRegistration"

rest_property_map({
  global_network_id:  "GlobalNetworkId",
  transitgateway_arn: "TransitGatewayArn",
})

rest_post_only_properties %i{
  global_network_id transitgateway_arn
}
