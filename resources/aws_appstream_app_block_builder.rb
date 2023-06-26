# Import API specifics
use "awscc_base"

resource_name :aws_appstream_app_block_builder
provides :aws_appstream_app_block_builder, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppStream::AppBlockBuilder.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_endpoints, Array,
         callbacks: {
           "access_endpoints is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :app_block_arns, Array,
         callbacks: {
           "app_block_arns is not a Array" => lambda { |v| v.is_a? Array },
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

property :instance_type, String,
         required: true,
         callbacks: {
           "instance_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :platform, Hash,
         required: true,
         callbacks: {
           "platform is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :vpc_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AppStream::AppBlockBuilder"
rest_api_document "/AWS::AppStream::AppBlockBuilder"

rest_property_map({
  access_endpoints:               "AccessEndpoints",
  app_block_arns:                 "AppBlockArns",
  description:                    "Description",
  display_name:                   "DisplayName",
  enable_default_internet_access: "EnableDefaultInternetAccess",
  iam_role_arn:                   "IamRoleArn",
  instance_type:                  "InstanceType",
  name:                           "Name",
  platform:                       "Platform",
  tags:                           "Tags",
  vpc_config:                     "VpcConfig",
})

rest_post_only_properties %i{
  name
}
