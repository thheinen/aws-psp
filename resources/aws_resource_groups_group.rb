# Import API specifics
use "awscc_base"

resource_name :aws_resource_groups_group
provides :aws_resource_groups_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for ResourceGroups::Group
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :configuration, Hash,
         callbacks: {
           "configuration is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the resource group
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the resource group
         DESCRIPTION

property :resource_query, Hash,
         callbacks: {
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `TAG_FILTERS_1_0`, `CLOUDFORMATION_STACK_1_0`" => lambda { |v| %w{TAG_FILTERS_1_0 CLOUDFORMATION_STACK_1_0}.include? v[:Type] },
         },
         description: ""

property :resources, Array,
         callbacks: {
           "resources is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ResourceGroups::Group"
rest_api_document "/AWS::ResourceGroups::Group"

rest_property_map({
  configuration:  "Configuration",
  description:    "Description",
  name:           "Name",
  resource_query: "ResourceQuery",
  resources:      "Resources",
  tags:           "Tags",
})

rest_post_only_properties %i{
  name
}
