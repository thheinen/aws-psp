# Import API specifics
use "awscc_base"

resource_name :aws_app_integrations_data_integration
provides :aws_app_integrations_data_integration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppIntegrations::DataIntegration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000 },
         },
         description: <<~'DESCRIPTION'
           The data integration description.
         DESCRIPTION

property :file_configuration, Hash,
         callbacks: {
           "Subproperty `Folders` is not a Array" => lambda { |v| v[:Folders].is_a? Array },
           "Subproperty `Filters` is not a Object" => lambda { |v| v[:Filters].is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The configuration for what files should be pulled from the source.
         DESCRIPTION

property :kms_key, String,
         required: true,
         callbacks: {
           "kms_key is not a String" => lambda { |v| v.is_a? String },
           "kms_key needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "kms_key must match pattern .*\S.*" => lambda { |v| v =~ Regexp.new("/.*\S.*/") },
         },
         description: <<~'DESCRIPTION'
           The KMS key of the data integration.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "name must match pattern ^[a-zA-Z0-9/\._\-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9/\._\-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the data integration.
         DESCRIPTION

property :object_configuration, Hash,
         callbacks: {
           "object_configuration is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The configuration for what data should be pulled from the source.
         DESCRIPTION

property :schedule_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `FirstExecutionFrom` is not a String" => lambda { |v| v[:FirstExecutionFrom].is_a? String },
           "Subproperty `FirstExecutionFrom` needs to be 1..255 characters" => lambda { |v| v[:FirstExecutionFrom].length >= 1 && v[:FirstExecutionFrom].length <= 255 },
           "Subproperty `FirstExecutionFrom` must match pattern .*\S.*" => lambda { |v| v[:FirstExecutionFrom] =~ Regexp.new("/.*\S.*/") },
           "Subproperty `Object` is not a String" => lambda { |v| v[:Object].is_a? String },
           "Subproperty `Object` needs to be 1..255 characters" => lambda { |v| v[:Object].length >= 1 && v[:Object].length <= 255 },
           "Subproperty `Object` must match pattern ^[a-zA-Z0-9/\._\-]+$" => lambda { |v| v[:Object] =~ Regexp.new("/^[a-zA-Z0-9/\._\-]+$/") },
           "Subproperty `ScheduleExpression` is not a String" => lambda { |v| v[:ScheduleExpression].is_a? String },
           "Subproperty `ScheduleExpression` needs to be 1..255 characters" => lambda { |v| v[:ScheduleExpression].length >= 1 && v[:ScheduleExpression].length <= 255 },
           "Subproperty `ScheduleExpression` must match pattern .*\S.*" => lambda { |v| v[:ScheduleExpression] =~ Regexp.new("/.*\S.*/") },
         },
         description: <<~'DESCRIPTION'
           The name of the data and how often it should be pulled from the source.
         DESCRIPTION

property :source_uri, String,
         required: true,
         callbacks: {
           "source_uri is not a String" => lambda { |v| v.is_a? String },
           "source_uri needs to be 1..1000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000 },
           "source_uri must match pattern ^(\w+\:\/\/[\w.-]+[\w/!@#+=.-]+$)|(\w+\:\/\/[\w.-]+[\w/!@#+=.-]+[\w/!@#+=.-]+[\w/!@#+=.,-]+$)" => lambda { |v| v =~ Regexp.new("/^(\w+\:\/\/[\w.-]+[\w/!@#+=.-]+$)|(\w+\:\/\/[\w.-]+[\w/!@#+=.-]+[\w/!@#+=.-]+[\w/!@#+=.,-]+$)/") },
         },
         description: <<~'DESCRIPTION'
           The URI of the data source.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags (keys and values) associated with the data integration.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AppIntegrations::DataIntegration"
rest_api_document "/AWS::AppIntegrations::DataIntegration"

rest_property_map({
  description:          "Description",
  file_configuration:   "FileConfiguration",
  kms_key:              "KmsKey",
  name:                 "Name",
  object_configuration: "ObjectConfiguration",
  schedule_config:      "ScheduleConfig",
  source_uri:           "SourceURI",
  tags:                 "Tags",
})

rest_post_only_properties %i{
  kms_key schedule_config source_uri
}
