# Import API specifics
use "awscc_base"

resource_name :aws_location_place_index
provides :aws_location_place_index, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Location::PlaceIndex Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :data_source, String,
         required: true,
         callbacks: {
           "data_source is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :data_source_configuration, Hash,
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..1000 characters" => lambda { |v| v.length >= 0 && v.length <= 1000 },
         },
         description: ""

property :index_name, String,
         required: true,
         callbacks: {
           "index_name is not a String" => lambda { |v| v.is_a? String },
           "index_name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "index_name must match pattern ^[-._\w]+$" => lambda { |v| v =~ Regexp.new("/^[-._\w]+$/") },
         },
         description: ""

property :pricing_plan, Hash,
         callbacks: {
           "pricing_plan is not a String" => lambda { |v| v.is_a? String },
           "pricing_planis not one of `RequestBasedUsage`" => lambda { |v| %w{RequestBasedUsage}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Location::PlaceIndex"
rest_api_document "/AWS::Location::PlaceIndex"

rest_property_map({
  data_source:               "DataSource",
  data_source_configuration: "DataSourceConfiguration",
  description:               "Description",
  index_name:                "IndexName",
  pricing_plan:              "PricingPlan",
})

rest_post_only_properties %i{
  data_source data_source_configuration description index_name pricing_plan
}
