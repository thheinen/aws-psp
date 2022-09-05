# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_redshift_serverless_namespace
provides :aws_redshift_serverless_namespace, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::RedshiftServerless::Namespace Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :admin_user_password, String,
         callbacks: {
           "admin_user_password is not a String" => lambda { |v| v.is_a? String },
           "admin_user_password needs to be 8..64 characters" => lambda { |v| v.length >= 8 && v.length <= 64 },
           "admin_user_password must match pattern ^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^\x00-\x20\x22\x27\x2f\x40\x5c\x7f-\uffff]+" => lambda { |v| v =~ Regexp.new("/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^\x00-\x20\x22\x27\x2f\x40\x5c\x7f-\uffff]+/") },
         },
         description: <<~'DESCRIPTION'
           The password associated with the admin user for the namespace that is being created. Password must be at least 8 characters in length, should be any printable ASCII character. Must contain at least one lowercase letter, one uppercase letter and one decimal digit.
         DESCRIPTION

property :admin_username, String,
         callbacks: {
           "admin_username is not a String" => lambda { |v| v.is_a? String },
           "admin_username must match pattern [a-zA-Z][a-zA-Z_0-9+.@-]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z][a-zA-Z_0-9+.@-]*/") },
         },
         description: <<~'DESCRIPTION'
           The user name associated with the admin user for the namespace that is being created. Only alphanumeric characters and underscores are allowed. It should start with an alphabet.
         DESCRIPTION

property :db_name, String,
         callbacks: {
           "db_name is not a String" => lambda { |v| v.is_a? String },
           "db_name must match pattern [a-zA-Z][a-zA-Z_0-9+.@-]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z][a-zA-Z_0-9+.@-]*/") },
         },
         description: <<~'DESCRIPTION'
           The database name associated for the namespace that is being created. Only alphanumeric characters and underscores are allowed. It should start with an alphabet.
         DESCRIPTION

property :default_iam_role_arn, String,
         callbacks: {
           "default_iam_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The default IAM role ARN for the namespace that is being created.
         DESCRIPTION

property :final_snapshot_name, String,
         callbacks: {
           "final_snapshot_name is not a String" => lambda { |v| v.is_a? String },
           "final_snapshot_name must match pattern [a-z][a-z0-9]*(-[a-z0-9]+)*" => lambda { |v| v =~ Regexp.new("/[a-z][a-z0-9]*(-[a-z0-9]+)*/") },
         },
         description: <<~'DESCRIPTION'
           The name of the namespace the source snapshot was created from. Please specify the name if needed before deleting namespace
         DESCRIPTION

property :final_snapshot_retention_period, Integer,
         callbacks: {
           "final_snapshot_retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of days to retain automated snapshot in the destination region after they are copied from the source region. If the value is -1, the manual snapshot is retained indefinitely. The value must be either -1 or an integer between 1 and 3,653.
         DESCRIPTION

property :iam_roles, Array,
         callbacks: {
           "iam_roles is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of AWS Identity and Access Management (IAM) roles that can be used by the namespace to access other AWS services. You must supply the IAM roles in their Amazon Resource Name (ARN) format. The Default role limit for each request is 10.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The AWS Key Management Service (KMS) key ID of the encryption key that you want to use to encrypt data in the namespace.
         DESCRIPTION

property :log_exports, Array,
         callbacks: {
           "log_exports is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The collection of log types to be exported provided by the customer. Should only be one of the three supported log types: userlog, useractivitylog and connectionlog
         DESCRIPTION

property :namespace_name, String,
         required: true,
         callbacks: {
           "namespace_name is not a String" => lambda { |v| v.is_a? String },
           "namespace_name needs to be 3..64 characters" => lambda { |v| v.length >= 3 && v.length <= 64 },
           "namespace_name must match pattern ^[a-z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9-]+$/") },
         },
         description: <<~'DESCRIPTION'
           A unique identifier for the namespace. You use this identifier to refer to the namespace for any subsequent namespace operations such as deleting or modifying. All alphabetical characters must be lower case. Namespace name should be unique for all namespaces within an AWS account.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of tags for the namespace.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::RedshiftServerless::Namespace"
rest_api_document "/AWS::RedshiftServerless::Namespace"

rest_property_map({
  admin_user_password:             "AdminUserPassword",
  admin_username:                  "AdminUsername",
  db_name:                         "DbName",
  default_iam_role_arn:            "DefaultIamRoleArn",
  final_snapshot_name:             "FinalSnapshotName",
  final_snapshot_retention_period: "FinalSnapshotRetentionPeriod",
  iam_roles:                       "IamRoles",
  kms_key_id:                      "KmsKeyId",
  log_exports:                     "LogExports",
  namespace_name:                  "NamespaceName",
  tags:                            "Tags",
})

rest_post_only_properties %i{
  namespace_name tags
}
