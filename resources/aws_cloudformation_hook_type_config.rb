# Import API specifics
use "awscc_base"

resource_name :aws_cloudformation_hook_type_config
provides :aws_cloudformation_hook_type_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Specifies the configuration data for a registered hook in CloudFormation Registry.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :configuration, String,
         callbacks: {
           "configuration is not a String" => lambda { |v| v.is_a? String },
           "configuration must match pattern [\s\S]+" => lambda { |v| v =~ Regexp.new("/[\s\S]+/") },
         },
         description: <<~'DESCRIPTION'
           The configuration data for the extension, in this account and region.
         DESCRIPTION

property :configuration_alias, String,
         callbacks: {
           "configuration_alias is not a String" => lambda { |v| v.is_a? String },
           "configuration_alias must match pattern ^[a-zA-Z0-9]{1,256}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9]{1,256}$/") },
           "configuration_aliasis not one of `default`" => lambda { |v| %w{default}.include? v },
         },
         description: <<~'DESCRIPTION'
           An alias by which to refer to this extension configuration data.
         DESCRIPTION

property :type_arn, String,
         callbacks: {
           "type_arn is not a String" => lambda { |v| v.is_a? String },
           "type_arn must match pattern ^arn:aws[A-Za-z0-9-]{0,64}:cloudformation:[A-Za-z0-9-]{1,64}:([0-9]{12})?:type/hook/.+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[A-Za-z0-9-]{0,64}:cloudformation:[A-Za-z0-9-]{1,64}:([0-9]{12})?:type/hook/.+$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the type without version number.
         DESCRIPTION

property :type_name, String,
         callbacks: {
           "type_name is not a String" => lambda { |v| v.is_a? String },
           "type_name must match pattern ^[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the type being registered.
            We recommend that type names adhere to the following pattern: company_or_organization::service::type.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudFormation::HookTypeConfig"
rest_api_document "/AWS::CloudFormation::HookTypeConfig"

rest_property_map({
  configuration:       "Configuration",
  configuration_alias: "ConfigurationAlias",
  type_arn:            "TypeArn",
  type_name:           "TypeName",
})

rest_post_only_properties %i{
  configuration_alias
}
