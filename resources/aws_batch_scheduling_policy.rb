# Import API specifics
use "awscc_base"

resource_name :aws_batch_scheduling_policy
provides :aws_batch_scheduling_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type schema for AWS::Batch::SchedulingPolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :fairshare_policy, Hash,
         callbacks: {
           "Subproperty `ShareDecaySeconds` is not a Number" => lambda { |v| v[:ShareDecaySeconds].is_a? Number },
           "Subproperty `ComputeReservation` is not a Number" => lambda { |v| v[:ComputeReservation].is_a? Number },
           "Subproperty `ShareDistribution` is not a Array" => lambda { |v| v[:ShareDistribution].is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern " => lambda { |v| v =~ Regexp.new("//") },
         },
         description: "Name of Scheduling Policy."

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "A key-value pair to associate with a resource."

# API URLs and mappings
rest_api_collection "/AWS::Batch::SchedulingPolicy"
rest_api_document "/AWS::Batch::SchedulingPolicy"

rest_property_map({
  fairshare_policy: "FairsharePolicy",
  name:             "Name",
  tags:             "Tags",
})

rest_post_only_properties %i{
  name tags
}
