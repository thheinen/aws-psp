# Import API specifics
use "awscc_base"

resource_name :aws_quicksight_template
provides :aws_quicksight_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of the AWS::QuickSight::Template Resource Type.
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

property :definition, Hash,
         callbacks: {
           "Subproperty `DataSetConfigurations` is not a Array" => lambda { |v| v[:DataSetConfigurations].is_a? Array },
           "Subproperty `Sheets` is not a Array" => lambda { |v| v[:Sheets].is_a? Array },
           "Subproperty `CalculatedFields` is not a Array" => lambda { |v| v[:CalculatedFields].is_a? Array },
           "Subproperty `ParameterDeclarations` is not a Array" => lambda { |v| v[:ParameterDeclarations].is_a? Array },
           "Subproperty `FilterGroups` is not a Array" => lambda { |v| v[:FilterGroups].is_a? Array },
           "Subproperty `ColumnConfigurations` is not a Array" => lambda { |v| v[:ColumnConfigurations].is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
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

property :source_entity, Hash,
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :template_id, String,
         required: true,
         callbacks: {
           "template_id is not a String" => lambda { |v| v.is_a? String },
           "template_id needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "template_id must match pattern [\w\-]+" => lambda { |v| v =~ Regexp.new("/[\w\-]+/") },
         },
         description: ""

property :version_description, String,
         callbacks: {
           "version_description is not a String" => lambda { |v| v.is_a? String },
           "version_description needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::QuickSight::Template"
rest_api_document "/AWS::QuickSight::Template"

rest_property_map({
  aws_account_id:      "AwsAccountId",
  definition:          "Definition",
  name:                "Name",
  permissions:         "Permissions",
  source_entity:       "SourceEntity",
  tags:                "Tags",
  template_id:         "TemplateId",
  version_description: "VersionDescription",
})

rest_post_only_properties %i{
  aws_account_id template_id
}
