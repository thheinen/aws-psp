# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_backup_backup_vault
provides :aws_backup_backup_vault, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Backup::BackupVault
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_policy, [Hash, String],
         description: ""

property :backup_vault_name, Hash,
         required: true,
         callbacks: {
           "backup_vault_name is not a String" => lambda { |v| v.is_a? String },
           "backup_vault_name must match pattern ^[a-zA-Z0-9\-\_]{2,50}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9\-\_]{2,50}$/") },
         },
         description: ""

property :backup_vault_tags, Hash,
         callbacks: {
           "backup_vault_tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :encryption_key_arn, String,
         callbacks: {
           "encryption_key_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :lock_configuration, Hash,
         callbacks: {
           "Subproperty `MinRetentionDays` is not a Number" => lambda { |v| v[:MinRetentionDays].is_a? Number },
           "Subproperty `MaxRetentionDays` is not a Number" => lambda { |v| v[:MaxRetentionDays].is_a? Number },
           "Subproperty `ChangeableForDays` is not a Number" => lambda { |v| v[:ChangeableForDays].is_a? Number },
         },
         description: ""

property :notifications, Hash,
         callbacks: {
           "Subproperty `BackupVaultEvents` is not a Array" => lambda { |v| v[:BackupVaultEvents].is_a? Array },
           "Subproperty `SNSTopicArn` is not a String" => lambda { |v| v[:SNSTopicArn].is_a? String },
           "Subproperty `SNSTopicArn`is not a valid ARN" => lambda { |v| v[:SNSTopicArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Backup::BackupVault"
rest_api_document "/AWS::Backup::BackupVault"

rest_property_map({
  access_policy:      "AccessPolicy",
  backup_vault_name:  "BackupVaultName",
  backup_vault_tags:  "BackupVaultTags",
  encryption_key_arn: "EncryptionKeyArn",
  lock_configuration: "LockConfiguration",
  notifications:      "Notifications",
})

rest_post_only_properties %i{
  backup_vault_name encryption_key_arn
}
