# Import API specifics
use "awscc_base"

resource_name :aws_iot_twinmaker_sync_job
provides :aws_iot_twinmaker_sync_job, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTTwinMaker::SyncJob
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :sync_role, String,
         required: true,
         callbacks: {
           "sync_role is not a String" => lambda { |v| v.is_a? String },
           "sync_role needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "sync_role must match pattern arn:((aws)|(aws-cn)|(aws-us-gov)):iam::[0-9]{12}:role/.*" => lambda { |v| v =~ Regexp.new("/arn:((aws)|(aws-cn)|(aws-us-gov)):iam::[0-9]{12}:role/.*/") },
         },
         description: <<~'DESCRIPTION'
           The IAM Role that execute SyncJob.
         DESCRIPTION

property :sync_source, String,
         required: true,
         callbacks: {
           "sync_source is not a String" => lambda { |v| v.is_a? String },
           "sync_source needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: <<~'DESCRIPTION'
           The source of the SyncJob.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A key-value pair to associate with a resource.
         DESCRIPTION

property :workspace_id, String,
         required: true,
         callbacks: {
           "workspace_id is not a String" => lambda { |v| v.is_a? String },
           "workspace_id needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "workspace_id must match pattern [a-zA-Z_0-9][a-zA-Z_\-0-9]*[a-zA-Z0-9]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z_0-9][a-zA-Z_\-0-9]*[a-zA-Z0-9]+/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the workspace.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTTwinMaker::SyncJob"
rest_api_document "/AWS::IoTTwinMaker::SyncJob"

rest_property_map({
  sync_role:    "SyncRole",
  sync_source:  "SyncSource",
  tags:         "Tags",
  workspace_id: "WorkspaceId",
})

rest_post_only_properties %i{
  sync_role sync_source tags workspace_id
}
