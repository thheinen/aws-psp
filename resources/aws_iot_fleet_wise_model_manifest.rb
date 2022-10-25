# Import API specifics
use "awscc_base"

resource_name :aws_iot_fleet_wise_model_manifest
provides :aws_iot_fleet_wise_model_manifest, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::IoTFleetWise::ModelManifest Resource Type
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

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "name must match pattern ^[a-zA-Z\d\-_:]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z\d\-_:]+$/") },
         },
         description: ""

property :nodes, Array,
         callbacks: {
           "nodes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :signal_catalog_arn, String,
         required: true,
         callbacks: {
           "signal_catalog_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :status, Hash,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ACTIVE`, `DRAFT`" => lambda { |v| %w{ACTIVE DRAFT}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoTFleetWise::ModelManifest"
rest_api_document "/AWS::IoTFleetWise::ModelManifest"

rest_property_map({
  description:        "Description",
  name:               "Name",
  nodes:              "Nodes",
  signal_catalog_arn: "SignalCatalogArn",
  status:             "Status",
  tags:               "Tags",
})

rest_post_only_properties %i{
  name
}
