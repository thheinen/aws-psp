# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_evidently_project
provides :aws_evidently_project, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Evidently::Project
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :data_delivery, Hash,
         callbacks: {
           "Subproperty `LogGroup` is not a String" => lambda { |v| v[:LogGroup].is_a? String },
           "Subproperty `LogGroup` needs to be 1..512 characters" => lambda { |v| v[:LogGroup].length >= 1 && v[:LogGroup].length <= 512 },
           "Subproperty `LogGroup` must match pattern ^[-a-zA-Z0-9._/]+$" => lambda { |v| v[:LogGroup] =~ Regexp.new("/^[-a-zA-Z0-9._/]+$/") },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..160 characters" => lambda { |v| v.length >= 0 && v.length <= 160 },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
           "name must match pattern [-a-zA-Z0-9._]*" => lambda { |v| v =~ Regexp.new("/[-a-zA-Z0-9._]*/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Evidently::Project"
rest_api_document "/AWS::Evidently::Project"

rest_property_map({
  data_delivery: "DataDelivery",
  description:   "Description",
  name:          "Name",
  tags:          "Tags",
})

rest_post_only_properties %i{
  name
}
