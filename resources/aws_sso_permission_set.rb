# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_sso_permission_set
provides :aws_sso_permission_set, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for SSO PermissionSet
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :customer_managed_policy_references, Array,
         callbacks: {
           "customer_managed_policy_references is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..700 characters" => lambda { |v| v.length >= 1 && v.length <= 700 },
           "description must match pattern [\u0009\u000A\u000D\u0020-\u007E\u00A0-\u00FF]*" => lambda { |v| v =~ Regexp.new("/[\u0009\u000A\u000D\u0020-\u007E\u00A0-\u00FF]*/") },
         },
         description: <<~'DESCRIPTION'
           The permission set description.
         DESCRIPTION

property :inline_policy, [Hash, String],
         description: <<~'DESCRIPTION'
           The inline policy to put in permission set.
         DESCRIPTION

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn needs to be 10..1224 characters" => lambda { |v| v.length >= 10 && v.length <= 1224 },
           "instance_arn must match pattern arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b):sso:::instance/(sso)?ins-[a-zA-Z0-9-.]{16}" => lambda { |v| v =~ Regexp.new("/arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b):sso:::instance/(sso)?ins-[a-zA-Z0-9-.]{16}/") },
         },
         description: <<~'DESCRIPTION'
           The sso instance arn that the permission set is owned.
         DESCRIPTION

property :managed_policies, Array,
         callbacks: {
           "managed_policies is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..32 characters" => lambda { |v| v.length >= 1 && v.length <= 32 },
           "name must match pattern [\w+=,.@-]+" => lambda { |v| v =~ Regexp.new("/[\w+=,.@-]+/") },
         },
         description: <<~'DESCRIPTION'
           The name you want to assign to this permission set.
         DESCRIPTION

property :permissions_boundary, Hash,
         description: ""

property :relay_state_type, String,
         callbacks: {
           "relay_state_type is not a String" => lambda { |v| v.is_a? String },
           "relay_state_type needs to be 1..240 characters" => lambda { |v| v.length >= 1 && v.length <= 240 },
           "relay_state_type must match pattern [a-zA-Z0-9&amp;$@#\/%?=~\-_'&quot;|!:,.;*+\[\]\ \(\)\{\}]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9&amp;$@#\/%?=~\-_'&quot;|!:,.;*+\[\]\ \(\)\{\}]+/") },
         },
         description: <<~'DESCRIPTION'
           The relay state URL that redirect links to any service in the AWS Management Console.
         DESCRIPTION

property :session_duration, String,
         callbacks: {
           "session_duration is not a String" => lambda { |v| v.is_a? String },
           "session_duration needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "session_duration must match pattern ^(-?)P(?=\d|T\d)(?:(\d+)Y)?(?:(\d+)M)?(?:(\d+)([DW]))?(?:T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+(?:\.\d+)?)S)?)?$" => lambda { |v| v =~ Regexp.new("/^(-?)P(?=\d|T\d)(?:(\d+)Y)?(?:(\d+)M)?(?:(\d+)([DW]))?(?:T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+(?:\.\d+)?)S)?)?$/") },
         },
         description: <<~'DESCRIPTION'
           The length of time that a user can be signed in to an AWS account.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SSO::PermissionSet"
rest_api_document "/AWS::SSO::PermissionSet"

rest_property_map({
  customer_managed_policy_references: "CustomerManagedPolicyReferences",
  description:                        "Description",
  inline_policy:                      "InlinePolicy",
  instance_arn:                       "InstanceArn",
  managed_policies:                   "ManagedPolicies",
  name:                               "Name",
  permissions_boundary:               "PermissionsBoundary",
  relay_state_type:                   "RelayStateType",
  session_duration:                   "SessionDuration",
  tags:                               "Tags",
})

rest_post_only_properties %i{
  instance_arn name
}
