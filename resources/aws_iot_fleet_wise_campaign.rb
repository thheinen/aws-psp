# Import API specifics
use "awscc_base"

resource_name :aws_iot_fleet_wise_campaign
provides :aws_iot_fleet_wise_campaign, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::IoTFleetWise::Campaign Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :action, Hash,
         required: true,
         callbacks: {
           "action is not a String" => lambda { |v| v.is_a? String },
           "actionis not one of `APPROVE`, `SUSPEND`, `RESUME`, `UPDATE`" => lambda { |v| %w{APPROVE SUSPEND RESUME UPDATE}.include? v },
         },
         description: ""

property :collection_scheme, Hash,
         required: true,
         description: ""

property :compression, Hash,
         callbacks: {
           "compression is not a String" => lambda { |v| v.is_a? String },
           "compressionis not one of `OFF`, `SNAPPY`" => lambda { |v| %w{OFF SNAPPY}.include? v },
         },
         description: ""

property :data_destination_configs, Array,
         callbacks: {
           "data_destination_configs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :data_extra_dimensions, Array,
         callbacks: {
           "data_extra_dimensions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "description must match pattern ^[^\u0000-\u001F\u007F]+$" => lambda { |v| v =~ Regexp.new("/^[^\u0000-\u001F\u007F]+$/") },
         },
         description: ""

property :diagnostics_mode, Hash,
         callbacks: {
           "diagnostics_mode is not a String" => lambda { |v| v.is_a? String },
           "diagnostics_modeis not one of `OFF`, `SEND_ACTIVE_DTCS`" => lambda { |v| %w{OFF SEND_ACTIVE_DTCS}.include? v },
         },
         description: ""

property :expiry_time, String,
         callbacks: {
           "expiry_time is not a String" => lambda { |v| v.is_a? String },
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

property :post_trigger_collection_duration, Number,
         callbacks: {
           "post_trigger_collection_duration is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: ""

property :priority, Integer,
         callbacks: {
           "priority is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :signal_catalog_arn, String,
         required: true,
         callbacks: {
           "signal_catalog_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :signals_to_collect, Array,
         callbacks: {
           "signals_to_collect is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :spooling_mode, Hash,
         callbacks: {
           "spooling_mode is not a String" => lambda { |v| v.is_a? String },
           "spooling_modeis not one of `OFF`, `TO_DISK`" => lambda { |v| %w{OFF TO_DISK}.include? v },
         },
         description: ""

property :start_time, String,
         callbacks: {
           "start_time is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :target_arn, String,
         required: true,
         callbacks: {
           "target_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoTFleetWise::Campaign"
rest_api_document "/AWS::IoTFleetWise::Campaign"

rest_property_map({
  action:                           "Action",
  collection_scheme:                "CollectionScheme",
  compression:                      "Compression",
  data_destination_configs:         "DataDestinationConfigs",
  data_extra_dimensions:            "DataExtraDimensions",
  description:                      "Description",
  diagnostics_mode:                 "DiagnosticsMode",
  expiry_time:                      "ExpiryTime",
  name:                             "Name",
  post_trigger_collection_duration: "PostTriggerCollectionDuration",
  priority:                         "Priority",
  signal_catalog_arn:               "SignalCatalogArn",
  signals_to_collect:               "SignalsToCollect",
  spooling_mode:                    "SpoolingMode",
  start_time:                       "StartTime",
  tags:                             "Tags",
  target_arn:                       "TargetArn",
})

rest_post_only_properties %i{
  collection_scheme compression diagnostics_mode expiry_time name post_trigger_collection_duration priority signal_catalog_arn spooling_mode start_time target_arn
}
