# Import API specifics
use "awscc_base"

resource_name :aws_personalize_dataset
provides :aws_personalize_dataset, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Personalize::Dataset.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :dataset_group_arn, String,
         required: true,
         callbacks: {
           "dataset_group_arn is not a String" => lambda { |v| v.is_a? String },
           "dataset_group_arn must match pattern arn:([a-z\d-]+):personalize:.*:.*:.+" => lambda { |v| v =~ Regexp.new("/arn:([a-z\d-]+):personalize:.*:.*:.+/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the dataset group to add the dataset to
         DESCRIPTION

property :dataset_import_job, Hash,
         callbacks: {
           "Subproperty `JobName` is not a String" => lambda { |v| v[:JobName].is_a? String },
           "Subproperty `JobName` needs to be 1..63 characters" => lambda { |v| v[:JobName].length >= 1 && v[:JobName].length <= 63 },
           "Subproperty `JobName` must match pattern ^[a-zA-Z0-9][a-zA-Z0-9\-_]*" => lambda { |v| v[:JobName] =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9\-_]*/") },
           "Subproperty `DatasetImportJobArn` is not a String" => lambda { |v| v[:DatasetImportJobArn].is_a? String },
           "Subproperty `DatasetImportJobArn` must match pattern arn:([a-z\d-]+):personalize:.*:.*:.+" => lambda { |v| v[:DatasetImportJobArn] =~ Regexp.new("/arn:([a-z\d-]+):personalize:.*:.*:.+/") },
           "Subproperty `DatasetImportJobArn`is not a valid ARN" => lambda { |v| v[:DatasetImportJobArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `DatasetArn` is not a String" => lambda { |v| v[:DatasetArn].is_a? String },
           "Subproperty `DatasetArn` must match pattern arn:([a-z\d-]+):personalize:.*:.*:.+" => lambda { |v| v[:DatasetArn] =~ Regexp.new("/arn:([a-z\d-]+):personalize:.*:.*:.+/") },
           "Subproperty `DatasetArn`is not a valid ARN" => lambda { |v| v[:DatasetArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `DataSource` is not a Object" => lambda { |v| v[:DataSource].is_a? Object },
           "Subproperty `RoleArn` is not a String" => lambda { |v| v[:RoleArn].is_a? String },
           "Subproperty `RoleArn` must match pattern arn:([a-z\d-]+):iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+" => lambda { |v| v[:RoleArn] =~ Regexp.new("/arn:([a-z\d-]+):iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+/") },
           "Subproperty `RoleArn`is not a valid ARN" => lambda { |v| v[:RoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :dataset_type, String,
         required: true,
         callbacks: {
           "dataset_type is not a String" => lambda { |v| v.is_a? String },
           "dataset_typeis not one of `Interactions`, `Items`, `Users`" => lambda { |v| %w{Interactions Items Users}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of dataset
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "name must match pattern ^[a-zA-Z0-9][a-zA-Z0-9\-_]*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9\-_]*/") },
         },
         description: <<~'DESCRIPTION'
           The name for the dataset
         DESCRIPTION

property :schema_arn, String,
         required: true,
         callbacks: {
           "schema_arn is not a String" => lambda { |v| v.is_a? String },
           "schema_arn must match pattern arn:([a-z\d-]+):personalize:.*:.*:.+" => lambda { |v| v =~ Regexp.new("/arn:([a-z\d-]+):personalize:.*:.*:.+/") },
         },
         description: <<~'DESCRIPTION'
           The ARN of the schema to associate with the dataset. The schema defines the dataset fields.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Personalize::Dataset"
rest_api_document "/AWS::Personalize::Dataset"

rest_property_map({
  dataset_group_arn:  "DatasetGroupArn",
  dataset_import_job: "DatasetImportJob",
  dataset_type:       "DatasetType",
  name:               "Name",
  schema_arn:         "SchemaArn",
})

rest_post_only_properties %i{
  dataset_group_arn dataset_type name schema_arn
}
