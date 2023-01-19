# Import API specifics
use "awscc_base"

resource_name :aws_iot_analytics_datastore
provides :aws_iot_analytics_datastore, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IoTAnalytics::Datastore
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :datastore_name, String,
         callbacks: {
           "datastore_name is not a String" => lambda { |v| v.is_a? String },
           "datastore_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "datastore_name must match pattern [a-zA-Z0-9_]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_]+/") },
         },
         description: ""

property :datastore_partitions, Hash,
         callbacks: {
           "Subproperty `Partitions` is not a Array" => lambda { |v| v[:Partitions].is_a? Array },
         },
         description: ""

property :datastore_storage, Hash,
         description: ""

property :file_format_configuration, Hash,
         description: ""

property :retention_period, Hash,
         callbacks: {
           "Subproperty `NumberOfDays` is not a Integer" => lambda { |v| v[:NumberOfDays].is_a? Integer },
           "Subproperty `Unlimited` is not a Boolean" => lambda { |v| v[:Unlimited].is_a? Boolean },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoTAnalytics::Datastore"
rest_api_document "/AWS::IoTAnalytics::Datastore"

rest_property_map({
  datastore_name:            "DatastoreName",
  datastore_partitions:      "DatastorePartitions",
  datastore_storage:         "DatastoreStorage",
  file_format_configuration: "FileFormatConfiguration",
  retention_period:          "RetentionPeriod",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  datastore_name
}
