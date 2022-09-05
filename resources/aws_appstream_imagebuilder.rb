# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_appstream_imagebuilder
provides :aws_appstream_imagebuilder, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppStream::ImageBuilder
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_endpoints, Array,
         callbacks: {
           "access_endpoints is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :appstream_agent_version, String,
         callbacks: {
           "appstream_agent_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :display_name, String,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :domain_join_info, Hash,
         callbacks: {
           "Subproperty `OrganizationalUnitDistinguishedName` is not a String" => lambda { |v| v[:OrganizationalUnitDistinguishedName].is_a? String },
           "Subproperty `DirectoryName` is not a String" => lambda { |v| v[:DirectoryName].is_a? String },
         },
         description: ""

property :enable_default_internet_access, [TrueClass, FalseClass],
         callbacks: {
           "enable_default_internet_access is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :iam_role_arn, String,
         callbacks: {
           "iam_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :image_arn, String,
         callbacks: {
           "image_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :image_name, String,
         callbacks: {
           "image_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :instance_type, String,
         required: true,
         callbacks: {
           "instance_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :vpc_config, Hash,
         callbacks: {
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AppStream::ImageBuilder"
rest_api_document "/AWS::AppStream::ImageBuilder"

rest_property_map({
  access_endpoints:               "AccessEndpoints",
  appstream_agent_version:        "AppstreamAgentVersion",
  description:                    "Description",
  display_name:                   "DisplayName",
  domain_join_info:               "DomainJoinInfo",
  enable_default_internet_access: "EnableDefaultInternetAccess",
  iam_role_arn:                   "IamRoleArn",
  image_arn:                      "ImageArn",
  image_name:                     "ImageName",
  instance_type:                  "InstanceType",
  name:                           "Name",
  tags:                           "Tags",
  vpc_config:                     "VpcConfig",
})

