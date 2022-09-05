# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_databrew_job
provides :aws_databrew_job, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataBrew::Job.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :data_catalog_outputs, Array,
         callbacks: {
           "data_catalog_outputs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :database_outputs, Array,
         callbacks: {
           "database_outputs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :dataset_name, String,
         callbacks: {
           "dataset_name is not a String" => lambda { |v| v.is_a? String },
           "dataset_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           Dataset name
         DESCRIPTION

property :encryption_key_arn, String,
         callbacks: {
           "encryption_key_arn is not a String" => lambda { |v| v.is_a? String },
           "encryption_key_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           Encryption Key Arn
         DESCRIPTION

property :encryption_mode, String,
         callbacks: {
           "encryption_mode is not a String" => lambda { |v| v.is_a? String },
           "encryption_modeis not one of `SSE-KMS`, `SSE-S3`" => lambda { |v| %w{SSE-KMS SSE-S3}.include? v },
         },
         description: <<~'DESCRIPTION'
           Encryption mode
         DESCRIPTION

property :job_sample, Hash,
         description: <<~'DESCRIPTION'
           Job Sample
         DESCRIPTION

property :log_subscription, String,
         callbacks: {
           "log_subscription is not a String" => lambda { |v| v.is_a? String },
           "log_subscriptionis not one of `ENABLE`, `DISABLE`" => lambda { |v| %w{ENABLE DISABLE}.include? v },
         },
         description: <<~'DESCRIPTION'
           Log subscription
         DESCRIPTION

property :max_capacity, Integer,
         callbacks: {
           "max_capacity is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Max capacity
         DESCRIPTION

property :max_retries, Integer,
         callbacks: {
           "max_retries is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Max retries
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           Job name
         DESCRIPTION

property :output_location, Hash,
         callbacks: {
           "Subproperty `Bucket` is not a String" => lambda { |v| v[:Bucket].is_a? String },
           "Subproperty `Key` is not a String" => lambda { |v| v[:Key].is_a? String },
           "Subproperty `BucketOwner` is not a String" => lambda { |v| v[:BucketOwner].is_a? String },
           "Subproperty `BucketOwner` needs to be 12..12 characters" => lambda { |v| v[:BucketOwner].length >= 12 && v[:BucketOwner].length <= 12 },
         },
         description: <<~'DESCRIPTION'
           Output location
         DESCRIPTION

property :outputs, Array,
         callbacks: {
           "outputs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :profile_configuration, Hash,
         callbacks: {
           "Subproperty `ProfileColumns` is not a Array" => lambda { |v| v[:ProfileColumns].is_a? Array },
           "Subproperty `ColumnStatisticsConfigurations` is not a Array" => lambda { |v| v[:ColumnStatisticsConfigurations].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Profile Job configuration
         DESCRIPTION

property :project_name, String,
         callbacks: {
           "project_name is not a String" => lambda { |v| v.is_a? String },
           "project_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           Project name
         DESCRIPTION

property :recipe, Hash,
         callbacks: {
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
         },
         description: ""

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Role arn
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :timeout, Integer,
         callbacks: {
           "timeout is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Timeout
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `PROFILE`, `RECIPE`" => lambda { |v| %w{PROFILE RECIPE}.include? v },
         },
         description: <<~'DESCRIPTION'
           Job type
         DESCRIPTION

property :validation_configurations, Array,
         callbacks: {
           "validation_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Data quality rules configuration
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DataBrew::Job"
rest_api_document "/AWS::DataBrew::Job"

rest_property_map({
  data_catalog_outputs:      "DataCatalogOutputs",
  database_outputs:          "DatabaseOutputs",
  dataset_name:              "DatasetName",
  encryption_key_arn:        "EncryptionKeyArn",
  encryption_mode:           "EncryptionMode",
  job_sample:                "JobSample",
  log_subscription:          "LogSubscription",
  max_capacity:              "MaxCapacity",
  max_retries:               "MaxRetries",
  name:                      "Name",
  output_location:           "OutputLocation",
  outputs:                   "Outputs",
  profile_configuration:     "ProfileConfiguration",
  project_name:              "ProjectName",
  recipe:                    "Recipe",
  role_arn:                  "RoleArn",
  tags:                      "Tags",
  timeout:                   "Timeout",
  type:                      "Type",
  validation_configurations: "ValidationConfigurations",
})

rest_post_only_properties %i{
  name tags type
}
