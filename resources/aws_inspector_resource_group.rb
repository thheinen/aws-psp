# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_inspector_resource_group
provides :aws_inspector_resource_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Inspector::ResourceGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :resource_group_tags, Array,
         required: true,
         callbacks: {
           "resource_group_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Inspector::ResourceGroup"
rest_api_document "/AWS::Inspector::ResourceGroup"

rest_property_map({
  resource_group_tags: "ResourceGroupTags",
})

rest_post_only_properties %i{
  resource_group_tags
}
