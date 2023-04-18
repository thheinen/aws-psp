# Import API specifics
use "awscc_base"

resource_name :aws_support_app_slack_workspace_configuration
provides :aws_support_app_slack_workspace_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An AWS Support App resource that creates, updates, lists, and deletes Slack workspace configurations.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :team_id, String,
         required: true,
         callbacks: {
           "team_id is not a String" => lambda { |v| v.is_a? String },
           "team_id needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "team_id must match pattern ^\S+$" => lambda { |v| v =~ Regexp.new("/^\S+$/") },
         },
         description: <<~'DESCRIPTION'
           The team ID in Slack, which uniquely identifies a workspace.
         DESCRIPTION

property :version_id, String,
         callbacks: {
           "version_id is not a String" => lambda { |v| v.is_a? String },
           "version_id needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "version_id must match pattern ^[0-9]+$" => lambda { |v| v =~ Regexp.new("/^[0-9]+$/") },
         },
         description: <<~'DESCRIPTION'
           An identifier used to update an existing Slack workspace configuration in AWS CloudFormation.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SupportApp::SlackWorkspaceConfiguration"
rest_api_document "/AWS::SupportApp::SlackWorkspaceConfiguration"

rest_property_map({
  team_id:    "TeamId",
  version_id: "VersionId",
})

rest_post_only_properties %i{
  team_id
}
