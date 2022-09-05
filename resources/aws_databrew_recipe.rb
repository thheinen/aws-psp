# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_databrew_recipe
provides :aws_databrew_recipe, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataBrew::Recipe.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..1024 characters" => lambda { |v| v.length >= 0 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           Description of the recipe
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           Recipe name
         DESCRIPTION

property :steps, Array,
         required: true,
         callbacks: {
           "steps is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::DataBrew::Recipe"
rest_api_document "/AWS::DataBrew::Recipe"

rest_property_map({
  description: "Description",
  name:        "Name",
  steps:       "Steps",
  tags:        "Tags",
})

rest_post_only_properties %i{
  name tags
}
