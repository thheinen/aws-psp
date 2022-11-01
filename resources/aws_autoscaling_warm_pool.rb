# Import API specifics
use "awscc_base"

resource_name :aws_autoscaling_warm_pool
provides :aws_autoscaling_warm_pool, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::AutoScaling::WarmPool.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :autoscaling_group_name, String,
         required: true,
         callbacks: {
           "autoscaling_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :instance_reuse_policy, Hash,
         callbacks: {
           "Subproperty `ReuseOnScaleIn` is not a Boolean" => lambda { |v| v[:ReuseOnScaleIn].is_a? Boolean },
         },
         description: ""

property :max_group_prepared_capacity, Integer,
         callbacks: {
           "max_group_prepared_capacity is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :min_size, Integer,
         callbacks: {
           "min_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :pool_state, String,
         callbacks: {
           "pool_state is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AutoScaling::WarmPool"
rest_api_document "/AWS::AutoScaling::WarmPool"

rest_property_map({
  autoscaling_group_name:      "AutoScalingGroupName",
  instance_reuse_policy:       "InstanceReusePolicy",
  max_group_prepared_capacity: "MaxGroupPreparedCapacity",
  min_size:                    "MinSize",
  pool_state:                  "PoolState",
})

rest_post_only_properties %i{
  autoscaling_group_name
}
