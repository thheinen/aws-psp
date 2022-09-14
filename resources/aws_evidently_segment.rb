# Import API specifics
use "awscc_base"

resource_name :aws_evidently_segment
provides :aws_evidently_segment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Evidently::Segment
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..160 characters" => lambda { |v| v.length >= 0 && v.length <= 160 },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
           "name must match pattern [-a-zA-Z0-9._]*" => lambda { |v| v =~ Regexp.new("/[-a-zA-Z0-9._]*/") },
         },
         description: ""

property :pattern, String,
         callbacks: {
           "pattern is not a String" => lambda { |v| v.is_a? String },
           "pattern needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
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
rest_api_collection "/AWS::Evidently::Segment"
rest_api_document "/AWS::Evidently::Segment"

rest_property_map({
  description: "Description",
  name:        "Name",
  pattern:     "Pattern",
  tags:        "Tags",
})

