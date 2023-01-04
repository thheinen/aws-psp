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

property :group_name, String,
         callbacks: {
           "group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Group Name of Placement Group.
         DESCRIPTION

property :partition_count, Integer,
         callbacks: {
           "partition_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of partitions. Valid only when **Strategy** is set to `partition`
         DESCRIPTION

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

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::PlacementGroup"
rest_api_document "/AWS::EC2::PlacementGroup"

rest_property_map({
  group_name:      "GroupName",
  partition_count: "PartitionCount",
  spread_level:    "SpreadLevel",
  strategy:        "Strategy",
  tags:            "Tags",
})

rest_post_only_properties %i{
  group_name partition_count spread_level strategy
}
