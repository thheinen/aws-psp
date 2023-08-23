# Import API specifics
use "awscc_base"

resource_name :aws_resiliencehub_app
provides :aws_resiliencehub_app, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type Definition for AWS::ResilienceHub::App.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :app_assessment_schedule, String,
         callbacks: {
           "app_assessment_schedule is not a String" => lambda { |v| v.is_a? String },
           "app_assessment_scheduleis not one of `Disabled`, `Daily`" => lambda { |v| %w{Disabled Daily}.include? v },
         },
         description: <<~'DESCRIPTION'
           Assessment execution schedule.
         DESCRIPTION

property :app_template_body, String,
         required: true,
         callbacks: {
           "app_template_body is not a String" => lambda { |v| v.is_a? String },
           "app_template_body needs to be 0..409600 characters" => lambda { |v| v.length >= 0 && v.length <= 409600 },
           "app_template_body must match pattern ^[\w\s:,-\.'\/{}\[\]:"]+$" => lambda { |v| v =~ Regexp.new("/^[\w\s:,-\.'\/{}\[\]:"]+$/") },
         },
         description: <<~'DESCRIPTION'
           A string containing full ResilienceHub app template body.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..500 characters" => lambda { |v| v.length >= 0 && v.length <= 500 },
         },
         description: <<~'DESCRIPTION'
           App description.
         DESCRIPTION

property :event_subscriptions, Array,
         callbacks: {
           "event_subscriptions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of events you would like to subscribe and get notification for.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[A-Za-z0-9][A-Za-z0-9_\-]{1,59}$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9][A-Za-z0-9_\-]{1,59}$/") },
         },
         description: <<~'DESCRIPTION'
           Name of the app.
         DESCRIPTION

property :permission_model, Hash,
         callbacks: {
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `LegacyIAMUser`, `RoleBased`" => lambda { |v| %w{LegacyIAMUser RoleBased}.include? v[:Type] },
           "Subproperty `InvokerRoleName` is not a String" => lambda { |v| v[:InvokerRoleName].is_a? String },
           "Subproperty `InvokerRoleName` must match pattern ((\u002F[\u0021-\u007E]+\u002F){1,511})?[A-Za-z0-9+=,.@_/-]{1,64}" => lambda { |v| v[:InvokerRoleName] =~ Regexp.new("/((\u002F[\u0021-\u007E]+\u002F){1,511})?[A-Za-z0-9+=,.@_/-]{1,64}/") },
           "Subproperty `CrossAccountRoleArns` is not a Array" => lambda { |v| v[:CrossAccountRoleArns].is_a? Array },
         },
         description: ""

property :resiliency_policy_arn, String,
         callbacks: {
           "resiliency_policy_arn is not a String" => lambda { |v| v.is_a? String },
           "resiliency_policy_arn must match pattern ^arn:(aws|aws-cn|aws-iso|aws-iso-[a-z]{1}|aws-us-gov):[A-Za-z0-9][A-Za-z0-9_/.-]{0,62}:([a-z]{2}-((iso[a-z]{0,1}-)|(gov-)){0,1}[a-z]+-[0-9]):[0-9]{12}:[A-Za-z0-9][A-Za-z0-9:_/+=,@.-]{0,1023}$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-iso|aws-iso-[a-z]{1}|aws-us-gov):[A-Za-z0-9][A-Za-z0-9_/.-]{0,62}:([a-z]{2}-((iso[a-z]{0,1}-)|(gov-)){0,1}[a-z]+-[0-9]):[0-9]{12}:[A-Za-z0-9][A-Za-z0-9:_/+=,@.-]{0,1023}$/") },
         },
         description: <<~'DESCRIPTION'
           Amazon Resource Name (ARN) of the Resiliency Policy.
         DESCRIPTION

property :resource_mappings, Array,
         required: true,
         callbacks: {
           "resource_mappings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of ResourceMapping objects.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ResilienceHub::App"
rest_api_document "/AWS::ResilienceHub::App"

rest_property_map({
  app_assessment_schedule: "AppAssessmentSchedule",
  app_template_body:       "AppTemplateBody",
  description:             "Description",
  event_subscriptions:     "EventSubscriptions",
  name:                    "Name",
  permission_model:        "PermissionModel",
  resiliency_policy_arn:   "ResiliencyPolicyArn",
  resource_mappings:       "ResourceMappings",
  tags:                    "Tags",
})

rest_post_only_properties %i{
  name
}
