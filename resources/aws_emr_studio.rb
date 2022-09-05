# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_emr_studio
provides :aws_emr_studio, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::EMR::Studio
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auth_mode, String,
         required: true,
         callbacks: {
           "auth_mode is not a String" => lambda { |v| v.is_a? String },
           "auth_modeis not one of `SSO`, `IAM`" => lambda { |v| %w{SSO IAM}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies whether the Studio authenticates users using single sign-on (SSO) or IAM. Amazon EMR Studio currently only supports SSO authentication.
         DESCRIPTION

property :default_s3_location, String,
         required: true,
         callbacks: {
           "default_s3_location is not a String" => lambda { |v| v.is_a? String },
           "default_s3_location needs to be 6..10280 characters" => lambda { |v| v.length >= 6 && v.length <= 10280 },
           "default_s3_location must match pattern ^s3://.*" => lambda { |v| v =~ Regexp.new("/^s3://.*/") },
         },
         description: <<~'DESCRIPTION'
           The default Amazon S3 location to back up EMR Studio Workspaces and notebook files. A Studio user can select an alternative Amazon S3 location when creating a Workspace.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           A detailed description of the Studio.
         DESCRIPTION

property :engine_security_group_id, String,
         required: true,
         callbacks: {
           "engine_security_group_id is not a String" => lambda { |v| v.is_a? String },
           "engine_security_group_id needs to be 4..256 characters" => lambda { |v| v.length >= 4 && v.length <= 256 },
           "engine_security_group_id must match pattern ^sg-[a-zA-Z0-9\-._]+$" => lambda { |v| v =~ Regexp.new("/^sg-[a-zA-Z0-9\-._]+$/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the Amazon EMR Studio Engine security group. The Engine security group allows inbound network traffic from the Workspace security group, and it must be in the same VPC specified by VpcId.
         DESCRIPTION

property :idp_auth_url, String,
         callbacks: {
           "idp_auth_url is not a String" => lambda { |v| v.is_a? String },
           "idp_auth_url must match pattern ^https://[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])(:[0-9]*)*([?/#].*)?$" => lambda { |v| v =~ Regexp.new("/^https://[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])(:[0-9]*)*([?/#].*)?$/") },
         },
         description: <<~'DESCRIPTION'
           Your identity provider's authentication endpoint. Amazon EMR Studio redirects federated users to this endpoint for authentication when logging in to a Studio with the Studio URL.
         DESCRIPTION

property :idp_relay_state_parameter_name, String,
         callbacks: {
           "idp_relay_state_parameter_name is not a String" => lambda { |v| v.is_a? String },
           "idp_relay_state_parameter_name needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           The name of relay state parameter for external Identity Provider.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "name must match pattern [a-zA-Z0-9_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_-]+/") },
         },
         description: <<~'DESCRIPTION'
           A descriptive name for the Amazon EMR Studio.
         DESCRIPTION

property :service_role, Hash,
         required: true,
         callbacks: {
           "service_role is not a String" => lambda { |v| v.is_a? String },
           "service_role must match pattern ^arn:aws(-(cn|us-gov))?:[a-z-]+:(([a-z]+-)+[0-9])?:([0-9]{12})?:[^.]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws(-(cn|us-gov))?:[a-z-]+:(([a-z]+-)+[0-9])?:([0-9]{12})?:[^.]+$/") },
         },
         description: <<~'DESCRIPTION'
           The IAM role that will be assumed by the Amazon EMR Studio. The service role provides a way for Amazon EMR Studio to interoperate with other AWS services.
         DESCRIPTION

property :subnet_ids, Array,
         required: true,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of up to 5 subnet IDs to associate with the Studio. The subnets must belong to the VPC specified by VpcId. Studio users can create a Workspace in any of the specified subnets.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags to associate with the Studio. Tags are user-defined key-value pairs that consist of a required key string with a maximum of 128 characters, and an optional value string with a maximum of 256 characters.
         DESCRIPTION

property :user_role, Hash,
         callbacks: {
           "user_role is not a String" => lambda { |v| v.is_a? String },
           "user_role must match pattern ^arn:aws(-(cn|us-gov))?:[a-z-]+:(([a-z]+-)+[0-9])?:([0-9]{12})?:[^.]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws(-(cn|us-gov))?:[a-z-]+:(([a-z]+-)+[0-9])?:([0-9]{12})?:[^.]+$/") },
         },
         description: <<~'DESCRIPTION'
           The IAM user role that will be assumed by users and groups logged in to a Studio. The permissions attached to this IAM role can be scoped down for each user or group using session policies.
         DESCRIPTION

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
           "vpc_id must match pattern ^(vpc-[0-9a-f]{8}|vpc-[0-9a-f]{17})$" => lambda { |v| v =~ Regexp.new("/^(vpc-[0-9a-f]{8}|vpc-[0-9a-f]{17})$/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the Amazon Virtual Private Cloud (Amazon VPC) to associate with the Studio.
         DESCRIPTION

property :workspace_security_group_id, String,
         required: true,
         callbacks: {
           "workspace_security_group_id is not a String" => lambda { |v| v.is_a? String },
           "workspace_security_group_id must match pattern ^sg-[a-zA-Z0-9\-._]+$" => lambda { |v| v =~ Regexp.new("/^sg-[a-zA-Z0-9\-._]+$/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the Amazon EMR Studio Workspace security group. The Workspace security group allows outbound network traffic to resources in the Engine security group, and it must be in the same VPC specified by VpcId.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EMR::Studio"
rest_api_document "/AWS::EMR::Studio"

rest_property_map({
  auth_mode:                      "AuthMode",
  default_s3_location:            "DefaultS3Location",
  description:                    "Description",
  engine_security_group_id:       "EngineSecurityGroupId",
  idp_auth_url:                   "IdpAuthUrl",
  idp_relay_state_parameter_name: "IdpRelayStateParameterName",
  name:                           "Name",
  service_role:                   "ServiceRole",
  subnet_ids:                     "SubnetIds",
  tags:                           "Tags",
  user_role:                      "UserRole",
  vpc_id:                         "VpcId",
  workspace_security_group_id:    "WorkspaceSecurityGroupId",
})

rest_post_only_properties %i{
  auth_mode engine_security_group_id service_role user_role vpc_id workspace_security_group_id
}
