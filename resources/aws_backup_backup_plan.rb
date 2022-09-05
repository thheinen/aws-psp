# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_backup_backup_plan
provides :aws_backup_backup_plan, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Backup::BackupPlan
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :backup_plan, Hash,
         required: true,
         callbacks: {
           "Subproperty `BackupPlanName` is not a String" => lambda { |v| v[:BackupPlanName].is_a? String },
           "Subproperty `AdvancedBackupSettings` is not a Array" => lambda { |v| v[:AdvancedBackupSettings].is_a? Array },
           "Subproperty `BackupPlanRule` is not a Array" => lambda { |v| v[:BackupPlanRule].is_a? Array },
         },
         description: ""

property :backup_plan_tags, Hash,
         callbacks: {
           "backup_plan_tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Backup::BackupPlan"
rest_api_document "/AWS::Backup::BackupPlan"

rest_property_map({
  backup_plan:      "BackupPlan",
  backup_plan_tags: "BackupPlanTags",
})

