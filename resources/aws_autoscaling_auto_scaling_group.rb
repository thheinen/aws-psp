# Import API specifics
use "awscc_base"

resource_name :aws_autoscaling_auto_scaling_group
provides :aws_autoscaling_auto_scaling_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AutoScaling::AutoScalingGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :autoscaling_group_name, String,
         callbacks: {
           "autoscaling_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :availability_zones, Array,
         callbacks: {
           "availability_zones is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :capacity_rebalance, [TrueClass, FalseClass],
         callbacks: {
           "capacity_rebalance is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :context, String,
         callbacks: {
           "context is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :cooldown, String,
         callbacks: {
           "cooldown is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :default_instance_warmup, Integer,
         callbacks: {
           "default_instance_warmup is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :desired_capacity, String,
         callbacks: {
           "desired_capacity is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :desired_capacity_type, String,
         callbacks: {
           "desired_capacity_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :health_check_grace_period, Integer,
         callbacks: {
           "health_check_grace_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :health_check_type, String,
         callbacks: {
           "health_check_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :instance_id, String,
         callbacks: {
           "instance_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :launch_configuration_name, String,
         callbacks: {
           "launch_configuration_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :launch_template, Hash,
         callbacks: {
           "Subproperty `LaunchTemplateName` is not a String" => lambda { |v| v[:LaunchTemplateName].is_a? String },
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `LaunchTemplateId` is not a String" => lambda { |v| v[:LaunchTemplateId].is_a? String },
         },
         description: ""

property :lifecycle_hook_specification_list, Array,
         callbacks: {
           "lifecycle_hook_specification_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :load_balancer_names, Array,
         callbacks: {
           "load_balancer_names is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :max_instance_lifetime, Integer,
         callbacks: {
           "max_instance_lifetime is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :max_size, String,
         required: true,
         callbacks: {
           "max_size is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :metrics_collection, Array,
         callbacks: {
           "metrics_collection is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :min_size, String,
         required: true,
         callbacks: {
           "min_size is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :mixed_instances_policy, Hash,
         description: ""

property :new_instances_protected_from_scale_in, [TrueClass, FalseClass],
         callbacks: {
           "new_instances_protected_from_scale_in is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :notification_configuration, Hash,
         callbacks: {
           "Subproperty `TopicARN` is not a String" => lambda { |v| v[:TopicARN].is_a? String },
           "Subproperty `NotificationTypes` is not a Array" => lambda { |v| v[:NotificationTypes].is_a? Array },
         },
         description: ""

property :notification_configurations, Array,
         callbacks: {
           "notification_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :placement_group, String,
         callbacks: {
           "placement_group is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :service_linked_role_arn, String,
         callbacks: {
           "service_linked_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :target_group_ar_ns, Array,
         callbacks: {
           "target_group_ar_ns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :termination_policies, Array,
         callbacks: {
           "termination_policies is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :vpc_zone_identifier, Array,
         callbacks: {
           "vpc_zone_identifier is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AutoScaling::AutoScalingGroup"
rest_api_document "/AWS::AutoScaling::AutoScalingGroup"

rest_property_map({
  autoscaling_group_name:                "AutoScalingGroupName",
  availability_zones:                    "AvailabilityZones",
  capacity_rebalance:                    "CapacityRebalance",
  context:                               "Context",
  cooldown:                              "Cooldown",
  default_instance_warmup:               "DefaultInstanceWarmup",
  desired_capacity:                      "DesiredCapacity",
  desired_capacity_type:                 "DesiredCapacityType",
  health_check_grace_period:             "HealthCheckGracePeriod",
  health_check_type:                     "HealthCheckType",
  instance_id:                           "InstanceId",
  launch_configuration_name:             "LaunchConfigurationName",
  launch_template:                       "LaunchTemplate",
  lifecycle_hook_specification_list:     "LifecycleHookSpecificationList",
  load_balancer_names:                   "LoadBalancerNames",
  max_instance_lifetime:                 "MaxInstanceLifetime",
  max_size:                              "MaxSize",
  metrics_collection:                    "MetricsCollection",
  min_size:                              "MinSize",
  mixed_instances_policy:                "MixedInstancesPolicy",
  new_instances_protected_from_scale_in: "NewInstancesProtectedFromScaleIn",
  notification_configuration:            "NotificationConfiguration",
  notification_configurations:           "NotificationConfigurations",
  placement_group:                       "PlacementGroup",
  service_linked_role_arn:               "ServiceLinkedRoleARN",
  tags:                                  "Tags",
  target_group_ar_ns:                    "TargetGroupARNs",
  termination_policies:                  "TerminationPolicies",
  vpc_zone_identifier:                   "VPCZoneIdentifier",
})

rest_post_only_properties %i{
  autoscaling_group_name instance_id
}
