# Import API specifics
use "awscc_base"

resource_name :aws_iot_twinmaker_workspace
provides :aws_iot_twinmaker_workspace, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTTwinMaker::Workspace
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..512 characters" => lambda { |v| v.length >= 0 && v.length <= 512 },
         },
         description: <<~'DESCRIPTION'
           The description of the workspace.
         DESCRIPTION

property :role, String,
         required: true,
         callbacks: {
           "role is not a String" => lambda { |v| v.is_a? String },
           "role needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "role must match pattern arn:((aws)|(aws-cn)|(aws-us-gov)):iam::[0-9]{12}:role/.*" => lambda { |v| v =~ Regexp.new("/arn:((aws)|(aws-cn)|(aws-us-gov)):iam::[0-9]{12}:role/.*/") },
         },
         description: <<~'DESCRIPTION'
           The ARN of the execution role associated with the workspace.
         DESCRIPTION

property :s3_location, String,
         required: true,
         callbacks: {
           "s3_location is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of the S3 bucket where resources associated with the workspace are stored.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A map of key-value pairs to associate with a resource.
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
rest_api_collection "/AWS::IoTTwinMaker::Workspace"
rest_api_document "/AWS::IoTTwinMaker::Workspace"

rest_property_map({
  description:  "Description",
  role:         "Role",
  s3_location:  "S3Location",
  tags:         "Tags",
  workspace_id: "WorkspaceId",
})

rest_post_only_properties %i{
  workspace_id
}
