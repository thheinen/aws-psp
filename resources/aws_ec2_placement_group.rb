# Import API specifics
use "awscc_base"

resource_name :aws_ec2_placement_group
provides :aws_ec2_placement_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::PlacementGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :spread_level, String,
         callbacks: {
           "spread_level is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Spread Level of Placement Group is an enum where it accepts either host or rack when strategy is spread
         DESCRIPTION

property :strategy, String,
         callbacks: {
           "strategy is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The placement strategy.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::PlacementGroup"
rest_api_document "/AWS::EC2::PlacementGroup"

rest_property_map({
  spread_level: "SpreadLevel",
  strategy:     "Strategy",
})

rest_post_only_properties %i{
  spread_level strategy
}
