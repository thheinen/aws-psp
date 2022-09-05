# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_cloudformation_resource_version
provides :aws_cloudformation_resource_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A resource that has been registered in the CloudFormation Registry.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

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

property :schema_handler_package, String,
         required: true,
         callbacks: {
           "schema_handler_package is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A url to the S3 bucket containing the schema handler package that contains the schema, event handlers, and associated files for the type you want to register.
            For information on generating a schema handler package for the type you want to register, see submit in the CloudFormation CLI User Guide.
         DESCRIPTION

property :type_name, String,
         required: true,
         callbacks: {
           "type_name is not a String" => lambda { |v| v.is_a? String },
           "type_name must match pattern ^[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the type being registered.
            We recommend that type names adhere to the following pattern: company_or_organization::service::type.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudFormation::ResourceVersion"
rest_api_document "/AWS::CloudFormation::ResourceVersion"

rest_property_map({
  execution_role_arn:     "ExecutionRoleArn",
  logging_config:         "LoggingConfig",
  schema_handler_package: "SchemaHandlerPackage",
  type_name:              "TypeName",
})

rest_post_only_properties %i{
  execution_role_arn logging_config schema_handler_package type_name
}
