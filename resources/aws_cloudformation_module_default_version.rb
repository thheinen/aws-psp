# Import API specifics
use "awscc_base"

resource_name :aws_cloudformation_module_default_version
provides :aws_cloudformation_module_default_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A module that has been registered in the CloudFormation registry as the default version
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :arn, String,
         callbacks: {
           "arn is not a String" => lambda { |v| v.is_a? String },
           "arn must match pattern ^arn:aws[A-Za-z0-9-]{0,64}:cloudformation:[A-Za-z0-9-]{1,64}:([0-9]{12})?:type/module/.+/[0-9]{8}$" => lambda { |v| v =~ Regexp.new("/^arn:aws[A-Za-z0-9-]{0,64}:cloudformation:[A-Za-z0-9-]{1,64}:([0-9]{12})?:type/module/.+/[0-9]{8}$/") },
         },
         description: "The Amazon Resource Name (ARN) of the module version to set as the default version."

property :module_name, String,
         callbacks: {
           "module_name is not a String" => lambda { |v| v.is_a? String },
           "module_name must match pattern ^[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::MODULE" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::MODULE/") },
         },
         description: "The name of a module existing in the registry."

property :version_id, String,
         callbacks: {
           "version_id is not a String" => lambda { |v| v.is_a? String },
           "version_id must match pattern ^[0-9]{8}$" => lambda { |v| v =~ Regexp.new("/^[0-9]{8}$/") },
         },
         description: "The ID of an existing version of the named module to set as the default."

# API URLs and mappings
rest_api_collection "/AWS::CloudFormation::ModuleDefaultVersion"
rest_api_document "/AWS::CloudFormation::ModuleDefaultVersion"

rest_property_map({
  arn:         "Arn",
  module_name: "ModuleName",
  version_id:  "VersionId",
})

rest_post_only_properties %i{
  arn module_name version_id
}
