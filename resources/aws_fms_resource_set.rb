# Import API specifics
use "awscc_base"

resource_name :aws_fms_resource_set
provides :aws_fms_resource_set, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Creates an AWS Firewall Manager resource set.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern ^([a-zA-Z0-9_.:/=+\-@\s]*)$" => lambda { |v| v =~ Regexp.new("/^([a-zA-Z0-9_.:/=+\-@\s]*)$/") },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "name must match pattern ^([a-zA-Z0-9_.:/=+\-@\s]+)$" => lambda { |v| v =~ Regexp.new("/^([a-zA-Z0-9_.:/=+\-@\s]+)$/") },
         },
         description: ""

property :resource_type_list, Array,
         required: true,
         callbacks: {
           "resource_type_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :resources, Array,
         callbacks: {
           "resources is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::FMS::ResourceSet"
rest_api_document "/AWS::FMS::ResourceSet"

rest_property_map({
  description:        "Description",
  name:               "Name",
  resource_type_list: "ResourceTypeList",
  resources:          "Resources",
  tags:               "Tags",
})

