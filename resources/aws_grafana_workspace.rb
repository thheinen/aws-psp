# Import API specifics
use "awscc_base"

resource_name :aws_grafana_workspace
provides :aws_grafana_workspace, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Grafana::Workspace Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :account_access_type, Hash,
         required: true,
         callbacks: {
           "account_access_type is not a String" => lambda { |v| v.is_a? String },
           "account_access_typeis not one of `CURRENT_ACCOUNT`, `ORGANIZATION`" => lambda { |v| %w{CURRENT_ACCOUNT ORGANIZATION}.include? v },
         },
         description: ""

property :authentication_providers, Array,
         required: true,
         callbacks: {
           "authentication_providers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of authentication providers to enable.
         DESCRIPTION

property :client_token, String,
         callbacks: {
           "client_token is not a String" => lambda { |v| v.is_a? String },
           "client_token must match pattern ^[!-~]{1,64}$" => lambda { |v| v =~ Regexp.new("/^[!-~]{1,64}$/") },
         },
         description: <<~'DESCRIPTION'
           A unique, case-sensitive, user-provided identifier to ensure the idempotency of the request.
         DESCRIPTION

property :data_sources, Array,
         callbacks: {
           "data_sources is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of data sources on the service managed IAM role.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..2048 characters" => lambda { |v| v.length >= 0 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           Description of a workspace.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[a-zA-Z0-9-._~]{1,255}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-._~]{1,255}$/") },
         },
         description: <<~'DESCRIPTION'
           The user friendly name of a workspace.
         DESCRIPTION

property :network_access_control, Hash,
         callbacks: {
           "Subproperty `PrefixListIds` is not a Array" => lambda { |v| v[:PrefixListIds].is_a? Array },
           "Subproperty `VpceIds` is not a Array" => lambda { |v| v[:VpceIds].is_a? Array },
         },
         description: ""

property :notification_destinations, Array,
         callbacks: {
           "notification_destinations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of notification destinations on the customers service managed IAM role that the Grafana workspace can query.
         DESCRIPTION

property :organization_role_name, String,
         callbacks: {
           "organization_role_name is not a String" => lambda { |v| v.is_a? String },
           "organization_role_name needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           The name of an IAM role that already exists to use with AWS Organizations to access AWS data sources and notification channels in other accounts in an organization.
         DESCRIPTION

property :organizational_units, Array,
         callbacks: {
           "organizational_units is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of Organizational Units containing AWS accounts the Grafana workspace can pull data from.
         DESCRIPTION

property :permission_type, Hash,
         required: true,
         callbacks: {
           "permission_type is not a String" => lambda { |v| v.is_a? String },
           "permission_typeis not one of `CUSTOMER_MANAGED`, `SERVICE_MANAGED`" => lambda { |v| %w{CUSTOMER_MANAGED SERVICE_MANAGED}.include? v },
         },
         description: ""

property :role_arn, String,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           IAM Role that will be used to grant the Grafana workspace access to a customers AWS resources.
         DESCRIPTION

property :saml_configuration, Hash,
         callbacks: {
           "Subproperty `AllowedOrganizations` is not a Array" => lambda { |v| v[:AllowedOrganizations].is_a? Array },
           "Subproperty `LoginValidityDuration` is not a Number" => lambda { |v| v[:LoginValidityDuration].is_a? Number },
         },
         description: ""

property :stack_set_name, String,
         callbacks: {
           "stack_set_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the AWS CloudFormation stack set to use to generate IAM roles to be used for this workspace.
         DESCRIPTION

property :vpc_configuration, Hash,
         callbacks: {
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Grafana::Workspace"
rest_api_document "/AWS::Grafana::Workspace"

rest_property_map({
  account_access_type:       "AccountAccessType",
  authentication_providers:  "AuthenticationProviders",
  client_token:              "ClientToken",
  data_sources:              "DataSources",
  description:               "Description",
  name:                      "Name",
  network_access_control:    "NetworkAccessControl",
  notification_destinations: "NotificationDestinations",
  organization_role_name:    "OrganizationRoleName",
  organizational_units:      "OrganizationalUnits",
  permission_type:           "PermissionType",
  role_arn:                  "RoleArn",
  saml_configuration:        "SamlConfiguration",
  stack_set_name:            "StackSetName",
  vpc_configuration:         "VpcConfiguration",
})

rest_post_only_properties %i{
  client_token
}
