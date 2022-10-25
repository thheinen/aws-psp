# Import API specifics
use "awscc_base"

resource_name :aws_iot_fleet_wise_signal_catalog
provides :aws_iot_fleet_wise_signal_catalog, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::IoTFleetWise::SignalCatalog Resource Type
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
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "name must match pattern ^[a-zA-Z\d\-_:]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z\d\-_:]+$/") },
         },
         description: ""

property :node_counts, Hash,
         callbacks: {
           "Subproperty `TotalNodes` is not a Number" => lambda { |v| v[:TotalNodes].is_a? Number },
           "Subproperty `TotalBranches` is not a Number" => lambda { |v| v[:TotalBranches].is_a? Number },
           "Subproperty `TotalSensors` is not a Number" => lambda { |v| v[:TotalSensors].is_a? Number },
           "Subproperty `TotalAttributes` is not a Number" => lambda { |v| v[:TotalAttributes].is_a? Number },
           "Subproperty `TotalActuators` is not a Number" => lambda { |v| v[:TotalActuators].is_a? Number },
         },
         description: ""

property :nodes, Array,
         callbacks: {
           "nodes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoTFleetWise::SignalCatalog"
rest_api_document "/AWS::IoTFleetWise::SignalCatalog"

rest_property_map({
  description: "Description",
  name:        "Name",
  node_counts: "NodeCounts",
  nodes:       "Nodes",
  tags:        "Tags",
})

rest_post_only_properties %i{
  name
}
