# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_databrew_dataset
provides :aws_databrew_dataset, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataBrew::Dataset.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :format, String,
         callbacks: {
           "format is not a String" => lambda { |v| v.is_a? String },
           "formatis not one of `CSV`, `JSON`, `PARQUET`, `EXCEL`, `ORC`" => lambda { |v| %w{CSV JSON PARQUET EXCEL ORC}.include? v },
         },
         description: <<~'DESCRIPTION'
           Dataset format
         DESCRIPTION

property :format_options, Hash,
         description: <<~'DESCRIPTION'
           Format options for dataset
         DESCRIPTION

property :input, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           Input
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           Dataset name
         DESCRIPTION

property :path_options, Hash,
         callbacks: {
           "Subproperty `Parameters` is not a Array" => lambda { |v| v[:Parameters].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           PathOptions
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::DataBrew::Dataset"
rest_api_document "/AWS::DataBrew::Dataset"

rest_property_map({
  format:         "Format",
  format_options: "FormatOptions",
  input:          "Input",
  name:           "Name",
  path_options:   "PathOptions",
  tags:           "Tags",
})

rest_post_only_properties %i{
  name tags
}
