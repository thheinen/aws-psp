# Import API specifics
use "awscc_base"

resource_name :aws_ram_permission
provides :aws_ram_permission, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource type definition for AWS::RAM::Permission
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the permission.
         DESCRIPTION

property :policy_template, Hash,
         required: true,
         callbacks: {
           "policy_template is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Policy template for the permission.
         DESCRIPTION

property :resource_type, String,
         required: true,
         callbacks: {
           "resource_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The resource type this permission can be used with.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RAM::Permission"
rest_api_document "/AWS::RAM::Permission"

rest_property_map({
  name:            "Name",
  policy_template: "PolicyTemplate",
  resource_type:   "ResourceType",
  tags:            "Tags",
})

rest_post_only_properties %i{
  name policy_template resource_type
}
