# Import API specifics
use "awscc_base"

resource_name :aws_networkmanager_connect_attachment
provides :aws_networkmanager_connect_attachment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::NetworkManager::ConnectAttachment Resource Type Definition
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :core_network_id, String,
         callbacks: {
           "core_network_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "ID of the CoreNetwork that the attachment will be attached to."

property :edge_location, String,
         callbacks: {
           "edge_location is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Edge location of the attachment."

property :options, Hash,
         callbacks: {
           "Subproperty `Protocol` is not a String" => lambda { |v| v[:Protocol].is_a? String },
         },
         description: "Protocol options for connect attachment"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Tags for the attachment."

property :transport_attachment_id, String,
         callbacks: {
           "transport_attachment_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Id of transport attachment"

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::ConnectAttachment"
rest_api_document "/AWS::NetworkManager::ConnectAttachment"

rest_property_map({
  core_network_id:         "CoreNetworkId",
  edge_location:           "EdgeLocation",
  options:                 "Options",
  tags:                    "Tags",
  transport_attachment_id: "TransportAttachmentId",
})

rest_post_only_properties %i{
  core_network_id edge_location options transport_attachment_id
}
