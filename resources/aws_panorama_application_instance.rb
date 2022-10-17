# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_panorama_application_instance
provides :aws_panorama_application_instance, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for ApplicationInstance CloudFormation Resource
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_instance_id_to_replace, Hash,
         callbacks: {
           "application_instance_id_to_replace is not a String" => lambda { |v| v.is_a? String },
           "application_instance_id_to_replace needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "application_instance_id_to_replace must match pattern ^[a-zA-Z0-9\-\_]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9\-\_]+$/") },
         },
         description: ""

property :default_runtime_context_device, Hash,
         required: true,
         callbacks: {
           "default_runtime_context_device is not a String" => lambda { |v| v.is_a? String },
           "default_runtime_context_device needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "default_runtime_context_device must match pattern ^[a-zA-Z0-9\-\_]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9\-\_]+$/") },
         },
         description: ""

property :description, Hash,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..255 characters" => lambda { |v| v.length >= 0 && v.length <= 255 },
           "description must match pattern ^.*$" => lambda { |v| v =~ Regexp.new("/^.*$/") },
         },
         description: ""

property :device_id, Hash,
         callbacks: {
           "device_id is not a String" => lambda { |v| v.is_a? String },
           "device_id needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "device_id must match pattern ^[a-zA-Z0-9\-\_]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9\-\_]+$/") },
         },
         description: ""

property :manifest_overrides_payload, Hash,
         description: ""

property :manifest_payload, Hash,
         required: true,
         description: ""

property :name, Hash,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "name must match pattern ^[a-zA-Z0-9\-\_]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9\-\_]+$/") },
         },
         description: ""

property :runtime_role_arn, Hash,
         callbacks: {
           "runtime_role_arn is not a String" => lambda { |v| v.is_a? String },
           "runtime_role_arn needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "runtime_role_arn must match pattern ^arn:[a-z0-9][-.a-z0-9]{0,62}:iam::[0-9]{12}:role/.+$" => lambda { |v| v =~ Regexp.new("/^arn:[a-z0-9][-.a-z0-9]{0,62}:iam::[0-9]{12}:role/.+$/") },
         },
         description: ""

property :status_filter, Hash,
         callbacks: {
           "status_filter is not a String" => lambda { |v| v.is_a? String },
           "status_filteris not one of `DEPLOYMENT_SUCCEEDED`, `DEPLOYMENT_ERROR`, `REMOVAL_SUCCEEDED`, `REMOVAL_FAILED`, `PROCESSING_DEPLOYMENT`, `PROCESSING_REMOVAL`" => lambda { |v| %w{DEPLOYMENT_SUCCEEDED DEPLOYMENT_ERROR REMOVAL_SUCCEEDED REMOVAL_FAILED PROCESSING_DEPLOYMENT PROCESSING_REMOVAL}.include? v },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Panorama::ApplicationInstance"
rest_api_document "/AWS::Panorama::ApplicationInstance"

rest_property_map({
  application_instance_id_to_replace: "ApplicationInstanceIdToReplace",
  default_runtime_context_device:     "DefaultRuntimeContextDevice",
  description:                        "Description",
  device_id:                          "DeviceId",
  manifest_overrides_payload:         "ManifestOverridesPayload",
  manifest_payload:                   "ManifestPayload",
  name:                               "Name",
  runtime_role_arn:                   "RuntimeRoleArn",
  status_filter:                      "StatusFilter",
  tags:                               "Tags",
})

rest_post_only_properties %i{
  application_instance_id_to_replace default_runtime_context_device description manifest_overrides_payload manifest_payload name runtime_role_arn
}
