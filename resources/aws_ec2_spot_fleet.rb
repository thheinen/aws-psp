# Import API specifics
use "awscc_base"

resource_name :aws_ec2_spot_fleet
provides :aws_ec2_spot_fleet, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::SpotFleet
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :spot_fleet_request_config_data, Hash,
         required: true,
         callbacks: {
           "Subproperty `AllocationStrategy` is not a String" => lambda { |v| v[:AllocationStrategy].is_a? String },
           "Subproperty `AllocationStrategy`is not one of `capacityOptimized`, `capacityOptimizedPrioritized`, `diversified`, `lowestPrice`, `priceCapacityOptimized`" => lambda { |v| %w{capacityOptimized capacityOptimizedPrioritized diversified lowestPrice priceCapacityOptimized}.include? v[:AllocationStrategy] },
           "Subproperty `Context` is not a String" => lambda { |v| v[:Context].is_a? String },
           "Subproperty `ExcessCapacityTerminationPolicy` is not a String" => lambda { |v| v[:ExcessCapacityTerminationPolicy].is_a? String },
           "Subproperty `ExcessCapacityTerminationPolicy`is not one of `Default`, `NoTermination`, `default`, `noTermination`" => lambda { |v| %w{Default NoTermination default noTermination}.include? v[:ExcessCapacityTerminationPolicy] },
           "Subproperty `IamFleetRole` is not a String" => lambda { |v| v[:IamFleetRole].is_a? String },
           "Subproperty `InstanceInterruptionBehavior` is not a String" => lambda { |v| v[:InstanceInterruptionBehavior].is_a? String },
           "Subproperty `InstanceInterruptionBehavior`is not one of `hibernate`, `stop`, `terminate`" => lambda { |v| %w{hibernate stop terminate}.include? v[:InstanceInterruptionBehavior] },
           "Subproperty `InstancePoolsToUseCount` is not a Integer" => lambda { |v| v[:InstancePoolsToUseCount].is_a? Integer },
           "Subproperty `LaunchSpecifications` is not a Array" => lambda { |v| v[:LaunchSpecifications].is_a? Array },
           "Subproperty `LaunchTemplateConfigs` is not a Array" => lambda { |v| v[:LaunchTemplateConfigs].is_a? Array },
           "Subproperty `OnDemandAllocationStrategy` is not a String" => lambda { |v| v[:OnDemandAllocationStrategy].is_a? String },
           "Subproperty `OnDemandMaxTotalPrice` is not a String" => lambda { |v| v[:OnDemandMaxTotalPrice].is_a? String },
           "Subproperty `OnDemandTargetCapacity` is not a Integer" => lambda { |v| v[:OnDemandTargetCapacity].is_a? Integer },
           "Subproperty `ReplaceUnhealthyInstances` is not a Boolean" => lambda { |v| v[:ReplaceUnhealthyInstances].is_a? Boolean },
           "Subproperty `SpotMaxTotalPrice` is not a String" => lambda { |v| v[:SpotMaxTotalPrice].is_a? String },
           "Subproperty `SpotPrice` is not a String" => lambda { |v| v[:SpotPrice].is_a? String },
           "Subproperty `TargetCapacity` is not a Integer" => lambda { |v| v[:TargetCapacity].is_a? Integer },
           "Subproperty `TerminateInstancesWithExpiration` is not a Boolean" => lambda { |v| v[:TerminateInstancesWithExpiration].is_a? Boolean },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `maintain`, `request`" => lambda { |v| %w{maintain request}.include? v[:Type] },
           "Subproperty `ValidFrom` is not a String" => lambda { |v| v[:ValidFrom].is_a? String },
           "Subproperty `ValidUntil` is not a String" => lambda { |v| v[:ValidUntil].is_a? String },
           "Subproperty `TagSpecifications` is not a Array" => lambda { |v| v[:TagSpecifications].is_a? Array },
           "Subproperty `TargetCapacityUnitType` is not a String" => lambda { |v| v[:TargetCapacityUnitType].is_a? String },
           "Subproperty `TargetCapacityUnitType`is not one of `vcpu`, `memory-mib`, `units`" => lambda { |v| %w{vcpu memory-mib units}.include? v[:TargetCapacityUnitType] },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::SpotFleet"
rest_api_document "/AWS::EC2::SpotFleet"

rest_property_map({
  spot_fleet_request_config_data: "SpotFleetRequestConfigData",
})

rest_post_only_properties %i{
  spot_fleet_request_config_data/allocation_strategy spot_fleet_request_config_data/iam_fleet_role spot_fleet_request_config_data/instance_interruption_behavior spot_fleet_request_config_data/instance_pools_to_use_count spot_fleet_request_config_data/launch_specifications spot_fleet_request_config_data/launch_template_configs spot_fleet_request_config_data/load_balancers_config spot_fleet_request_config_data/on_demand_allocation_strategy spot_fleet_request_config_data/on_demand_max_total_price spot_fleet_request_config_data/on_demand_target_capacity spot_fleet_request_config_data/replace_unhealthy_instances spot_fleet_request_config_data/spot_maintenance_strategies spot_fleet_request_config_data/spot_max_total_price spot_fleet_request_config_data/spot_price spot_fleet_request_config_data/tag_specifications spot_fleet_request_config_data/terminate_instances_with_expiration spot_fleet_request_config_data/type spot_fleet_request_config_data/valid_from spot_fleet_request_config_data/valid_until
}
