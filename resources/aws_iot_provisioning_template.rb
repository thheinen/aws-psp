# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iot_provisioning_template
provides :aws_iot_provisioning_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Creates a fleet provisioning template.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :enabled, [TrueClass, FalseClass],
         callbacks: {
           "enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :pre_provisioning_hook, Hash,
         callbacks: {
           "Subproperty `TargetArn` is not a String" => lambda { |v| v[:TargetArn].is_a? String },
           "Subproperty `TargetArn`is not a valid ARN" => lambda { |v| v[:TargetArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `PayloadVersion` is not a String" => lambda { |v| v[:PayloadVersion].is_a? String },
         },
         description: ""

property :provisioning_role_arn, String,
         required: true,
         callbacks: {
           "provisioning_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :template_body, String,
         required: true,
         callbacks: {
           "template_body is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :template_name, String,
         callbacks: {
           "template_name is not a String" => lambda { |v| v.is_a? String },
           "template_name needs to be 1..36 characters" => lambda { |v| v.length >= 1 && v.length <= 36 },
           "template_name must match pattern ^[0-9A-Za-z_-]+$" => lambda { |v| v =~ Regexp.new("/^[0-9A-Za-z_-]+$/") },
         },
         description: ""

property :template_type, String,
         callbacks: {
           "template_type is not a String" => lambda { |v| v.is_a? String },
           "template_typeis not one of `FLEET_PROVISIONING`, `JITP`" => lambda { |v| %w{FLEET_PROVISIONING JITP}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoT::ProvisioningTemplate"
rest_api_document "/AWS::IoT::ProvisioningTemplate"

rest_property_map({
  description:           "Description",
  enabled:               "Enabled",
  pre_provisioning_hook: "PreProvisioningHook",
  provisioning_role_arn: "ProvisioningRoleArn",
  tags:                  "Tags",
  template_body:         "TemplateBody",
  template_name:         "TemplateName",
  template_type:         "TemplateType",
})

rest_post_only_properties %i{
  template_name template_type
}
