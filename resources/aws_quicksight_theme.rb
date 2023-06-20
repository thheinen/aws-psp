# Import API specifics
use "awscc_base"

resource_name :aws_quicksight_theme
provides :aws_quicksight_theme, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of the AWS::QuickSight::Theme Resource Type.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :aws_account_id, String,
         required: true,
         callbacks: {
           "aws_account_id is not a String" => lambda { |v| v.is_a? String },
           "aws_account_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
           "aws_account_id must match pattern ^[0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9]{12}$/") },
         },
         description: ""

property :base_theme_id, String,
         required: true,
         callbacks: {
           "base_theme_id is not a String" => lambda { |v| v.is_a? String },
           "base_theme_id needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "base_theme_id must match pattern [\w\-]+" => lambda { |v| v =~ Regexp.new("/[\w\-]+/") },
         },
         description: ""

property :configuration, Hash,
         required: true,
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :permissions, Array,
         callbacks: {
           "permissions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :theme_id, String,
         required: true,
         callbacks: {
           "theme_id is not a String" => lambda { |v| v.is_a? String },
           "theme_id needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "theme_id must match pattern [\w\-]+" => lambda { |v| v =~ Regexp.new("/[\w\-]+/") },
         },
         description: ""

property :version_description, String,
         callbacks: {
           "version_description is not a String" => lambda { |v| v.is_a? String },
           "version_description needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::QuickSight::Theme"
rest_api_document "/AWS::QuickSight::Theme"

rest_property_map({
  aws_account_id:      "AwsAccountId",
  base_theme_id:       "BaseThemeId",
  configuration:       "Configuration",
  name:                "Name",
  permissions:         "Permissions",
  tags:                "Tags",
  theme_id:            "ThemeId",
  version_description: "VersionDescription",
})

rest_post_only_properties %i{
  aws_account_id theme_id
}
