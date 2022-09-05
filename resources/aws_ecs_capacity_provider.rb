# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ecs_capacity_provider
provides :aws_ecs_capacity_provider, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ECS::CapacityProvider.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :autoscaling_group_provider, Hash,
         required: true,
         callbacks: {
           "Subproperty `AutoScalingGroupArn` is not a String" => lambda { |v| v[:AutoScalingGroupArn].is_a? String },
           "Subproperty `AutoScalingGroupArn`is not a valid ARN" => lambda { |v| v[:AutoScalingGroupArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `ManagedTerminationProtection` is not a String" => lambda { |v| v[:ManagedTerminationProtection].is_a? String },
           "Subproperty `ManagedTerminationProtection`is not one of `DISABLED`, `ENABLED`" => lambda { |v| %w{DISABLED ENABLED}.include? v[:ManagedTerminationProtection] },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ECS::CapacityProvider"
rest_api_document "/AWS::ECS::CapacityProvider"

rest_property_map({
  autoscaling_group_provider: "AutoScalingGroupProvider",
  name:                       "Name",
  tags:                       "Tags",
})

rest_post_only_properties %i{
  autoscaling_group_provider/auto_scaling_group_arn name
}
