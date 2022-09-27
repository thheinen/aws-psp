# Import API specifics
use "awscc_base"

resource_name :aws_kms_alias
provides :aws_kms_alias, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::KMS::Alias resource specifies a display name for an AWS KMS key in AWS Key Management Service (AWS KMS). You can use an alias to identify an AWS KMS key in cryptographic operations.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :alias_name, String,
         required: true,
         callbacks: {
           "alias_name is not a String" => lambda { |v| v.is_a? String },
           "alias_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "alias_name must match pattern ^(alias/)[a-zA-Z0-9:/_-]+$" => lambda { |v| v =~ Regexp.new("/^(alias/)[a-zA-Z0-9:/_-]+$/") },
         },
         description: <<~'DESCRIPTION'
           Specifies the alias name. This value must begin with alias/ followed by a name, such as alias/ExampleAlias. The alias name cannot begin with alias/aws/. The alias/aws/ prefix is reserved for AWS managed keys.
         DESCRIPTION

property :target_key_id, String,
         required: true,
         callbacks: {
           "target_key_id is not a String" => lambda { |v| v.is_a? String },
           "target_key_id needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           Identifies the AWS KMS key to which the alias refers. Specify the key ID or the Amazon Resource Name (ARN) of the AWS KMS key. You cannot specify another alias. For help finding the key ID and ARN, see Finding the Key ID and ARN in the AWS Key Management Service Developer Guide.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::KMS::Alias"
rest_api_document "/AWS::KMS::Alias"

rest_property_map({
  alias_name:    "AliasName",
  target_key_id: "TargetKeyId",
})

rest_post_only_properties %i{
  alias_name
}
