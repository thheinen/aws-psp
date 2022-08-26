# Import API specifics
use "awscc_base"

resource_name :aws_databrew_project
provides :aws_databrew_project, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataBrew::Project.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :dataset_name, String,
         required: true,
         callbacks: {
           "dataset_name is not a String" => lambda { |v| v.is_a? String },
           "dataset_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: "Dataset name"

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: "Project name"

property :recipe_name, String,
         required: true,
         callbacks: {
           "recipe_name is not a String" => lambda { |v| v.is_a? String },
           "recipe_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: "Recipe name"

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Role arn"

property :sample, Hash,
         callbacks: {
           "Subproperty `Size` is not a Integer" => lambda { |v| v[:Size].is_a? Integer },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `FIRST_N`, `LAST_N`, `RANDOM`" => lambda { |v| %w{FIRST_N LAST_N RANDOM}.include? v[:Type] },
         },
         description: "Sample"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::DataBrew::Project"
rest_api_document "/AWS::DataBrew::Project"

rest_property_map({
  dataset_name: "DatasetName",
  name:         "Name",
  recipe_name:  "RecipeName",
  role_arn:     "RoleArn",
  sample:       "Sample",
  tags:         "Tags",
})

rest_post_only_properties %i{
  name tags
}
