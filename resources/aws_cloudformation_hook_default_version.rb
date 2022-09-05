# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_cloudformation_hook_default_version
provides :aws_cloudformation_hook_default_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Set a version as default version for a hook in CloudFormation Registry.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :type_name, String,
         callbacks: {
           "type_name is not a String" => lambda { |v| v.is_a? String },
           "type_name must match pattern ^[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the type being registered.
            We recommend that type names adhere to the following pattern: company_or_organization::service::type.
         DESCRIPTION

property :type_version_arn, String,
         callbacks: {
           "type_version_arn is not a String" => lambda { |v| v.is_a? String },
           "type_version_arn must match pattern ^arn:aws[A-Za-z0-9-]{0,64}:cloudformation:[A-Za-z0-9-]{1,64}:([0-9]{12})?:type/hook/.+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[A-Za-z0-9-]{0,64}:cloudformation:[A-Za-z0-9-]{1,64}:([0-9]{12})?:type/hook/.+$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the type version.
         DESCRIPTION

property :version_id, String,
         callbacks: {
           "version_id is not a String" => lambda { |v| v.is_a? String },
           "version_id must match pattern ^[A-Za-z0-9-]{1,128}$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9-]{1,128}$/") },
         },
         description: <<~'DESCRIPTION'
           The ID of an existing version of the hook to set as the default.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudFormation::HookDefaultVersion"
rest_api_document "/AWS::CloudFormation::HookDefaultVersion"

rest_property_map({
  type_name:        "TypeName",
  type_version_arn: "TypeVersionArn",
  version_id:       "VersionId",
})

