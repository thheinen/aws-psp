# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_domain
provides :aws_sagemaker_domain, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::Domain
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :app_network_access_type, String,
         callbacks: {
           "app_network_access_type is not a String" => lambda { |v| v.is_a? String },
           "app_network_access_typeis not one of `PublicInternetOnly`, `VpcOnly`" => lambda { |v| %w{PublicInternetOnly VpcOnly}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies the VPC used for non-EFS traffic. The default value is PublicInternetOnly.
         DESCRIPTION

property :app_security_group_management, String,
         callbacks: {
           "app_security_group_management is not a String" => lambda { |v| v.is_a? String },
           "app_security_group_managementis not one of `Service`, `Customer`" => lambda { |v| %w{Service Customer}.include? v },
         },
         description: <<~'DESCRIPTION'
           The entity that creates and manages the required security groups for inter-app communication in VPCOnly mode. Required when CreateDomain.AppNetworkAccessType is VPCOnly and DomainSettings.RStudioServerProDomainSettings.DomainExecutionRoleArn is provided.
         DESCRIPTION

property :auth_mode, String,
         required: true,
         callbacks: {
           "auth_mode is not a String" => lambda { |v| v.is_a? String },
           "auth_modeis not one of `SSO`, `IAM`" => lambda { |v| %w{SSO IAM}.include? v },
         },
         description: <<~'DESCRIPTION'
           The mode of authentication that members use to access the domain.
         DESCRIPTION

property :default_user_settings, Hash,
         required: true,
         callbacks: {
           "Subproperty `ExecutionRole` is not a String" => lambda { |v| v[:ExecutionRole].is_a? String },
           "Subproperty `ExecutionRole` needs to be 20..2048 characters" => lambda { |v| v[:ExecutionRole].length >= 20 && v[:ExecutionRole].length <= 2048 },
           "Subproperty `ExecutionRole` must match pattern ^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$" => lambda { |v| v[:ExecutionRole] =~ Regexp.new("/^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$/") },
           "Subproperty `SecurityGroups` is not a Array" => lambda { |v| v[:SecurityGroups].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The default user settings.
         DESCRIPTION

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
           "domain_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,62}" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,62}/") },
         },
         description: <<~'DESCRIPTION'
           A name for the domain.
         DESCRIPTION

property :domain_settings, Hash,
         callbacks: {
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
         },
         description: ""

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
           "kms_key_id must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: <<~'DESCRIPTION'
           SageMaker uses AWS KMS to encrypt the EFS volume attached to the domain with an AWS managed customer master key (CMK) by default.
         DESCRIPTION

property :subnet_ids, Array,
         required: true,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The VPC subnets that Studio uses for communication.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags to apply to the user profile.
         DESCRIPTION

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
           "vpc_id must match pattern [-0-9a-zA-Z]+" => lambda { |v| v =~ Regexp.new("/[-0-9a-zA-Z]+/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the Amazon Virtual Private Cloud (VPC) that Studio uses for communication.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::Domain"
rest_api_document "/AWS::SageMaker::Domain"

rest_property_map({
  app_network_access_type:       "AppNetworkAccessType",
  app_security_group_management: "AppSecurityGroupManagement",
  auth_mode:                     "AuthMode",
  default_user_settings:         "DefaultUserSettings",
  domain_name:                   "DomainName",
  domain_settings:               "DomainSettings",
  kms_key_id:                    "KmsKeyId",
  subnet_ids:                    "SubnetIds",
  tags:                          "Tags",
  vpc_id:                        "VpcId",
})

rest_post_only_properties %i{
  app_network_access_type app_security_group_management auth_mode domain_name domain_settings/r_studio_server_pro_domain_settings/default_resource_spec domain_settings/r_studio_server_pro_domain_settings/domain_execution_role_arn domain_settings/security_group_ids kms_key_id subnet_ids tags vpc_id
}
