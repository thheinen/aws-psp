# Import API specifics
use "awscc_base"

resource_name :aws_fms_policy
provides :aws_fms_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Creates an AWS Firewall Manager policy.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :delete_all_policy_resources, [TrueClass, FalseClass],
         callbacks: {
           "delete_all_policy_resources is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :exclude_map, Hash,
         callbacks: {
           "Subproperty `ACCOUNT` is not a Array" => lambda { |v| v[:ACCOUNT].is_a? Array },
           "Subproperty `ORGUNIT` is not a Array" => lambda { |v| v[:ORGUNIT].is_a? Array },
         },
         description: ""

property :exclude_resource_tags, [TrueClass, FalseClass],
         required: true,
         callbacks: {
           "exclude_resource_tags is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :include_map, Hash,
         callbacks: {
           "Subproperty `ACCOUNT` is not a Array" => lambda { |v| v[:ACCOUNT].is_a? Array },
           "Subproperty `ORGUNIT` is not a Array" => lambda { |v| v[:ORGUNIT].is_a? Array },
         },
         description: ""

property :policy_name, String,
         required: true,
         callbacks: {
           "policy_name is not a String" => lambda { |v| v.is_a? String },
           "policy_name needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "policy_name must match pattern ^([a-zA-Z0-9_.:/=+\-@]+)$" => lambda { |v| v =~ Regexp.new("/^([a-zA-Z0-9_.:/=+\-@]+)$/") },
         },
         description: ""

property :remediation_enabled, [TrueClass, FalseClass],
         required: true,
         callbacks: {
           "remediation_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :resource_tags, Array,
         callbacks: {
           "resource_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :resource_type, Hash,
         required: true,
         callbacks: {
           "resource_type is not a String" => lambda { |v| v.is_a? String },
           "resource_type needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "resource_type must match pattern ^([^\s]*)$" => lambda { |v| v =~ Regexp.new("/^([^\s]*)$/") },
         },
         description: ""

property :resource_type_list, Array,
         callbacks: {
           "resource_type_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :resources_clean_up, [TrueClass, FalseClass],
         callbacks: {
           "resources_clean_up is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :security_service_policy_data, Hash,
         required: true,
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::FMS::Policy"
rest_api_document "/AWS::FMS::Policy"

rest_property_map({
  delete_all_policy_resources:  "DeleteAllPolicyResources",
  exclude_map:                  "ExcludeMap",
  exclude_resource_tags:        "ExcludeResourceTags",
  include_map:                  "IncludeMap",
  policy_name:                  "PolicyName",
  remediation_enabled:          "RemediationEnabled",
  resource_tags:                "ResourceTags",
  resource_type:                "ResourceType",
  resource_type_list:           "ResourceTypeList",
  resources_clean_up:           "ResourcesCleanUp",
  security_service_policy_data: "SecurityServicePolicyData",
  tags:                         "Tags",
})

