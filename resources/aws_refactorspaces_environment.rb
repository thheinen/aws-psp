# Import API specifics
use "awscc_base"

resource_name :aws_refactorspaces_environment
provides :aws_refactorspaces_environment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::RefactorSpaces::Environment Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "description must match pattern ^[a-zA-Z0-9-_\s\.\!\*\#\@\']+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-_\s\.\!\*\#\@\']+$/") },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..63 characters" => lambda { |v| v.length >= 3 && v.length <= 63 },
           "name must match pattern ^(?!env-)[a-zA-Z0-9]+[a-zA-Z0-9-_ ]+$" => lambda { |v| v =~ Regexp.new("/^(?!env-)[a-zA-Z0-9]+[a-zA-Z0-9-_ ]+$/") },
         },
         description: ""

property :network_fabric_type, Hash,
         callbacks: {
           "network_fabric_type is not a String" => lambda { |v| v.is_a? String },
           "network_fabric_typeis not one of `TRANSIT_GATEWAY`, `NONE`" => lambda { |v| %w{TRANSIT_GATEWAY NONE}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Metadata that you can assign to help organize the frameworks that you create. Each tag is a key-value pair.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::RefactorSpaces::Environment"
rest_api_document "/AWS::RefactorSpaces::Environment"

rest_property_map({
  description:         "Description",
  name:                "Name",
  network_fabric_type: "NetworkFabricType",
  tags:                "Tags",
})

rest_post_only_properties %i{
  description name network_fabric_type
}
