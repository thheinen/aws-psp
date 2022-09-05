# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_networkmanager_link_association
provides :aws_networkmanager_link_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::NetworkManager::LinkAssociation type associates a link to a device. The device and link must be in the same global network and the same site.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :device_id, String,
         required: true,
         callbacks: {
           "device_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the device
         DESCRIPTION

property :global_network_id, String,
         required: true,
         callbacks: {
           "global_network_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the global network.
         DESCRIPTION

property :link_id, String,
         required: true,
         callbacks: {
           "link_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the link
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::LinkAssociation"
rest_api_document "/AWS::NetworkManager::LinkAssociation"

rest_property_map({
  device_id:         "DeviceId",
  global_network_id: "GlobalNetworkId",
  link_id:           "LinkId",
})

rest_post_only_properties %i{
  device_id global_network_id link_id
}
