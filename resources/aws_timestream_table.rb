# Import API specifics
use "awscc_base"

resource_name :aws_timestream_table
provides :aws_timestream_table, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Timestream::Table resource creates a Timestream Table.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :database_name, String,
         required: true,
         callbacks: {
           "database_name is not a String" => lambda { |v| v.is_a? String },
           "database_name must match pattern ^[a-zA-Z0-9_.-]{3,256}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_.-]{3,256}$/") },
         },
         description: <<~'DESCRIPTION'
           The name for the database which the table to be created belongs to.
         DESCRIPTION

property :magnetic_store_write_properties, Hash,
         callbacks: {
           "Subproperty `EnableMagneticStoreWrites` is not a Boolean" => lambda { |v| v[:EnableMagneticStoreWrites].is_a? Boolean },
           "Subproperty `MagneticStoreRejectedDataLocation` is not a Object" => lambda { |v| v[:MagneticStoreRejectedDataLocation].is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The properties that determine whether magnetic store writes are enabled.
         DESCRIPTION

property :retention_properties, Hash,
         callbacks: {
           "Subproperty `MemoryStoreRetentionPeriodInHours` is not a String" => lambda { |v| v[:MemoryStoreRetentionPeriodInHours].is_a? String },
           "Subproperty `MagneticStoreRetentionPeriodInDays` is not a String" => lambda { |v| v[:MagneticStoreRetentionPeriodInDays].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The retention duration of the memory store and the magnetic store.
         DESCRIPTION

property :schema, Hash,
         description: <<~'DESCRIPTION'
           A Schema specifies the expected data model of the table.
         DESCRIPTION

property :table_name, String,
         callbacks: {
           "table_name is not a String" => lambda { |v| v.is_a? String },
           "table_name must match pattern ^[a-zA-Z0-9_.-]{3,256}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_.-]{3,256}$/") },
         },
         description: <<~'DESCRIPTION'
           The name for the table. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the table name.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Timestream::Table"
rest_api_document "/AWS::Timestream::Table"

rest_property_map({
  database_name:                   "DatabaseName",
  magnetic_store_write_properties: "MagneticStoreWriteProperties",
  retention_properties:            "RetentionProperties",
  schema:                          "Schema",
  table_name:                      "TableName",
  tags:                            "Tags",
})

rest_post_only_properties %i{
  database_name table_name
}
