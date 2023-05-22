# Import API specifics
use "awscc_base"

resource_name :aws_networkmanager_site_to_site_vpn_attachment
provides :aws_networkmanager_site_to_site_vpn_attachment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::NetworkManager::SiteToSiteVpnAttachment Resource Type definition.
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
           The ID of a core network where you're creating a site-to-site VPN attachment.
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

property :vpn_connection_arn, String,
         required: true,
         callbacks: {
           "vpn_connection_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of the site-to-site VPN attachment.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::SiteToSiteVpnAttachment"
rest_api_document "/AWS::NetworkManager::SiteToSiteVpnAttachment"

rest_property_map({
  core_network_id:         "CoreNetworkId",
  proposed_segment_change: "ProposedSegmentChange",
  tags:                    "Tags",
  vpn_connection_arn:      "VpnConnectionArn",
})

rest_post_only_properties %i{
  core_network_id vpn_connection_arn
}
