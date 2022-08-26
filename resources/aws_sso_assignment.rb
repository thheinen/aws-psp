# Import API specifics
use "awscc_base"

resource_name :aws_sso_assignment
provides :aws_sso_assignment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for SSO assignmet
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn needs to be 10..1224 characters" => lambda { |v| v.length >= 10 && v.length <= 1224 },
           "instance_arn must match pattern arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b):sso:::instance/(sso)?ins-[a-zA-Z0-9-.]{16}" => lambda { |v| v =~ Regexp.new("/arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b):sso:::instance/(sso)?ins-[a-zA-Z0-9-.]{16}/") },
         },
         description: "The sso instance that the permission set is owned."

property :permission_set_arn, String,
         required: true,
         callbacks: {
           "permission_set_arn is not a String" => lambda { |v| v.is_a? String },
           "permission_set_arn needs to be 10..1224 characters" => lambda { |v| v.length >= 10 && v.length <= 1224 },
           "permission_set_arn must match pattern arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b):sso:::permissionSet/(sso)?ins-[a-zA-Z0-9-.]{16}/ps-[a-zA-Z0-9-./]{16}" => lambda { |v| v =~ Regexp.new("/arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b):sso:::permissionSet/(sso)?ins-[a-zA-Z0-9-.]{16}/ps-[a-zA-Z0-9-./]{16}/") },
         },
         description: "The permission set that the assignemt will be assigned"

property :principal_id, String,
         required: true,
         callbacks: {
           "principal_id is not a String" => lambda { |v| v.is_a? String },
           "principal_id needs to be 1..47 characters" => lambda { |v| v.length >= 1 && v.length <= 47 },
           "principal_id must match pattern ^([0-9a-f]{10}-|)[A-Fa-f0-9]{8}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^([0-9a-f]{10}-|)[A-Fa-f0-9]{8}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{12}$/") },
         },
         description: "The assignee's identifier, user id/group id"

property :principal_type, String,
         required: true,
         callbacks: {
           "principal_type is not a String" => lambda { |v| v.is_a? String },
           "principal_typeis not one of `USER`, `GROUP`" => lambda { |v| %w{USER GROUP}.include? v },
         },
         description: "The assignee's type, user/group"

property :target_id, String,
         required: true,
         callbacks: {
           "target_id is not a String" => lambda { |v| v.is_a? String },
           "target_id must match pattern \d{12}" => lambda { |v| v =~ Regexp.new("/\d{12}/") },
         },
         description: "The account id to be provisioned."

property :target_type, String,
         required: true,
         callbacks: {
           "target_type is not a String" => lambda { |v| v.is_a? String },
           "target_typeis not one of `AWS_ACCOUNT`" => lambda { |v| %w{AWS_ACCOUNT}.include? v },
         },
         description: "The type of resource to be provsioned to, only aws account now"

# API URLs and mappings
rest_api_collection "/AWS::SSO::Assignment"
rest_api_document "/AWS::SSO::Assignment"

rest_property_map({
  instance_arn:       "InstanceArn",
  permission_set_arn: "PermissionSetArn",
  principal_id:       "PrincipalId",
  principal_type:     "PrincipalType",
  target_id:          "TargetId",
  target_type:        "TargetType",
})

rest_post_only_properties %i{
  instance_arn permission_set_arn principal_id principal_type target_id target_type
}
