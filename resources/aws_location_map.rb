# Import API specifics
use "awscc_base"

resource_name :aws_location_map
provides :aws_location_map, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Location::Map Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `Style` is not a String" => lambda { |v| v[:Style].is_a? String },
           "Subproperty `Style` needs to be 1..100 characters" => lambda { |v| v[:Style].length >= 1 && v[:Style].length <= 100 },
           "Subproperty `Style` must match pattern ^[-._\w]+$" => lambda { |v| v[:Style] =~ Regexp.new("/^[-._\w]+$/") },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..1000 characters" => lambda { |v| v.length >= 0 && v.length <= 1000 },
         },
         description: ""

property :map_name, String,
         required: true,
         callbacks: {
           "map_name is not a String" => lambda { |v| v.is_a? String },
           "map_name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "map_name must match pattern ^[-._\w]+$" => lambda { |v| v =~ Regexp.new("/^[-._\w]+$/") },
         },
         description: ""

property :pricing_plan, Hash,
         callbacks: {
           "pricing_plan is not a String" => lambda { |v| v.is_a? String },
           "pricing_planis not one of `RequestBasedUsage`" => lambda { |v| %w{RequestBasedUsage}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Location::Map"
rest_api_document "/AWS::Location::Map"

rest_property_map({
  configuration: "Configuration",
  description:   "Description",
  map_name:      "MapName",
  pricing_plan:  "PricingPlan",
})

rest_post_only_properties %i{
  configuration description map_name pricing_plan
}
