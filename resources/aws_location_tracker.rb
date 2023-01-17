# Import API specifics
use "awscc_base"

resource_name :aws_location_tracker
provides :aws_location_tracker, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Location::Tracker Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..1000 characters" => lambda { |v| v.length >= 0 && v.length <= 1000 },
         },
         description: ""

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
           "kms_key_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :position_filtering, Hash,
         callbacks: {
           "position_filtering is not a String" => lambda { |v| v.is_a? String },
           "position_filteringis not one of `TimeBased`, `DistanceBased`, `AccuracyBased`" => lambda { |v| %w{TimeBased DistanceBased AccuracyBased}.include? v },
         },
         description: ""

property :pricing_plan, Hash,
         callbacks: {
           "pricing_plan is not a String" => lambda { |v| v.is_a? String },
           "pricing_planis not one of `RequestBasedUsage`" => lambda { |v| %w{RequestBasedUsage}.include? v },
         },
         description: ""

property :pricing_plan_data_source, String,
         callbacks: {
           "pricing_plan_data_source is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tracker_name, String,
         required: true,
         callbacks: {
           "tracker_name is not a String" => lambda { |v| v.is_a? String },
           "tracker_name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "tracker_name must match pattern ^[-._\w]+$" => lambda { |v| v =~ Regexp.new("/^[-._\w]+$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Location::Tracker"
rest_api_document "/AWS::Location::Tracker"

rest_property_map({
  description:              "Description",
  kms_key_id:               "KmsKeyId",
  position_filtering:       "PositionFiltering",
  pricing_plan:             "PricingPlan",
  pricing_plan_data_source: "PricingPlanDataSource",
  tracker_name:             "TrackerName",
})

rest_post_only_properties %i{
  description kms_key_id position_filtering pricing_plan tracker_name
}
