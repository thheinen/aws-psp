# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iot_fleet_metric
provides :aws_iot_fleet_metric, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An aggregated metric of certain devices in your fleet
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :aggregation_field, String,
         callbacks: {
           "aggregation_field is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The aggregation field to perform aggregation and metric emission
         DESCRIPTION

property :aggregation_type, Hash,
         callbacks: {
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
           "Subproperty `Values` is not a Array" => lambda { |v| v[:Values].is_a? Array },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of a fleet metric
         DESCRIPTION

property :index_name, String,
         callbacks: {
           "index_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The index name of a fleet metric
         DESCRIPTION

property :metric_name, String,
         required: true,
         callbacks: {
           "metric_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the fleet metric
         DESCRIPTION

property :period, Integer,
         callbacks: {
           "period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The period of metric emission in seconds
         DESCRIPTION

property :query_string, String,
         callbacks: {
           "query_string is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Fleet Indexing query used by a fleet metric
         DESCRIPTION

property :query_version, String,
         callbacks: {
           "query_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The version of a Fleet Indexing query used by a fleet metric
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource
         DESCRIPTION

property :unit, String,
         callbacks: {
           "unit is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The unit of data points emitted by a fleet metric
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoT::FleetMetric"
rest_api_document "/AWS::IoT::FleetMetric"

rest_property_map({
  aggregation_field: "AggregationField",
  aggregation_type:  "AggregationType",
  description:       "Description",
  index_name:        "IndexName",
  metric_name:       "MetricName",
  period:            "Period",
  query_string:      "QueryString",
  query_version:     "QueryVersion",
  tags:              "Tags",
  unit:              "Unit",
})

rest_post_only_properties %i{
  metric_name
}
