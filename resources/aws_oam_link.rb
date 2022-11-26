# Import API specifics
use "awscc_base"

resource_name :aws_oam_link
provides :aws_oam_link, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Oam::Link Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :label_template, String,
         required: true,
         callbacks: {
           "label_template is not a String" => lambda { |v| v.is_a? String },
           "label_template needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: ""

property :resource_types, Array,
         required: true,
         callbacks: {
           "resource_types is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :sink_identifier, String,
         required: true,
         callbacks: {
           "sink_identifier is not a String" => lambda { |v| v.is_a? String },
           "sink_identifier needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Tags to apply to the link
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Oam::Link"
rest_api_document "/AWS::Oam::Link"

rest_property_map({
  label_template:  "LabelTemplate",
  resource_types:  "ResourceTypes",
  sink_identifier: "SinkIdentifier",
  tags:            "Tags",
})

rest_post_only_properties %i{
  label_template sink_identifier
}
