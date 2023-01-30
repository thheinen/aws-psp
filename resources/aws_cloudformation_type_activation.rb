# Import API specifics
use "awscc_base"

resource_name :aws_cloudformation_type_activation
provides :aws_cloudformation_type_activation, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Enable a resource that has been published in the CloudFormation Registry.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auto_update, [TrueClass, FalseClass],
         callbacks: {
           "auto_update is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether to automatically update the extension in this account and region when a new minor version is published by the extension publisher. Major versions released by the publisher must be manually updated.
         DESCRIPTION

property :execution_role_arn, String,
         callbacks: {
           "execution_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the IAM execution role to use to register the type. If your resource type calls AWS APIs in any of its handlers, you must create an IAM execution role that includes the necessary permissions to call those AWS APIs, and provision that execution role in your account. CloudFormation then assumes that execution role to provide your resource type with the appropriate credentials.
         DESCRIPTION

property :logging_config, Hash,
         callbacks: {
           "Subproperty `LogGroupName` is not a String" => lambda { |v| v[:LogGroupName].is_a? String },
           "Subproperty `LogGroupName` needs to be 1..512 characters" => lambda { |v| v[:LogGroupName].length >= 1 && v[:LogGroupName].length <= 512 },
           "Subproperty `LogGroupName` must match pattern ^[\.\-_/#A-Za-z0-9]+$" => lambda { |v| v[:LogGroupName] =~ Regexp.new("/^[\.\-_/#A-Za-z0-9]+$/") },
           "Subproperty `LogRoleArn` is not a String" => lambda { |v| v[:LogRoleArn].is_a? String },
           "Subproperty `LogRoleArn` needs to be 1..256 characters" => lambda { |v| v[:LogRoleArn].length >= 1 && v[:LogRoleArn].length <= 256 },
           "Subproperty `LogRoleArn`is not a valid ARN" => lambda { |v| v[:LogRoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: <<~'DESCRIPTION'
           Specifies logging configuration information for a type.
         DESCRIPTION

property :major_version, String,
         callbacks: {
           "major_version is not a String" => lambda { |v| v.is_a? String },
           "major_version needs to be 1..100000 characters" => lambda { |v| v.length >= 1 && v.length <= 100000 },
         },
         description: <<~'DESCRIPTION'
           The Major Version of the type you want to enable
         DESCRIPTION

property :public_type_arn, String,
         callbacks: {
           "public_type_arn is not a String" => lambda { |v| v.is_a? String },
           "public_type_arn must match pattern arn:aws[A-Za-z0-9-]{0,64}:cloudformation:[A-Za-z0-9-]{1,64}:([0-9]{12})?:type/.+" => lambda { |v| v =~ Regexp.new("/arn:aws[A-Za-z0-9-]{0,64}:cloudformation:[A-Za-z0-9-]{1,64}:([0-9]{12})?:type/.+/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Number (ARN) assigned to the public extension upon publication
         DESCRIPTION

property :publisher_id, String,
         callbacks: {
           "publisher_id is not a String" => lambda { |v| v.is_a? String },
           "publisher_id needs to be 1..40 characters" => lambda { |v| v.length >= 1 && v.length <= 40 },
           "publisher_id must match pattern [0-9a-zA-Z]{40}" => lambda { |v| v =~ Regexp.new("/[0-9a-zA-Z]{40}/") },
         },
         description: <<~'DESCRIPTION'
           The publisher id assigned by CloudFormation for publishing in this region.
         DESCRIPTION

property :type, String,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `RESOURCE`, `MODULE`, `HOOK`" => lambda { |v| %w{RESOURCE MODULE HOOK}.include? v },
         },
         description: <<~'DESCRIPTION'
           The kind of extension
         DESCRIPTION

property :type_name, String,
         callbacks: {
           "type_name is not a String" => lambda { |v| v.is_a? String },
           "type_name must match pattern [A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}(::MODULE){0,1}" => lambda { |v| v =~ Regexp.new("/[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}(::MODULE){0,1}/") },
         },
         description: <<~'DESCRIPTION'
           The name of the type being registered.
            We recommend that type names adhere to the following pattern: company_or_organization::service::type.
         DESCRIPTION

property :type_name_alias, String,
         callbacks: {
           "type_name_alias is not a String" => lambda { |v| v.is_a? String },
           "type_name_alias needs to be 10..204 characters" => lambda { |v| v.length >= 10 && v.length <= 204 },
           "type_name_alias must match pattern [A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}(::MODULE){0,1}" => lambda { |v| v =~ Regexp.new("/[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}(::MODULE){0,1}/") },
         },
         description: <<~'DESCRIPTION'
           An alias to assign to the public extension in this account and region. If you specify an alias for the extension, you must then use the alias to refer to the extension in your templates.
         DESCRIPTION

property :version_bump, String,
         callbacks: {
           "version_bump is not a String" => lambda { |v| v.is_a? String },
           "version_bumpis not one of `MAJOR`, `MINOR`" => lambda { |v| %w{MAJOR MINOR}.include? v },
         },
         description: <<~'DESCRIPTION'
           Manually updates a previously-enabled type to a new major or minor version, if available. You can also use this parameter to update the value of AutoUpdateEnabled
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudFormation::TypeActivation"
rest_api_document "/AWS::CloudFormation::TypeActivation"

rest_property_map({
  auto_update:        "AutoUpdate",
  execution_role_arn: "ExecutionRoleArn",
  logging_config:     "LoggingConfig",
  major_version:      "MajorVersion",
  public_type_arn:    "PublicTypeArn",
  publisher_id:       "PublisherId",
  type:               "Type",
  type_name:          "TypeName",
  type_name_alias:    "TypeNameAlias",
  version_bump:       "VersionBump",
})

rest_post_only_properties %i{
  execution_role_arn logging_config public_type_arn publisher_id type type_name type_name_alias
}
