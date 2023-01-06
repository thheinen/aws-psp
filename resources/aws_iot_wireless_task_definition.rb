# Import API specifics
use "awscc_base"

resource_name :aws_iot_wireless_task_definition
provides :aws_iot_wireless_task_definition, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Creates a gateway task definition.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auto_create_tasks, [TrueClass, FalseClass],
         required: true,
         callbacks: {
           "auto_create_tasks is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether to automatically create tasks using this task definition for all gateways with the specified current version. If false, the task must me created by calling CreateWirelessGatewayTask.
         DESCRIPTION

property :lo_ra_wan_update_gateway_task_entry, Hash,
         description: <<~'DESCRIPTION'
           The list of task definitions.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           The name of the new resource.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the destination.
         DESCRIPTION

property :task_definition_type, String,
         callbacks: {
           "task_definition_type is not a String" => lambda { |v| v.is_a? String },
           "task_definition_typeis not one of `UPDATE`" => lambda { |v| %w{UPDATE}.include? v },
         },
         description: <<~'DESCRIPTION'
           A filter to list only the wireless gateway task definitions that use this task definition type
         DESCRIPTION

property :update, Hash,
         callbacks: {
           "Subproperty `UpdateDataSource` is not a String" => lambda { |v| v[:UpdateDataSource].is_a? String },
           "Subproperty `UpdateDataSource` needs to be 1..4096 characters" => lambda { |v| v[:UpdateDataSource].length >= 1 && v[:UpdateDataSource].length <= 4096 },
           "Subproperty `UpdateDataRole` is not a String" => lambda { |v| v[:UpdateDataRole].is_a? String },
           "Subproperty `UpdateDataRole` needs to be 1..2048 characters" => lambda { |v| v[:UpdateDataRole].length >= 1 && v[:UpdateDataRole].length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           Information about the gateways to update.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTWireless::TaskDefinition"
rest_api_document "/AWS::IoTWireless::TaskDefinition"

rest_property_map({
  auto_create_tasks:                   "AutoCreateTasks",
  lo_ra_wan_update_gateway_task_entry: "LoRaWANUpdateGatewayTaskEntry",
  name:                                "Name",
  tags:                                "Tags",
  task_definition_type:                "TaskDefinitionType",
  update:                              "Update",
})

