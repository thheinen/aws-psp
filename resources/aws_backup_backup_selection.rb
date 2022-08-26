# Import API specifics
use "awscc_base"

resource_name :aws_backup_backup_selection
provides :aws_backup_backup_selection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Backup::BackupSelection
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :backup_plan_id, String,
         required: true,
         callbacks: {
           "backup_plan_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :backup_selection, Hash,
         required: true,
         callbacks: {
           "Subproperty `IamRoleArn` is not a String" => lambda { |v| v[:IamRoleArn].is_a? String },
           "Subproperty `IamRoleArn`is not a valid ARN" => lambda { |v| v[:IamRoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `ListOfTags` is not a Array" => lambda { |v| v[:ListOfTags].is_a? Array },
           "Subproperty `Resources` is not a Array" => lambda { |v| v[:Resources].is_a? Array },
           "Subproperty `SelectionName` is not a String" => lambda { |v| v[:SelectionName].is_a? String },
           "Subproperty `NotResources` is not a Array" => lambda { |v| v[:NotResources].is_a? Array },
           "Subproperty `Conditions` is not a Object" => lambda { |v| v[:Conditions].is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Backup::BackupSelection"
rest_api_document "/AWS::Backup::BackupSelection"

rest_property_map({
  backup_plan_id:   "BackupPlanId",
  backup_selection: "BackupSelection",
})

rest_post_only_properties %i{
  backup_plan_id backup_selection
}
