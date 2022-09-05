# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iot_security_profile
provides :aws_iot_security_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A security profile defines a set of expected behaviors for devices in your account.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :additional_metrics_to_retain_v2, Array,
         callbacks: {
           "additional_metrics_to_retain_v2 is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of metrics whose data is retained (stored). By default, data is retained for any metric used in the profile's behaviors, but it is also retained for any metric specified here.
         DESCRIPTION

property :alert_targets, Hash,
         callbacks: {
           "alert_targets is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Specifies the destinations to which alerts are sent.
         DESCRIPTION

property :behaviors, Array,
         callbacks: {
           "behaviors is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Specifies the behaviors that, when violated by a device (thing), cause an alert.
         DESCRIPTION

property :security_profile_description, String,
         callbacks: {
           "security_profile_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description of the security profile.
         DESCRIPTION

property :security_profile_name, String,
         callbacks: {
           "security_profile_name is not a String" => lambda { |v| v.is_a? String },
           "security_profile_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "security_profile_name must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: <<~'DESCRIPTION'
           A unique identifier for the security profile.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Metadata that can be used to manage the security profile.
         DESCRIPTION

property :target_arns, Array,
         callbacks: {
           "target_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A set of target ARNs that the security profile is attached to.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoT::SecurityProfile"
rest_api_document "/AWS::IoT::SecurityProfile"

rest_property_map({
  additional_metrics_to_retain_v2: "AdditionalMetricsToRetainV2",
  alert_targets:                   "AlertTargets",
  behaviors:                       "Behaviors",
  security_profile_description:    "SecurityProfileDescription",
  security_profile_name:           "SecurityProfileName",
  tags:                            "Tags",
  target_arns:                     "TargetArns",
})

rest_post_only_properties %i{
  security_profile_name
}
