# Import API specifics
use "awscc_base"

resource_name :aws_networkmanager_global_network
provides :aws_networkmanager_global_network, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::NetworkManager::GlobalNetwork type specifies a global network of the user's account
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The description of the global network."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The tags for the global network."

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::GlobalNetwork"
rest_api_document "/AWS::NetworkManager::GlobalNetwork"

rest_property_map({
  description: "Description",
  tags:        "Tags",
})

