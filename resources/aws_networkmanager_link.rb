# Import API specifics
use "awscc_base"

resource_name :aws_networkmanager_link
provides :aws_networkmanager_link, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::NetworkManager::Link type describes a link.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bandwidth, Hash,
         required: true,
         callbacks: {
           "Subproperty `DownloadSpeed` is not a Integer" => lambda { |v| v[:DownloadSpeed].is_a? Integer },
           "Subproperty `UploadSpeed` is not a Integer" => lambda { |v| v[:UploadSpeed].is_a? Integer },
         },
         description: "The Bandwidth for the link."

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The description of the link."

property :global_network_id, String,
         required: true,
         callbacks: {
           "global_network_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the global network."

property :provider, String,
         callbacks: {
           "provider is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The provider of the link."

property :site_id, String,
         required: true,
         callbacks: {
           "site_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the site"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The tags for the link."

property :type, String,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The type of the link."

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::Link"
rest_api_document "/AWS::NetworkManager::Link"

rest_property_map({
  bandwidth:         "Bandwidth",
  description:       "Description",
  global_network_id: "GlobalNetworkId",
  provider:          "Provider",
  site_id:           "SiteId",
  tags:              "Tags",
  type:              "Type",
})

rest_post_only_properties %i{
  global_network_id site_id
}
