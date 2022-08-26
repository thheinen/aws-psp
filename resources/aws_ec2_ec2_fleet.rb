# Import API specifics
use "awscc_base"

resource_name :aws_ec2_ec2_fleet
provides :aws_ec2_ec2_fleet, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::EC2Fleet
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :context, String,
         callbacks: {
           "context is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :excess_capacity_termination_policy, String,
         callbacks: {
           "excess_capacity_termination_policy is not a String" => lambda { |v| v.is_a? String },
           "excess_capacity_termination_policyis not one of `termination`, `no-termination`" => lambda { |v| %w{termination no-termination}.include? v },
         },
         description: ""

property :launch_template_configs, Array,
         required: true,
         callbacks: {
           "launch_template_configs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :on_demand_options, Hash,
         callbacks: {
           "Subproperty `SingleAvailabilityZone` is not a Boolean" => lambda { |v| v[:SingleAvailabilityZone].is_a? Boolean },
           "Subproperty `AllocationStrategy` is not a String" => lambda { |v| v[:AllocationStrategy].is_a? String },
           "Subproperty `SingleInstanceType` is not a Boolean" => lambda { |v| v[:SingleInstanceType].is_a? Boolean },
           "Subproperty `MinTargetCapacity` is not a Integer" => lambda { |v| v[:MinTargetCapacity].is_a? Integer },
           "Subproperty `MaxTotalPrice` is not a String" => lambda { |v| v[:MaxTotalPrice].is_a? String },
         },
         description: ""

property :replace_unhealthy_instances, [TrueClass, FalseClass],
         callbacks: {
           "replace_unhealthy_instances is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :spot_options, Hash,
         callbacks: {
           "Subproperty `SingleAvailabilityZone` is not a Boolean" => lambda { |v| v[:SingleAvailabilityZone].is_a? Boolean },
           "Subproperty `AllocationStrategy` is not a String" => lambda { |v| v[:AllocationStrategy].is_a? String },
           "Subproperty `AllocationStrategy`is not one of `lowestPrice`, `diversified`, `capacityOptimized`, `capacityOptimizedPrioritized`" => lambda { |v| %w{lowestPrice diversified capacityOptimized capacityOptimizedPrioritized}.include? v[:AllocationStrategy] },
           "Subproperty `SingleInstanceType` is not a Boolean" => lambda { |v| v[:SingleInstanceType].is_a? Boolean },
           "Subproperty `MinTargetCapacity` is not a Integer" => lambda { |v| v[:MinTargetCapacity].is_a? Integer },
           "Subproperty `MaxTotalPrice` is not a String" => lambda { |v| v[:MaxTotalPrice].is_a? String },
           "Subproperty `InstanceInterruptionBehavior` is not a String" => lambda { |v| v[:InstanceInterruptionBehavior].is_a? String },
           "Subproperty `InstanceInterruptionBehavior`is not one of `hibernate`, `stop`, `terminate`" => lambda { |v| %w{hibernate stop terminate}.include? v[:InstanceInterruptionBehavior] },
           "Subproperty `InstancePoolsToUseCount` is not a Integer" => lambda { |v| v[:InstancePoolsToUseCount].is_a? Integer },
         },
         description: ""

property :tag_specifications, Array,
         callbacks: {
           "tag_specifications is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :target_capacity_specification, Hash,
         required: true,
         callbacks: {
           "Subproperty `DefaultTargetCapacityType` is not a String" => lambda { |v| v[:DefaultTargetCapacityType].is_a? String },
           "Subproperty `DefaultTargetCapacityType`is not one of `on-demand`, `spot`" => lambda { |v| %w{on-demand spot}.include? v[:DefaultTargetCapacityType] },
           "Subproperty `TargetCapacityUnitType` is not a String" => lambda { |v| v[:TargetCapacityUnitType].is_a? String },
           "Subproperty `TargetCapacityUnitType`is not one of `vcpu`, `memory-mib`, `units`" => lambda { |v| %w{vcpu memory-mib units}.include? v[:TargetCapacityUnitType] },
           "Subproperty `TotalTargetCapacity` is not a Integer" => lambda { |v| v[:TotalTargetCapacity].is_a? Integer },
           "Subproperty `OnDemandTargetCapacity` is not a Integer" => lambda { |v| v[:OnDemandTargetCapacity].is_a? Integer },
           "Subproperty `SpotTargetCapacity` is not a Integer" => lambda { |v| v[:SpotTargetCapacity].is_a? Integer },
         },
         description: ""

property :terminate_instances_with_expiration, [TrueClass, FalseClass],
         callbacks: {
           "terminate_instances_with_expiration is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :type, String,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `maintain`, `request`, `instant`" => lambda { |v| %w{maintain request instant}.include? v },
         },
         description: ""

property :valid_from, String,
         callbacks: {
           "valid_from is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :valid_until, String,
         callbacks: {
           "valid_until is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::EC2Fleet"
rest_api_document "/AWS::EC2::EC2Fleet"

rest_property_map({
  context:                             "Context",
  excess_capacity_termination_policy:  "ExcessCapacityTerminationPolicy",
  launch_template_configs:             "LaunchTemplateConfigs",
  on_demand_options:                   "OnDemandOptions",
  replace_unhealthy_instances:         "ReplaceUnhealthyInstances",
  spot_options:                        "SpotOptions",
  tag_specifications:                  "TagSpecifications",
  target_capacity_specification:       "TargetCapacitySpecification",
  terminate_instances_with_expiration: "TerminateInstancesWithExpiration",
  type:                                "Type",
  valid_from:                          "ValidFrom",
  valid_until:                         "ValidUntil",
})

rest_post_only_properties %i{
  launch_template_configs on_demand_options replace_unhealthy_instances spot_options tag_specifications terminate_instances_with_expiration type valid_from valid_until
}
