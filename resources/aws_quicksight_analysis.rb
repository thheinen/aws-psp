# Import API specifics
use "awscc_base"

resource_name :aws_quicksight_analysis
provides :aws_quicksight_analysis, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of the AWS::QuickSight::Analysis Resource Type.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :analysis_id, String,
         required: true,
         callbacks: {
           "analysis_id is not a String" => lambda { |v| v.is_a? String },
           "analysis_id needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "analysis_id must match pattern [\w\-]+" => lambda { |v| v =~ Regexp.new("/[\w\-]+/") },
         },
         description: ""

property :aws_account_id, String,
         required: true,
         callbacks: {
           "aws_account_id is not a String" => lambda { |v| v.is_a? String },
           "aws_account_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
           "aws_account_id must match pattern ^[0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9]{12}$/") },
         },
         description: ""

property :definition, Hash,
         callbacks: {
           "Subproperty `DataSetIdentifierDeclarations` is not a Array" => lambda { |v| v[:DataSetIdentifierDeclarations].is_a? Array },
           "Subproperty `Sheets` is not a Array" => lambda { |v| v[:Sheets].is_a? Array },
           "Subproperty `CalculatedFields` is not a Array" => lambda { |v| v[:CalculatedFields].is_a? Array },
           "Subproperty `ParameterDeclarations` is not a Array" => lambda { |v| v[:ParameterDeclarations].is_a? Array },
           "Subproperty `FilterGroups` is not a Array" => lambda { |v| v[:FilterGroups].is_a? Array },
           "Subproperty `ColumnConfigurations` is not a Array" => lambda { |v| v[:ColumnConfigurations].is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :parameters, Hash,
         callbacks: {
           "Subproperty `StringParameters` is not a Array" => lambda { |v| v[:StringParameters].is_a? Array },
           "Subproperty `IntegerParameters` is not a Array" => lambda { |v| v[:IntegerParameters].is_a? Array },
           "Subproperty `DecimalParameters` is not a Array" => lambda { |v| v[:DecimalParameters].is_a? Array },
           "Subproperty `DateTimeParameters` is not a Array" => lambda { |v| v[:DateTimeParameters].is_a? Array },
         },
         description: ""

property :permissions, Array,
         callbacks: {
           "permissions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :source_entity, Hash,
         description: ""

property :status, Hash,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `CREATION_IN_PROGRESS`, `CREATION_SUCCESSFUL`, `CREATION_FAILED`, `UPDATE_IN_PROGRESS`, `UPDATE_SUCCESSFUL`, `UPDATE_FAILED`, `DELETED`" => lambda { |v| %w{CREATION_IN_PROGRESS CREATION_SUCCESSFUL CREATION_FAILED UPDATE_IN_PROGRESS UPDATE_SUCCESSFUL UPDATE_FAILED DELETED}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :theme_arn, String,
         callbacks: {
           "theme_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::QuickSight::Analysis"
rest_api_document "/AWS::QuickSight::Analysis"

rest_property_map({
  analysis_id:    "AnalysisId",
  aws_account_id: "AwsAccountId",
  definition:     "Definition",
  name:           "Name",
  parameters:     "Parameters",
  permissions:    "Permissions",
  source_entity:  "SourceEntity",
  status:         "Status",
  tags:           "Tags",
  theme_arn:      "ThemeArn",
})

rest_post_only_properties %i{
  analysis_id aws_account_id
}
