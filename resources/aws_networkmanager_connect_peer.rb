# Import API specifics
use "awscc_base"

resource_name :aws_networkmanager_connect_peer
provides :aws_networkmanager_connect_peer, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::NetworkManager::ConnectPeer Resource Type Definition.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bgp_options, Hash,
         callbacks: {
           "Subproperty `PeerAsn` is not a Number" => lambda { |v| v[:PeerAsn].is_a? Number },
         },
         description: "Bgp options for connect peer."

property :connect_attachment_id, String,
         callbacks: {
           "connect_attachment_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the attachment to connect."

property :core_network_address, String,
         callbacks: {
           "core_network_address is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The IP address of a core network."

property :inside_cidr_blocks, Array,
         callbacks: {
           "inside_cidr_blocks is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The inside IP addresses used for a Connect peer configuration."

property :peer_address, String,
         callbacks: {
           "peer_address is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The IP address of the Connect peer."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::ConnectPeer"
rest_api_document "/AWS::NetworkManager::ConnectPeer"

rest_property_map({
  bgp_options:           "BgpOptions",
  connect_attachment_id: "ConnectAttachmentId",
  core_network_address:  "CoreNetworkAddress",
  inside_cidr_blocks:    "InsideCidrBlocks",
  peer_address:          "PeerAddress",
  tags:                  "Tags",
})

rest_post_only_properties %i{
  bgp_options connect_attachment_id core_network_address inside_cidr_blocks peer_address
}
