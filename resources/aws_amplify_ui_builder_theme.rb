# Import API specifics
use "awscc_base"

resource_name :aws_amplify_ui_builder_theme
provides :aws_amplify_ui_builder_theme, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::AmplifyUIBuilder::Theme Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: ""

property :overrides, Array,
         callbacks: {
           "overrides is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :values, Array,
         required: true,
         callbacks: {
           "values is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AmplifyUIBuilder::Theme"
rest_api_document "/AWS::AmplifyUIBuilder::Theme"

rest_property_map({
  name:      "Name",
  overrides: "Overrides",
  tags:      "Tags",
  values:    "Values",
})

rest_post_only_properties %i{
  tags
}
