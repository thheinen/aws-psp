# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_quicksight_data_set
provides :aws_quicksight_data_set, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of the AWS::QuickSight::DataSet Resource Type.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :aws_account_id, String,
         callbacks: {
           "aws_account_id is not a String" => lambda { |v| v.is_a? String },
           "aws_account_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
           "aws_account_id must match pattern ^[0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9]{12}$/") },
         },
         description: ""

property :column_groups, Array,
         callbacks: {
           "column_groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>Groupings of columns that work together in certain QuickSight features. Currently, only geospatial hierarchy is supported.</p>
         DESCRIPTION

property :column_level_permission_rules, Array,
         callbacks: {
           "column_level_permission_rules is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :data_set_id, String,
         callbacks: {
           "data_set_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :data_set_usage_configuration, Hash,
         callbacks: {
           "Subproperty `DisableUseAsDirectQuerySource` is not a Boolean" => lambda { |v| v[:DisableUseAsDirectQuerySource].is_a? Boolean },
           "Subproperty `DisableUseAsImportedSource` is not a Boolean" => lambda { |v| v[:DisableUseAsImportedSource].is_a? Boolean },
         },
         description: ""

property :field_folders, Hash,
         callbacks: {
           "field_folders is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :import_mode, Hash,
         callbacks: {
           "import_mode is not a String" => lambda { |v| v.is_a? String },
           "import_modeis not one of `SPICE`, `DIRECT_QUERY`" => lambda { |v| %w{SPICE DIRECT_QUERY}.include? v },
         },
         description: ""

property :ingestion_wait_policy, Hash,
         callbacks: {
           "Subproperty `WaitForSpiceIngestion` is not a Boolean" => lambda { |v| v[:WaitForSpiceIngestion].is_a? Boolean },
           "Subproperty `IngestionWaitTimeInHours` is not a Number" => lambda { |v| v[:IngestionWaitTimeInHours].is_a? Number },
         },
         description: ""

property :logical_table_map, Hash,
         callbacks: {
           "logical_table_map is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: <<~'DESCRIPTION'
           <p>The display name for the dataset.</p>
         DESCRIPTION

property :permissions, Array,
         callbacks: {
           "permissions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>A list of resource permissions on the dataset.</p>
         DESCRIPTION

property :physical_table_map, Hash,
         callbacks: {
           "physical_table_map is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :row_level_permission_data_set, Hash,
         callbacks: {
           "Subproperty `Arn` is not a String" => lambda { |v| v[:Arn].is_a? String },
           "Subproperty `Arn`is not a valid ARN" => lambda { |v| v[:Arn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `Namespace` is not a String" => lambda { |v| v[:Namespace].is_a? String },
           "Subproperty `Namespace` needs to be 0..64 characters" => lambda { |v| v[:Namespace].length >= 0 && v[:Namespace].length <= 64 },
           "Subproperty `Namespace` must match pattern ^[a-zA-Z0-9._-]*$" => lambda { |v| v[:Namespace] =~ Regexp.new("/^[a-zA-Z0-9._-]*$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>Contains a map of the key-value pairs for the resource tag or tags assigned to the dataset.</p>
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::QuickSight::DataSet"
rest_api_document "/AWS::QuickSight::DataSet"

rest_property_map({
  aws_account_id:                "AwsAccountId",
  column_groups:                 "ColumnGroups",
  column_level_permission_rules: "ColumnLevelPermissionRules",
  data_set_id:                   "DataSetId",
  data_set_usage_configuration:  "DataSetUsageConfiguration",
  field_folders:                 "FieldFolders",
  import_mode:                   "ImportMode",
  ingestion_wait_policy:         "IngestionWaitPolicy",
  logical_table_map:             "LogicalTableMap",
  name:                          "Name",
  permissions:                   "Permissions",
  physical_table_map:            "PhysicalTableMap",
  row_level_permission_data_set: "RowLevelPermissionDataSet",
  tags:                          "Tags",
})

rest_post_only_properties %i{
  aws_account_id data_set_id
}
