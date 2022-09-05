# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_athena_data_catalog
provides :aws_athena_data_catalog, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Athena::DataCatalog
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           A description of the data catalog to be created.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           The name of the data catalog to create. The catalog name must be unique for the AWS account and can use a maximum of 128 alphanumeric, underscore, at sign, or hyphen characters.
         DESCRIPTION

property :parameters, Hash,
         callbacks: {
           "parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Specifies the Lambda function or functions to use for creating the data catalog. This is a mapping whose values depend on the catalog type.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of comma separated tags to add to the data catalog that is created.
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `LAMBDA`, `GLUE`, `HIVE`" => lambda { |v| %w{LAMBDA GLUE HIVE}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of data catalog to create: LAMBDA for a federated catalog, GLUE for AWS Glue Catalog, or HIVE for an external hive metastore.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Athena::DataCatalog"
rest_api_document "/AWS::Athena::DataCatalog"

rest_property_map({
  description: "Description",
  name:        "Name",
  parameters:  "Parameters",
  tags:        "Tags",
  type:        "Type",
})

rest_post_only_properties %i{
  name
}
