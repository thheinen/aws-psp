# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_pinpoint_in_app_template
provides :aws_pinpoint_in_app_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Pinpoint::InAppTemplate
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :content, Array,
         callbacks: {
           "content is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :custom_config, Hash,
         callbacks: {
           "custom_config is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :layout, String,
         callbacks: {
           "layout is not a String" => lambda { |v| v.is_a? String },
           "layoutis not one of `BOTTOM_BANNER`, `TOP_BANNER`, `OVERLAYS`, `MOBILE_FEED`, `MIDDLE_BANNER`, `CAROUSEL`" => lambda { |v| %w{BOTTOM_BANNER TOP_BANNER OVERLAYS MOBILE_FEED MIDDLE_BANNER CAROUSEL}.include? v },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :template_description, String,
         callbacks: {
           "template_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :template_name, String,
         required: true,
         callbacks: {
           "template_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Pinpoint::InAppTemplate"
rest_api_document "/AWS::Pinpoint::InAppTemplate"

rest_property_map({
  content:              "Content",
  custom_config:        "CustomConfig",
  layout:               "Layout",
  tags:                 "Tags",
  template_description: "TemplateDescription",
  template_name:        "TemplateName",
})

rest_post_only_properties %i{
  template_name
}
