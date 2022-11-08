# Import API specifics
use "awscc_base"

resource_name :aws_lakeformation_data_cells_filter
provides :aws_lakeformation_data_cells_filter, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A resource schema representing a Lake Formation Data Cells Filter.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :column_names, Hash,
         callbacks: {
           "column_names is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of columns to be included in this Data Cells Filter.
         DESCRIPTION

property :column_wildcard, Hash,
         description: <<~'DESCRIPTION'
           An object representing the Data Cells Filter's Columns. Either Column Names or a Wildcard is required
         DESCRIPTION

property :database_name, Hash,
         required: true,
         callbacks: {
           "database_name is not a String" => lambda { |v| v.is_a? String },
           "database_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The name of the Database that the Table resides in.
         DESCRIPTION

property :name, Hash,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The desired name of the Data Cells Filter.
         DESCRIPTION

property :row_filter, Hash,
         callbacks: {
           "Subproperty `FilterExpression` is not a String" => lambda { |v| v[:FilterExpression].is_a? String },
           "Subproperty `AllRowsWildcard` is not a Object" => lambda { |v| v[:AllRowsWildcard].is_a? Object },
         },
         description: <<~'DESCRIPTION'
           An object representing the Data Cells Filter's Row Filter. Either a Filter Expression or a Wildcard is required
         DESCRIPTION

property :table_catalog_id, Hash,
         required: true,
         callbacks: {
           "table_catalog_id is not a String" => lambda { |v| v.is_a? String },
           "table_catalog_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
         },
         description: <<~'DESCRIPTION'
           The Catalog Id of the Table on which to create a Data Cells Filter.
         DESCRIPTION

property :table_name, Hash,
         required: true,
         callbacks: {
           "table_name is not a String" => lambda { |v| v.is_a? String },
           "table_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The name of the Table to create a Data Cells Filter for.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::LakeFormation::DataCellsFilter"
rest_api_document "/AWS::LakeFormation::DataCellsFilter"

rest_property_map({
  column_names:     "ColumnNames",
  column_wildcard:  "ColumnWildcard",
  database_name:    "DatabaseName",
  name:             "Name",
  row_filter:       "RowFilter",
  table_catalog_id: "TableCatalogId",
  table_name:       "TableName",
})

rest_post_only_properties %i{
  column_names column_wildcard database_name name row_filter table_catalog_id table_name
}
