# Import API specifics
use "awscc_base"

resource_name :aws_ec2_host
provides :aws_ec2_host, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::Host
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auto_placement, String,
         callbacks: {
           "auto_placement is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the host accepts any untargeted instance launches that match its instance type configuration, or if it only accepts Host tenancy instance launches that specify its unique host ID.
         DESCRIPTION

property :availability_zone, String,
         required: true,
         callbacks: {
           "availability_zone is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Availability Zone in which to allocate the Dedicated Host.
         DESCRIPTION

property :host_recovery, String,
         callbacks: {
           "host_recovery is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Indicates whether to enable or disable host recovery for the Dedicated Host. Host recovery is disabled by default.
         DESCRIPTION

property :instance_family, String,
         callbacks: {
           "instance_family is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the instance family to be supported by the Dedicated Hosts. If you specify an instance family, the Dedicated Hosts support multiple instance types within that instance family.
         DESCRIPTION

property :instance_type, String,
         callbacks: {
           "instance_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the instance type to be supported by the Dedicated Hosts. If you specify an instance type, the Dedicated Hosts support instances of the specified instance type only.
         DESCRIPTION

property :outpost_arn, String,
         callbacks: {
           "outpost_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the Amazon Web Services Outpost on which to allocate the Dedicated Host.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::Host"
rest_api_document "/AWS::EC2::Host"

rest_property_map({
  auto_placement:    "AutoPlacement",
  availability_zone: "AvailabilityZone",
  host_recovery:     "HostRecovery",
  instance_family:   "InstanceFamily",
  instance_type:     "InstanceType",
  outpost_arn:       "OutpostArn",
})

rest_post_only_properties %i{
  availability_zone instance_family instance_type outpost_arn
}
