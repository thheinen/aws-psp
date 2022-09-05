# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ec2_capacity_reservation_fleet
provides :aws_ec2_capacity_reservation_fleet, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::CapacityReservationFleet
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allocation_strategy, String,
         callbacks: {
           "allocation_strategy is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :end_date, String,
         callbacks: {
           "end_date is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :instance_match_criteria, String,
         callbacks: {
           "instance_match_criteria is not a String" => lambda { |v| v.is_a? String },
           "instance_match_criteriais not one of `open`" => lambda { |v| %w{open}.include? v },
         },
         description: ""

property :instance_type_specifications, Array,
         callbacks: {
           "instance_type_specifications is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :no_remove_end_date, [TrueClass, FalseClass],
         callbacks: {
           "no_remove_end_date is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :remove_end_date, [TrueClass, FalseClass],
         callbacks: {
           "remove_end_date is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :tag_specifications, Array,
         callbacks: {
           "tag_specifications is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tenancy, String,
         callbacks: {
           "tenancy is not a String" => lambda { |v| v.is_a? String },
           "tenancyis not one of `default`" => lambda { |v| %w{default}.include? v },
         },
         description: ""

property :total_target_capacity, Integer,
         callbacks: {
           "total_target_capacity is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::CapacityReservationFleet"
rest_api_document "/AWS::EC2::CapacityReservationFleet"

rest_property_map({
  allocation_strategy:          "AllocationStrategy",
  end_date:                     "EndDate",
  instance_match_criteria:      "InstanceMatchCriteria",
  instance_type_specifications: "InstanceTypeSpecifications",
  no_remove_end_date:           "NoRemoveEndDate",
  remove_end_date:              "RemoveEndDate",
  tag_specifications:           "TagSpecifications",
  tenancy:                      "Tenancy",
  total_target_capacity:        "TotalTargetCapacity",
})

rest_post_only_properties %i{
  allocation_strategy end_date instance_match_criteria instance_type_specifications tag_specifications tenancy
}
