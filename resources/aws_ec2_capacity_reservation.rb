# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ec2_capacity_reservation
provides :aws_ec2_capacity_reservation, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::CapacityReservation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :availability_zone, String,
         required: true,
         callbacks: {
           "availability_zone is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :ebs_optimized, [TrueClass, FalseClass],
         callbacks: {
           "ebs_optimized is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :end_date, String,
         callbacks: {
           "end_date is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :end_date_type, String,
         callbacks: {
           "end_date_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :ephemeral_storage, [TrueClass, FalseClass],
         callbacks: {
           "ephemeral_storage is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :instance_count, Integer,
         required: true,
         callbacks: {
           "instance_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :instance_match_criteria, String,
         callbacks: {
           "instance_match_criteria is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :instance_platform, String,
         required: true,
         callbacks: {
           "instance_platform is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :instance_type, String,
         required: true,
         callbacks: {
           "instance_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :out_post_arn, String,
         callbacks: {
           "out_post_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :placement_group_arn, String,
         callbacks: {
           "placement_group_arn is not a String" => lambda { |v| v.is_a? String },
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
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::CapacityReservation"
rest_api_document "/AWS::EC2::CapacityReservation"

rest_property_map({
  availability_zone:       "AvailabilityZone",
  ebs_optimized:           "EbsOptimized",
  end_date:                "EndDate",
  end_date_type:           "EndDateType",
  ephemeral_storage:       "EphemeralStorage",
  instance_count:          "InstanceCount",
  instance_match_criteria: "InstanceMatchCriteria",
  instance_platform:       "InstancePlatform",
  instance_type:           "InstanceType",
  out_post_arn:            "OutPostArn",
  placement_group_arn:     "PlacementGroupArn",
  tag_specifications:      "TagSpecifications",
  tenancy:                 "Tenancy",
})

rest_post_only_properties %i{
  availability_zone ebs_optimized ephemeral_storage instance_match_criteria instance_platform instance_type out_post_arn placement_group_arn tag_specifications tenancy
}
