# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_networkmanager_site
provides :aws_networkmanager_site, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::NetworkManager::Site type describes a site.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the site.
         DESCRIPTION

property :global_network_id, String,
         required: true,
         callbacks: {
           "global_network_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the global network.
         DESCRIPTION

property :location, Hash,
         callbacks: {
           "Subproperty `Address` is not a String" => lambda { |v| v[:Address].is_a? String },
           "Subproperty `Latitude` is not a String" => lambda { |v| v[:Latitude].is_a? String },
           "Subproperty `Longitude` is not a String" => lambda { |v| v[:Longitude].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The location of the site.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags for the site.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::Site"
rest_api_document "/AWS::NetworkManager::Site"

rest_property_map({
  description:       "Description",
  global_network_id: "GlobalNetworkId",
  location:          "Location",
  tags:              "Tags",
})

rest_post_only_properties %i{
  global_network_id
}
