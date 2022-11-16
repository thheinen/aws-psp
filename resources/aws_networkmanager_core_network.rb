# Import API specifics
use "awscc_base"

resource_name :aws_networkmanager_core_network
provides :aws_networkmanager_core_network, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::NetworkManager::CoreNetwork Resource Type Definition.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of core network
         DESCRIPTION

property :global_network_id, String,
         required: true,
         callbacks: {
           "global_network_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the global network that your core network is a part of.
         DESCRIPTION

property :policy_document, Hash,
         callbacks: {
           "policy_document is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Live policy document for the core network, you must provide PolicyDocument in Json Format
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags for the global network.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::CoreNetwork"
rest_api_document "/AWS::NetworkManager::CoreNetwork"

rest_property_map({
  description:       "Description",
  global_network_id: "GlobalNetworkId",
  policy_document:   "PolicyDocument",
  tags:              "Tags",
})

rest_post_only_properties %i{
  global_network_id
}
