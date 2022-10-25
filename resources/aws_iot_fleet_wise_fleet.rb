# Import API specifics
use "awscc_base"

resource_name :aws_iot_fleet_wise_fleet
provides :aws_iot_fleet_wise_fleet, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::IoTFleetWise::Fleet Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "description must match pattern ^[^\u0000-\u001F\u007F]+$" => lambda { |v| v =~ Regexp.new("/^[^\u0000-\u001F\u007F]+$/") },
         },
         description: ""

property :id, String,
         required: true,
         callbacks: {
           "id is not a String" => lambda { |v| v.is_a? String },
           "id needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "id must match pattern ^[a-zA-Z0-9:_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9:_-]+$/") },
         },
         description: ""

property :signal_catalog_arn, String,
         required: true,
         callbacks: {
           "signal_catalog_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoTFleetWise::Fleet"
rest_api_document "/AWS::IoTFleetWise::Fleet"

rest_property_map({
  description:        "Description",
  id:                 "Id",
  signal_catalog_arn: "SignalCatalogArn",
  tags:               "Tags",
})

rest_post_only_properties %i{
  id signal_catalog_arn
}
