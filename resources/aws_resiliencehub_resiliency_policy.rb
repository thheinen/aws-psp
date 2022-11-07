# Import API specifics
use "awscc_base"

resource_name :aws_resiliencehub_resiliency_policy
provides :aws_resiliencehub_resiliency_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type Definition for Resiliency Policy.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :data_location_constraint, String,
         callbacks: {
           "data_location_constraint is not a String" => lambda { |v| v.is_a? String },
           "data_location_constraintis not one of `AnyLocation`, `SameContinent`, `SameCountry`" => lambda { |v| %w{AnyLocation SameContinent SameCountry}.include? v },
         },
         description: <<~'DESCRIPTION'
           Data Location Constraint of the Policy.
         DESCRIPTION

property :policy, Hash,
         required: true,
         callbacks: {
           "policy is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :policy_description, String,
         callbacks: {
           "policy_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Description of Resiliency Policy.
         DESCRIPTION

property :policy_name, String,
         required: true,
         callbacks: {
           "policy_name is not a String" => lambda { |v| v.is_a? String },
           "policy_name must match pattern ^[A-Za-z0-9][A-Za-z0-9_\-]{1,59}$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9][A-Za-z0-9_\-]{1,59}$/") },
         },
         description: <<~'DESCRIPTION'
           Name of Resiliency Policy.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :tier, String,
         required: true,
         callbacks: {
           "tier is not a String" => lambda { |v| v.is_a? String },
           "tieris not one of `MissionCritical`, `Critical`, `Important`, `CoreServices`, `NonCritical`" => lambda { |v| %w{MissionCritical Critical Important CoreServices NonCritical}.include? v },
         },
         description: <<~'DESCRIPTION'
           Resiliency Policy Tier.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ResilienceHub::ResiliencyPolicy"
rest_api_document "/AWS::ResilienceHub::ResiliencyPolicy"

rest_property_map({
  data_location_constraint: "DataLocationConstraint",
  policy:                   "Policy",
  policy_description:       "PolicyDescription",
  policy_name:              "PolicyName",
  tags:                     "Tags",
  tier:                     "Tier",
})

