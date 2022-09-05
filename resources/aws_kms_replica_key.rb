# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_kms_replica_key
provides :aws_kms_replica_key, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::KMS::ReplicaKey resource specifies a multi-region replica AWS KMS key in AWS Key Management Service (AWS KMS).
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..8192 characters" => lambda { |v| v.length >= 0 && v.length <= 8192 },
         },
         description: <<~'DESCRIPTION'
           A description of the AWS KMS key. Use a description that helps you to distinguish this AWS KMS key from others in the account, such as its intended use.
         DESCRIPTION

property :enabled, [TrueClass, FalseClass],
         callbacks: {
           "enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether the AWS KMS key is enabled. Disabled AWS KMS keys cannot be used in cryptographic operations.
         DESCRIPTION

property :key_policy, [Hash, String],
         required: true,
         description: <<~'DESCRIPTION'
           The key policy that authorizes use of the AWS KMS key. The key policy must observe the following rules.
         DESCRIPTION

property :pending_window_in_days, Integer,
         callbacks: {
           "pending_window_in_days is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Specifies the number of days in the waiting period before AWS KMS deletes an AWS KMS key that has been removed from a CloudFormation stack. Enter a value between 7 and 30 days. The default value is 30 days.
         DESCRIPTION

property :primary_key_arn, String,
         required: true,
         callbacks: {
           "primary_key_arn is not a String" => lambda { |v| v.is_a? String },
           "primary_key_arn needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           Identifies the primary AWS KMS key to create a replica of. Specify the Amazon Resource Name (ARN) of the AWS KMS key. You cannot specify an alias or key ID. For help finding the ARN, see Finding the Key ID and ARN in the AWS Key Management Service Developer Guide.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::KMS::ReplicaKey"
rest_api_document "/AWS::KMS::ReplicaKey"

rest_property_map({
  description:            "Description",
  enabled:                "Enabled",
  key_policy:             "KeyPolicy",
  pending_window_in_days: "PendingWindowInDays",
  primary_key_arn:        "PrimaryKeyArn",
  tags:                   "Tags",
})

rest_post_only_properties %i{
  primary_key_arn
}
