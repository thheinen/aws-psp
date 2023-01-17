# Import API specifics
use "awscc_base"

resource_name :aws_forecast_dataset_group
provides :aws_forecast_dataset_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents a dataset group that holds a collection of related datasets
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :dataset_arns, Array,
         callbacks: {
           "dataset_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of Amazon Resource Names (ARNs) of the datasets that you want to include in the dataset group.
         DESCRIPTION

property :dataset_group_name, String,
         required: true,
         callbacks: {
           "dataset_group_name is not a String" => lambda { |v| v.is_a? String },
           "dataset_group_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "dataset_group_name must match pattern ^[a-zA-Z][a-zA-Z0-9_]*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z][a-zA-Z0-9_]*/") },
         },
         description: <<~'DESCRIPTION'
           A name for the dataset group.
         DESCRIPTION

property :domain, String,
         required: true,
         callbacks: {
           "domain is not a String" => lambda { |v| v.is_a? String },
           "domainis not one of `RETAIL`, `CUSTOM`, `INVENTORY_PLANNING`, `EC2_CAPACITY`, `WORK_FORCE`, `WEB_TRAFFIC`, `METRICS`" => lambda { |v| %w{RETAIL CUSTOM INVENTORY_PLANNING EC2_CAPACITY WORK_FORCE WEB_TRAFFIC METRICS}.include? v },
         },
         description: <<~'DESCRIPTION'
           The domain associated with the dataset group. When you add a dataset to a dataset group, this value and the value specified for the Domain parameter of the CreateDataset operation must match.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags of Application Insights application.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Forecast::DatasetGroup"
rest_api_document "/AWS::Forecast::DatasetGroup"

rest_property_map({
  dataset_arns:       "DatasetArns",
  dataset_group_name: "DatasetGroupName",
  domain:             "Domain",
  tags:               "Tags",
})

rest_post_only_properties %i{
  dataset_group_name
}
