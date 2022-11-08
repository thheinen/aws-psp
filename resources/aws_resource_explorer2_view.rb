# Import API specifics
use "awscc_base"

resource_name :aws_resource_explorer2_view
provides :aws_resource_explorer2_view, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::ResourceExplorer2::View Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :filters, Hash,
         callbacks: {
           "Subproperty `FilterString` is not a String" => lambda { |v| v[:FilterString].is_a? String },
         },
         description: ""

property :included_properties, Array,
         callbacks: {
           "included_properties is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :view_name, String,
         required: true,
         callbacks: {
           "view_name is not a String" => lambda { |v| v.is_a? String },
           "view_name must match pattern ^[a-zA-Z0-9\-]{1,64}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9\-]{1,64}$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ResourceExplorer2::View"
rest_api_document "/AWS::ResourceExplorer2::View"

rest_property_map({
  filters:             "Filters",
  included_properties: "IncludedProperties",
  tags:                "Tags",
  view_name:           "ViewName",
})

rest_post_only_properties %i{
  view_name
}
