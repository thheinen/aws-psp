# Import API specifics
use "awscc_base"

resource_name :aws_cloudformation_module_version
provides :aws_cloudformation_module_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A module that has been registered in the CloudFormation registry.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :module_name, String,
         required: true,
         callbacks: {
           "module_name is not a String" => lambda { |v| v.is_a? String },
           "module_name must match pattern ^[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::MODULE" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::MODULE/") },
         },
         description: <<~'DESCRIPTION'
           The name of the module being registered.
            Recommended module naming pattern: company_or_organization::service::type::MODULE.
         DESCRIPTION

property :module_package, String,
         required: true,
         callbacks: {
           "module_package is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The url to the S3 bucket containing the schema and template fragment for the module you want to register.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudFormation::ModuleVersion"
rest_api_document "/AWS::CloudFormation::ModuleVersion"

rest_property_map({
  module_name:    "ModuleName",
  module_package: "ModulePackage",
})

rest_post_only_properties %i{
  module_name module_package
}
