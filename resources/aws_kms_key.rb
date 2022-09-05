# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_kms_key
provides :aws_kms_key, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::KMS::Key resource specifies an AWS KMS key in AWS Key Management Service (AWS KMS). Authorized users can use the AWS KMS key to encrypt and decrypt small amounts of data (up to 4096 bytes), but they are more commonly used to generate data keys. You can also use AWS KMS keys to encrypt data stored in AWS services that are integrated with AWS KMS or within their applications.
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

property :enable_key_rotation, [TrueClass, FalseClass],
         callbacks: {
           "enable_key_rotation is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Enables automatic rotation of the key material for the specified AWS KMS key. By default, automation key rotation is not enabled.
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

property :key_spec, String,
         callbacks: {
           "key_spec is not a String" => lambda { |v| v.is_a? String },
           "key_specis not one of `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, `ECC_SECG_P256K1`, `HMAC_224`, `HMAC_256`, `HMAC_384`, `HMAC_512`, `SM2`" => lambda { |v| %w{SYMMETRIC_DEFAULT RSA_2048 RSA_3072 RSA_4096 ECC_NIST_P256 ECC_NIST_P384 ECC_NIST_P521 ECC_SECG_P256K1 HMAC_224 HMAC_256 HMAC_384 HMAC_512 SM2}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies the type of AWS KMS key to create. The default value is SYMMETRIC_DEFAULT. This property is required only for asymmetric AWS KMS keys. You can't change the KeySpec value after the AWS KMS key is created.
         DESCRIPTION

property :key_usage, String,
         callbacks: {
           "key_usage is not a String" => lambda { |v| v.is_a? String },
           "key_usageis not one of `ENCRYPT_DECRYPT`, `SIGN_VERIFY`, `GENERATE_VERIFY_MAC`" => lambda { |v| %w{ENCRYPT_DECRYPT SIGN_VERIFY GENERATE_VERIFY_MAC}.include? v },
         },
         description: <<~'DESCRIPTION'
           Determines the cryptographic operations for which you can use the AWS KMS key. The default value is ENCRYPT_DECRYPT. This property is required only for asymmetric AWS KMS keys. You can't change the KeyUsage value after the AWS KMS key is created.
         DESCRIPTION

property :multi_region, [TrueClass, FalseClass],
         callbacks: {
           "multi_region is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether the AWS KMS key should be Multi-Region. You can't change the MultiRegion value after the AWS KMS key is created.
         DESCRIPTION

property :pending_window_in_days, Integer,
         callbacks: {
           "pending_window_in_days is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Specifies the number of days in the waiting period before AWS KMS deletes an AWS KMS key that has been removed from a CloudFormation stack. Enter a value between 7 and 30 days. The default value is 30 days.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::KMS::Key"
rest_api_document "/AWS::KMS::Key"

rest_property_map({
  description:            "Description",
  enable_key_rotation:    "EnableKeyRotation",
  enabled:                "Enabled",
  key_policy:             "KeyPolicy",
  key_spec:               "KeySpec",
  key_usage:              "KeyUsage",
  multi_region:           "MultiRegion",
  pending_window_in_days: "PendingWindowInDays",
  tags:                   "Tags",
})

