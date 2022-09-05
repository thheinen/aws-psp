# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_amplify_app
provides :aws_amplify_app, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Amplify::App resource creates Apps in the Amplify Console. An App is a collection of branches.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_token, String,
         callbacks: {
           "access_token is not a String" => lambda { |v| v.is_a? String },
           "access_token needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: ""

property :auto_branch_creation_config, Hash,
         callbacks: {
           "Subproperty `AutoBranchCreationPatterns` is not a Array" => lambda { |v| v[:AutoBranchCreationPatterns].is_a? Array },
           "Subproperty `BuildSpec` is not a String" => lambda { |v| v[:BuildSpec].is_a? String },
           "Subproperty `BuildSpec` needs to be 1..25000 characters" => lambda { |v| v[:BuildSpec].length >= 1 && v[:BuildSpec].length <= 25000 },
           "Subproperty `EnableAutoBranchCreation` is not a Boolean" => lambda { |v| v[:EnableAutoBranchCreation].is_a? Boolean },
           "Subproperty `EnableAutoBuild` is not a Boolean" => lambda { |v| v[:EnableAutoBuild].is_a? Boolean },
           "Subproperty `EnablePerformanceMode` is not a Boolean" => lambda { |v| v[:EnablePerformanceMode].is_a? Boolean },
           "Subproperty `EnablePullRequestPreview` is not a Boolean" => lambda { |v| v[:EnablePullRequestPreview].is_a? Boolean },
           "Subproperty `EnvironmentVariables` is not a Array" => lambda { |v| v[:EnvironmentVariables].is_a? Array },
           "Subproperty `PullRequestEnvironmentName` is not a String" => lambda { |v| v[:PullRequestEnvironmentName].is_a? String },
           "Subproperty `PullRequestEnvironmentName` must match pattern (?s).*" => lambda { |v| v[:PullRequestEnvironmentName] =~ Regexp.new("/(?s).*/") },
           "Subproperty `Stage` is not a String" => lambda { |v| v[:Stage].is_a? String },
           "Subproperty `Stage`is not one of `EXPERIMENTAL`, `BETA`, `PULL_REQUEST`, `PRODUCTION`, `DEVELOPMENT`" => lambda { |v| %w{EXPERIMENTAL BETA PULL_REQUEST PRODUCTION DEVELOPMENT}.include? v[:Stage] },
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

property :build_spec, String,
         callbacks: {
           "build_spec is not a String" => lambda { |v| v.is_a? String },
           "build_spec needs to be 1..25000 characters" => lambda { |v| v.length >= 1 && v.length <= 25000 },
           "build_spec must match pattern (?s).+" => lambda { |v| v =~ Regexp.new("/(?s).+/") },
         },
         description: ""

property :custom_headers, String,
         callbacks: {
           "custom_headers is not a String" => lambda { |v| v.is_a? String },
           "custom_headers needs to be 0..25000 characters" => lambda { |v| v.length >= 0 && v.length <= 25000 },
           "custom_headers must match pattern (?s).*" => lambda { |v| v =~ Regexp.new("/(?s).*/") },
         },
         description: ""

property :custom_rules, Array,
         callbacks: {
           "custom_rules is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern (?s).*" => lambda { |v| v =~ Regexp.new("/(?s).*/") },
         },
         description: ""

property :enable_branch_auto_deletion, [TrueClass, FalseClass],
         callbacks: {
           "enable_branch_auto_deletion is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :environment_variables, Array,
         callbacks: {
           "environment_variables is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :iam_service_role, String,
         callbacks: {
           "iam_service_role is not a String" => lambda { |v| v.is_a? String },
           "iam_service_role needs to be 1..1000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000 },
           "iam_service_role must match pattern (?s).*" => lambda { |v| v =~ Regexp.new("/(?s).*/") },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "name must match pattern (?s).+" => lambda { |v| v =~ Regexp.new("/(?s).+/") },
         },
         description: ""

property :oauth_token, String,
         callbacks: {
           "oauth_token is not a String" => lambda { |v| v.is_a? String },
           "oauth_token must match pattern (?s).*" => lambda { |v| v =~ Regexp.new("/(?s).*/") },
         },
         description: ""

property :repository, String,
         callbacks: {
           "repository is not a String" => lambda { |v| v.is_a? String },
           "repository must match pattern (?s).*" => lambda { |v| v =~ Regexp.new("/(?s).*/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Amplify::App"
rest_api_document "/AWS::Amplify::App"

rest_property_map({
  access_token:                "AccessToken",
  auto_branch_creation_config: "AutoBranchCreationConfig",
  basic_auth_config:           "BasicAuthConfig",
  build_spec:                  "BuildSpec",
  custom_headers:              "CustomHeaders",
  custom_rules:                "CustomRules",
  description:                 "Description",
  enable_branch_auto_deletion: "EnableBranchAutoDeletion",
  environment_variables:       "EnvironmentVariables",
  iam_service_role:            "IAMServiceRole",
  name:                        "Name",
  oauth_token:                 "OauthToken",
  repository:                  "Repository",
  tags:                        "Tags",
})

