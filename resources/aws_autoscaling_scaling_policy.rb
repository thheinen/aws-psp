# Import API specifics
use "awscc_base"

resource_name :aws_autoscaling_scaling_policy
provides :aws_autoscaling_scaling_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::AutoScaling::ScalingPolicy resource specifies an Amazon EC2 Auto Scaling scaling policy so that the Auto Scaling group can scale the number of instances available for your application.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :adjustment_type, String,
         callbacks: {
           "adjustment_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Specifies how the scaling adjustment is interpreted. The valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity."

property :autoscaling_group_name, String,
         required: true,
         callbacks: {
           "autoscaling_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The name of the Auto Scaling group."

property :cooldown, String,
         callbacks: {
           "cooldown is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The duration of the policy's cooldown period, in seconds. When a cooldown period is specified here, it overrides the default cooldown period defined for the Auto Scaling group."

property :estimated_instance_warmup, Integer,
         callbacks: {
           "estimated_instance_warmup is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The estimated time, in seconds, until a newly launched instance can contribute to the CloudWatch metrics. If not provided, the default is to use the value from the default cooldown period for the Auto Scaling group. Valid only if the policy type is TargetTrackingScaling or StepScaling."

property :metric_aggregation_type, String,
         callbacks: {
           "metric_aggregation_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The aggregation type for the CloudWatch metrics. The valid values are Minimum, Maximum, and Average. If the aggregation type is null, the value is treated as Average. Valid only if the policy type is StepScaling."

property :min_adjustment_magnitude, Integer,
         callbacks: {
           "min_adjustment_magnitude is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The minimum value to scale by when the adjustment type is PercentChangeInCapacity. For example, suppose that you create a step scaling policy to scale out an Auto Scaling group by 25 percent and you specify a MinAdjustmentMagnitude of 2. If the group has 4 instances and the scaling policy is performed, 25 percent of 4 is 1. However, because you specified a MinAdjustmentMagnitude of 2, Amazon EC2 Auto Scaling scales out the group by 2 instances."

property :policy_type, String,
         callbacks: {
           "policy_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: "One of the following policy types: TargetTrackingScaling, StepScaling, SimpleScaling (default), PredictiveScaling"

property :predictive_scaling_configuration, Hash,
         callbacks: {
           "Subproperty `MetricSpecifications` is not a Array" => lambda { |v| v[:MetricSpecifications].is_a? Array },
           "Subproperty `MaxCapacityBreachBehavior` is not a String" => lambda { |v| v[:MaxCapacityBreachBehavior].is_a? String },
           "Subproperty `MaxCapacityBuffer` is not a Integer" => lambda { |v| v[:MaxCapacityBuffer].is_a? Integer },
           "Subproperty `SchedulingBufferTime` is not a Integer" => lambda { |v| v[:SchedulingBufferTime].is_a? Integer },
           "Subproperty `Mode` is not a String" => lambda { |v| v[:Mode].is_a? String },
         },
         description: "A predictive scaling policy. Includes support for predefined metrics only."

property :scaling_adjustment, Integer,
         callbacks: {
           "scaling_adjustment is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The amount by which to scale, based on the specified adjustment type. A positive value adds to the current capacity while a negative number removes from the current capacity. For exact capacity, you must specify a positive value. Required if the policy type is SimpleScaling. (Not used with any other policy type.)"

property :step_adjustments, Array,
         callbacks: {
           "step_adjustments is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A set of adjustments that enable you to scale based on the size of the alarm breach. Required if the policy type is StepScaling. (Not used with any other policy type.)"

property :target_tracking_configuration, Hash,
         callbacks: {
           "Subproperty `TargetValue` is not a Number" => lambda { |v| v[:TargetValue].is_a? Number },
           "Subproperty `DisableScaleIn` is not a Boolean" => lambda { |v| v[:DisableScaleIn].is_a? Boolean },
         },
         description: "A target tracking scaling policy. Includes support for predefined or customized metrics."

# API URLs and mappings
rest_api_collection "/AWS::AutoScaling::ScalingPolicy"
rest_api_document "/AWS::AutoScaling::ScalingPolicy"

rest_property_map({
  adjustment_type:                  "AdjustmentType",
  autoscaling_group_name:           "AutoScalingGroupName",
  cooldown:                         "Cooldown",
  estimated_instance_warmup:        "EstimatedInstanceWarmup",
  metric_aggregation_type:          "MetricAggregationType",
  min_adjustment_magnitude:         "MinAdjustmentMagnitude",
  policy_type:                      "PolicyType",
  predictive_scaling_configuration: "PredictiveScalingConfiguration",
  scaling_adjustment:               "ScalingAdjustment",
  step_adjustments:                 "StepAdjustments",
  target_tracking_configuration:    "TargetTrackingConfiguration",
})

rest_post_only_properties %i{
  autoscaling_group_name
}
