# Import API specifics
use "awscc_base"

resource_name :aws_location_route_calculator
provides :aws_location_route_calculator, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Location::RouteCalculator Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :calculator_name, String,
         required: true,
         callbacks: {
           "calculator_name is not a String" => lambda { |v| v.is_a? String },
           "calculator_name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "calculator_name must match pattern ^[-._\w]+$" => lambda { |v| v =~ Regexp.new("/^[-._\w]+$/") },
         },
         description: ""

property :data_source, String,
         required: true,
         callbacks: {
           "data_source is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..1000 characters" => lambda { |v| v.length >= 0 && v.length <= 1000 },
         },
         description: ""

property :pricing_plan, Hash,
         callbacks: {
           "pricing_plan is not a String" => lambda { |v| v.is_a? String },
           "pricing_planis not one of `RequestBasedUsage`" => lambda { |v| %w{RequestBasedUsage}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Location::RouteCalculator"
rest_api_document "/AWS::Location::RouteCalculator"

rest_property_map({
  calculator_name: "CalculatorName",
  data_source:     "DataSource",
  description:     "Description",
  pricing_plan:    "PricingPlan",
})

rest_post_only_properties %i{
  calculator_name data_source description pricing_plan
}
