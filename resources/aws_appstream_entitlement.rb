# Import API specifics
use "awscc_base"

resource_name :aws_appstream_entitlement
provides :aws_appstream_entitlement, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppStream::Entitlement
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :app_visibility, String,
         required: true,
         callbacks: {
           "app_visibility is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :attributes, Array,
         required: true,
         callbacks: {
           "attributes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :stack_name, String,
         required: true,
         callbacks: {
           "stack_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AppStream::Entitlement"
rest_api_document "/AWS::AppStream::Entitlement"

rest_property_map({
  app_visibility: "AppVisibility",
  attributes:     "Attributes",
  description:    "Description",
  name:           "Name",
  stack_name:     "StackName",
})

rest_post_only_properties %i{
  name stack_name
}
