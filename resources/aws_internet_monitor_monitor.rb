# Import API specifics
use "awscc_base"

resource_name :aws_internet_monitor_monitor
provides :aws_internet_monitor_monitor, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents a monitor, which defines the monitoring boundaries for measurements that Internet Monitor publishes information about for an application
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :internet_measurements_log_delivery, Hash,
         description: ""

property :max_city_networks_to_monitor, Integer,
         callbacks: {
           "max_city_networks_to_monitor is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :monitor_name, String,
         required: true,
         callbacks: {
           "monitor_name is not a String" => lambda { |v| v.is_a? String },
           "monitor_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "monitor_name must match pattern ^[a-zA-Z0-9_.-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_.-]+$/") },
         },
         description: ""

property :resources, Array,
         callbacks: {
           "resources is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :resources_to_add, Array,
         callbacks: {
           "resources_to_add is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :resources_to_remove, Array,
         callbacks: {
           "resources_to_remove is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :status, Hash,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `PENDING`, `ACTIVE`, `INACTIVE`, `ERROR`" => lambda { |v| %w{PENDING ACTIVE INACTIVE ERROR}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::InternetMonitor::Monitor"
rest_api_document "/AWS::InternetMonitor::Monitor"

rest_property_map({
  internet_measurements_log_delivery: "InternetMeasurementsLogDelivery",
  max_city_networks_to_monitor:       "MaxCityNetworksToMonitor",
  monitor_name:                       "MonitorName",
  resources:                          "Resources",
  resources_to_add:                   "ResourcesToAdd",
  resources_to_remove:                "ResourcesToRemove",
  status:                             "Status",
  tags:                               "Tags",
})

rest_post_only_properties %i{
  monitor_name
}
