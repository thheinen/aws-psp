# Import API specifics
use "awscc_base"

resource_name :aws_personalize_dataset_group
provides :aws_personalize_dataset_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema for AWS::Personalize::DatasetGroup.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain, String,
         callbacks: {
           "domain is not a String" => lambda { |v| v.is_a? String },
           "domainis not one of `ECOMMERCE`, `VIDEO_ON_DEMAND`" => lambda { |v| %w{ECOMMERCE VIDEO_ON_DEMAND}.include? v },
         },
         description: "The domain of a Domain dataset group."

property :kms_key_arn, String,
         callbacks: {
           "kms_key_arn is not a String" => lambda { |v| v.is_a? String },
           "kms_key_arn must match pattern arn:aws.*:kms:.*:[0-9]{12}:key/.*" => lambda { |v| v =~ Regexp.new("/arn:aws.*:kms:.*:[0-9]{12}:key/.*/") },
         },
         description: "The Amazon Resource Name(ARN) of a AWS Key Management Service (KMS) key used to encrypt the datasets."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "name must match pattern ^[a-zA-Z0-9][a-zA-Z0-9\-_]*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9\-_]*/") },
         },
         description: "The name for the new dataset group."

property :role_arn, String,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
           "role_arn must match pattern arn:([a-z\d-]+):iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+" => lambda { |v| v =~ Regexp.new("/arn:([a-z\d-]+):iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+/") },
         },
         description: "The ARN of the AWS Identity and Access Management (IAM) role that has permissions to access the AWS Key Management Service (KMS) key. Supplying an IAM role is only valid when also specifying a KMS key."

# API URLs and mappings
rest_api_collection "/AWS::Personalize::DatasetGroup"
rest_api_document "/AWS::Personalize::DatasetGroup"

rest_property_map({
  domain:      "Domain",
  kms_key_arn: "KmsKeyArn",
  name:        "Name",
  role_arn:    "RoleArn",
})

rest_post_only_properties %i{
  domain kms_key_arn name role_arn
}
