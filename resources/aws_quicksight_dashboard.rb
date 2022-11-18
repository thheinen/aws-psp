# Import API specifics
use "awscc_base"

resource_name :aws_quicksight_dashboard
provides :aws_quicksight_dashboard, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of the AWS::QuickSight::Dashboard Resource Type.
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

property :dashboard_id, String,
         required: true,
         callbacks: {
           "dashboard_id is not a String" => lambda { |v| v.is_a? String },
           "dashboard_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "dashboard_id must match pattern [\w\-]+" => lambda { |v| v =~ Regexp.new("/[\w\-]+/") },
         },
         description: ""

property :dashboard_publish_options, Hash,
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "name must match pattern [\u0020-\u00FF]+" => lambda { |v| v =~ Regexp.new("/[\u0020-\u00FF]+/") },
         },
         description: <<~'DESCRIPTION'
           <p>The display name of the dashboard.</p>
         DESCRIPTION

property :parameters, Hash,
         callbacks: {
           "Subproperty `StringParameters` is not a Array" => lambda { |v| v[:StringParameters].is_a? Array },
           "Subproperty `DecimalParameters` is not a Array" => lambda { |v| v[:DecimalParameters].is_a? Array },
           "Subproperty `IntegerParameters` is not a Array" => lambda { |v| v[:IntegerParameters].is_a? Array },
           "Subproperty `DateTimeParameters` is not a Array" => lambda { |v| v[:DateTimeParameters].is_a? Array },
         },
         description: ""

property :permissions, Array,
         callbacks: {
           "permissions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>A structure that contains the permissions of the dashboard. You can use this structure
      for granting permissions by providing a list of IAM action information for each
      principal ARN. </p>
            <p>To specify no permissions, omit the permissions list.</p>
         DESCRIPTION

property :source_entity, Hash,
         required: true,
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>Contains a map of the key-value pairs for the resource tag or tags assigned to the
      dashboard.</p>
         DESCRIPTION

property :theme_arn, String,
         callbacks: {
           "theme_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           <p>The Amazon Resource Name (ARN) of the theme that is being used for this dashboard. If
      you add a value for this field, it overrides the value that is used in the source
      entity. The theme ARN must exist in the same AWS account where you create the
      dashboard.</p>
         DESCRIPTION

property :version_description, String,
         callbacks: {
           "version_description is not a String" => lambda { |v| v.is_a? String },
           "version_description needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
         },
         description: <<~'DESCRIPTION'
           <p>A description for the first version of the dashboard being created.</p>
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::QuickSight::Dashboard"
rest_api_document "/AWS::QuickSight::Dashboard"

rest_property_map({
  aws_account_id:            "AwsAccountId",
  dashboard_id:              "DashboardId",
  dashboard_publish_options: "DashboardPublishOptions",
  name:                      "Name",
  parameters:                "Parameters",
  permissions:               "Permissions",
  source_entity:             "SourceEntity",
  tags:                      "Tags",
  theme_arn:                 "ThemeArn",
  version_description:       "VersionDescription",
})

rest_post_only_properties %i{
  aws_account_id dashboard_id
}
