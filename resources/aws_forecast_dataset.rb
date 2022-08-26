# Import API specifics
use "awscc_base"

resource_name :aws_forecast_dataset
provides :aws_forecast_dataset, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type Definition for AWS::Forecast::Dataset
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :data_frequency, String,
         callbacks: {
           "data_frequency is not a String" => lambda { |v| v.is_a? String },
           "data_frequency must match pattern ^Y|M|W|D|H|30min|15min|10min|5min|1min$" => lambda { |v| v =~ Regexp.new("/^Y|M|W|D|H|30min|15min|10min|5min|1min$/") },
         },
         description: "Frequency of data collection. This parameter is required for RELATED_TIME_SERIES"

property :dataset_name, String,
         required: true,
         callbacks: {
           "dataset_name is not a String" => lambda { |v| v.is_a? String },
           "dataset_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "dataset_name must match pattern ^[a-zA-Z][a-zA-Z0-9_]*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z][a-zA-Z0-9_]*/") },
         },
         description: "A name for the dataset"

property :dataset_type, String,
         required: true,
         callbacks: {
           "dataset_type is not a String" => lambda { |v| v.is_a? String },
           "dataset_typeis not one of `TARGET_TIME_SERIES`, `RELATED_TIME_SERIES`, `ITEM_METADATA`" => lambda { |v| %w{TARGET_TIME_SERIES RELATED_TIME_SERIES ITEM_METADATA}.include? v },
         },
         description: "The dataset type"

property :domain, String,
         required: true,
         callbacks: {
           "domain is not a String" => lambda { |v| v.is_a? String },
           "domainis not one of `RETAIL`, `CUSTOM`, `INVENTORY_PLANNING`, `EC2_CAPACITY`, `WORK_FORCE`, `WEB_TRAFFIC`, `METRICS`" => lambda { |v| %w{RETAIL CUSTOM INVENTORY_PLANNING EC2_CAPACITY WORK_FORCE WEB_TRAFFIC METRICS}.include? v },
         },
         description: "The domain associated with the dataset"

property :encryption_config, Hash,
         description: ""

property :schema, Hash,
         required: true,
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Forecast::Dataset"
rest_api_document "/AWS::Forecast::Dataset"

rest_property_map({
  data_frequency:    "DataFrequency",
  dataset_name:      "DatasetName",
  dataset_type:      "DatasetType",
  domain:            "Domain",
  encryption_config: "EncryptionConfig",
  schema:            "Schema",
  tags:              "Tags",
})

rest_post_only_properties %i{
  dataset_name
}
