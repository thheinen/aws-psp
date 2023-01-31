# Import API specifics
use "awscc_base"

resource_name :aws_roles_anywhere_profile
provides :aws_roles_anywhere_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::RolesAnywhere::Profile Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :duration_seconds, Number,
         callbacks: {
           "duration_seconds is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: ""

property :enabled, [TrueClass, FalseClass],
         callbacks: {
           "enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :managed_policy_arns, Array,
         callbacks: {
           "managed_policy_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :require_instance_properties, [TrueClass, FalseClass],
         callbacks: {
           "require_instance_properties is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :role_arns, Array,
         required: true,
         callbacks: {
           "role_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :session_policy, String,
         callbacks: {
           "session_policy is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RolesAnywhere::Profile"
rest_api_document "/AWS::RolesAnywhere::Profile"

rest_property_map({
  duration_seconds:            "DurationSeconds",
  enabled:                     "Enabled",
  managed_policy_arns:         "ManagedPolicyArns",
  name:                        "Name",
  require_instance_properties: "RequireInstanceProperties",
  role_arns:                   "RoleArns",
  session_policy:              "SessionPolicy",
  tags:                        "Tags",
})

