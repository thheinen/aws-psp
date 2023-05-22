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
         required: true,
         callbacks: {
           "core_network_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           ID of the CoreNetwork that the attachment will be attached to.
         DESCRIPTION

property :edge_location, String,
         required: true,
         callbacks: {
           "edge_location is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Edge location of the attachment.
         DESCRIPTION

property :options, Hash,
         required: true,
         callbacks: {
           "Subproperty `Protocol` is not a String" => lambda { |v| v[:Protocol].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Protocol options for connect attachment
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
           Tags for the attachment.
         DESCRIPTION

property :transport_attachment_id, String,
         required: true,
         callbacks: {
           "transport_attachment_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Id of transport attachment
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::ConnectAttachment"
rest_api_document "/AWS::NetworkManager::ConnectAttachment"

rest_property_map({
  core_network_id:         "CoreNetworkId",
  edge_location:           "EdgeLocation",
  options:                 "Options",
  proposed_segment_change: "ProposedSegmentChange",
  tags:                    "Tags",
  transport_attachment_id: "TransportAttachmentId",
})

rest_post_only_properties %i{
  core_network_id edge_location options transport_attachment_id
}
