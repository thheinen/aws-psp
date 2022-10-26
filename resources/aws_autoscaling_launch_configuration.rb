# Import API specifics
use "awscc_base"

resource_name :aws_autoscaling_launch_configuration
provides :aws_autoscaling_launch_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::AutoScaling::LaunchConfiguration resource specifies the launch configuration that can be used by an Auto Scaling group to configure Amazon EC2 instances.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :associate_public_ip_address, [TrueClass, FalseClass],
         callbacks: {
           "associate_public_ip_address is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           For Auto Scaling groups that are running in a virtual private cloud (VPC), specifies whether to assign a public IP address to the group's instances.
         DESCRIPTION

property :block_device_mappings, Array,
         callbacks: {
           "block_device_mappings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Specifies how block devices are exposed to the instance. You can specify virtual devices and EBS volumes.
         DESCRIPTION

property :classic_link_vpc_id, String,
         callbacks: {
           "classic_link_vpc_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of a ClassicLink-enabled VPC to link your EC2-Classic instances to.
         DESCRIPTION

property :classic_link_vpc_security_groups, Array,
         callbacks: {
           "classic_link_vpc_security_groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The IDs of one or more security groups for the VPC that you specified in the ClassicLinkVPCId property.
         DESCRIPTION

property :ebs_optimized, [TrueClass, FalseClass],
         callbacks: {
           "ebs_optimized is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether the launch configuration is optimized for EBS I/O (true) or not (false).
         DESCRIPTION

property :iam_instance_profile, String,
         callbacks: {
           "iam_instance_profile is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Provides the name or the Amazon Resource Name (ARN) of the instance profile associated with the IAM role for the instance. The instance profile contains the IAM role.
         DESCRIPTION

property :image_id, String,
         required: true,
         callbacks: {
           "image_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Provides the unique ID of the Amazon Machine Image (AMI) that was assigned during registration.
         DESCRIPTION

property :instance_id, String,
         callbacks: {
           "instance_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the Amazon EC2 instance you want to use to create the launch configuration.
         DESCRIPTION

property :instance_monitoring, [TrueClass, FalseClass],
         callbacks: {
           "instance_monitoring is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Controls whether instances in this group are launched with detailed (true) or basic (false) monitoring.
         DESCRIPTION

property :instance_type, String,
         required: true,
         callbacks: {
           "instance_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the instance type of the EC2 instance.
         DESCRIPTION

property :kernel_id, String,
         callbacks: {
           "kernel_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Provides the ID of the kernel associated with the EC2 AMI.
         DESCRIPTION

property :key_name, String,
         callbacks: {
           "key_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Provides the name of the EC2 key pair.
         DESCRIPTION

property :launch_configuration_name, String,
         callbacks: {
           "launch_configuration_name is not a String" => lambda { |v| v.is_a? String },
           "launch_configuration_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The name of the launch configuration. This name must be unique per Region per account.
         DESCRIPTION

property :metadata_options, Hash,
         callbacks: {
           "Subproperty `HttpPutResponseHopLimit` is not a Integer" => lambda { |v| v[:HttpPutResponseHopLimit].is_a? Integer },
           "Subproperty `HttpTokens` is not a String" => lambda { |v| v[:HttpTokens].is_a? String },
           "Subproperty `HttpEndpoint` is not a String" => lambda { |v| v[:HttpEndpoint].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The metadata options for the instances.
         DESCRIPTION

property :placement_tenancy, String,
         callbacks: {
           "placement_tenancy is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The tenancy of the instance, either default or dedicated.
         DESCRIPTION

property :ram_disk_id, String,
         callbacks: {
           "ram_disk_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the RAM disk to select.
         DESCRIPTION

property :security_groups, Array,
         callbacks: {
           "security_groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list that contains the security groups to assign to the instances in the Auto Scaling group.
         DESCRIPTION

property :spot_price, String,
         callbacks: {
           "spot_price is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The maximum hourly price you are willing to pay for any Spot Instances launched to fulfill the request.
         DESCRIPTION

property :user_data, String,
         callbacks: {
           "user_data is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Base64-encoded user data to make available to the launched EC2 instances.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AutoScaling::LaunchConfiguration"
rest_api_document "/AWS::AutoScaling::LaunchConfiguration"

rest_property_map({
  associate_public_ip_address:      "AssociatePublicIpAddress",
  block_device_mappings:            "BlockDeviceMappings",
  classic_link_vpc_id:              "ClassicLinkVPCId",
  classic_link_vpc_security_groups: "ClassicLinkVPCSecurityGroups",
  ebs_optimized:                    "EbsOptimized",
  iam_instance_profile:             "IamInstanceProfile",
  image_id:                         "ImageId",
  instance_id:                      "InstanceId",
  instance_monitoring:              "InstanceMonitoring",
  instance_type:                    "InstanceType",
  kernel_id:                        "KernelId",
  key_name:                         "KeyName",
  launch_configuration_name:        "LaunchConfigurationName",
  metadata_options:                 "MetadataOptions",
  placement_tenancy:                "PlacementTenancy",
  ram_disk_id:                      "RamDiskId",
  security_groups:                  "SecurityGroups",
  spot_price:                       "SpotPrice",
  user_data:                        "UserData",
})

rest_post_only_properties %i{
  associate_public_ip_address block_device_mappings classic_link_vpc_id classic_link_vpc_security_groups ebs_optimized iam_instance_profile image_id instance_id instance_monitoring instance_type kernel_id key_name launch_configuration_name metadata_options placement_tenancy ram_disk_id security_groups spot_price user_data
}
