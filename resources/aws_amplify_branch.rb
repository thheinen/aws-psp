# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_amplify_branch
provides :aws_amplify_branch, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Amplify::Branch resource creates a new branch within an app.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :app_id, String,
         required: true,
         callbacks: {
           "app_id is not a String" => lambda { |v| v.is_a? String },
           "app_id needs to be 1..20 characters" => lambda { |v| v.length >= 1 && v.length <= 20 },
           "app_id must match pattern d[a-z0-9]+" => lambda { |v| v =~ Regexp.new("/d[a-z0-9]+/") },
         },
         description: ""

property :basic_auth_config, Hash,
         callbacks: {
           "Subproperty `EnableBasicAuth` is not a Boolean" => lambda { |v| v[:EnableBasicAuth].is_a? Boolean },
           "Subproperty `Username` is not a String" => lambda { |v| v[:Username].is_a? String },
           "Subproperty `Username` needs to be 1..255 characters" => lambda { |v| v[:Username].length >= 1 && v[:Username].length <= 255 },
           "Subproperty `Password` is not a String" => lambda { |v| v[:Password].is_a? String },
           "Subproperty `Password` needs to be 1..255 characters" => lambda { |v| v[:Password].length >= 1 && v[:Password].length <= 255 },
         },
         description: ""

property :branch_name, String,
         required: true,
         callbacks: {
           "branch_name is not a String" => lambda { |v| v.is_a? String },
           "branch_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "branch_name must match pattern (?s).+" => lambda { |v| v =~ Regexp.new("/(?s).+/") },
         },
         description: ""

property :build_spec, String,
         callbacks: {
           "build_spec is not a String" => lambda { |v| v.is_a? String },
           "build_spec needs to be 1..25000 characters" => lambda { |v| v.length >= 1 && v.length <= 25000 },
           "build_spec must match pattern (?s).+" => lambda { |v| v =~ Regexp.new("/(?s).+/") },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern (?s).*" => lambda { |v| v =~ Regexp.new("/(?s).*/") },
         },
         description: ""

property :enable_auto_build, [TrueClass, FalseClass],
         callbacks: {
           "enable_auto_build is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :enable_performance_mode, [TrueClass, FalseClass],
         callbacks: {
           "enable_performance_mode is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :enable_pull_request_preview, [TrueClass, FalseClass],
         callbacks: {
           "enable_pull_request_preview is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :environment_variables, Array,
         callbacks: {
           "environment_variables is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :pull_request_environment_name, String,
         callbacks: {
           "pull_request_environment_name is not a String" => lambda { |v| v.is_a? String },
           "pull_request_environment_name must match pattern (?s).*" => lambda { |v| v =~ Regexp.new("/(?s).*/") },
         },
         description: ""

property :stage, String,
         callbacks: {
           "stage is not a String" => lambda { |v| v.is_a? String },
           "stageis not one of `EXPERIMENTAL`, `BETA`, `PULL_REQUEST`, `PRODUCTION`, `DEVELOPMENT`" => lambda { |v| %w{EXPERIMENTAL BETA PULL_REQUEST PRODUCTION DEVELOPMENT}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Amplify::Branch"
rest_api_document "/AWS::Amplify::Branch"

rest_property_map({
  app_id:                        "AppId",
  basic_auth_config:             "BasicAuthConfig",
  branch_name:                   "BranchName",
  build_spec:                    "BuildSpec",
  description:                   "Description",
  enable_auto_build:             "EnableAutoBuild",
  enable_performance_mode:       "EnablePerformanceMode",
  enable_pull_request_preview:   "EnablePullRequestPreview",
  environment_variables:         "EnvironmentVariables",
  pull_request_environment_name: "PullRequestEnvironmentName",
  stage:                         "Stage",
  tags:                          "Tags",
})

rest_post_only_properties %i{
  app_id branch_name
}
