# Import API specifics
use "awscc_base"

resource_name :aws_ec2_launch_template
provides :aws_ec2_launch_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::LaunchTemplate
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :launch_template_data, Hash,
         required: true,
         callbacks: {
           "Subproperty `SecurityGroups` is not a Array" => lambda { |v| v[:SecurityGroups].is_a? Array },
           "Subproperty `TagSpecifications` is not a Array" => lambda { |v| v[:TagSpecifications].is_a? Array },
           "Subproperty `UserData` is not a String" => lambda { |v| v[:UserData].is_a? String },
           "Subproperty `BlockDeviceMappings` is not a Array" => lambda { |v| v[:BlockDeviceMappings].is_a? Array },
           "Subproperty `KernelId` is not a String" => lambda { |v| v[:KernelId].is_a? String },
           "Subproperty `EbsOptimized` is not a Boolean" => lambda { |v| v[:EbsOptimized].is_a? Boolean },
           "Subproperty `ElasticGpuSpecifications` is not a Array" => lambda { |v| v[:ElasticGpuSpecifications].is_a? Array },
           "Subproperty `ElasticInferenceAccelerators` is not a Array" => lambda { |v| v[:ElasticInferenceAccelerators].is_a? Array },
           "Subproperty `NetworkInterfaces` is not a Array" => lambda { |v| v[:NetworkInterfaces].is_a? Array },
           "Subproperty `ImageId` is not a String" => lambda { |v| v[:ImageId].is_a? String },
           "Subproperty `InstanceType` is not a String" => lambda { |v| v[:InstanceType].is_a? String },
           "Subproperty `LicenseSpecifications` is not a Array" => lambda { |v| v[:LicenseSpecifications].is_a? Array },
           "Subproperty `InstanceInitiatedShutdownBehavior` is not a String" => lambda { |v| v[:InstanceInitiatedShutdownBehavior].is_a? String },
           "Subproperty `DisableApiStop` is not a Boolean" => lambda { |v| v[:DisableApiStop].is_a? Boolean },
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
           "Subproperty `KeyName` is not a String" => lambda { |v| v[:KeyName].is_a? String },
           "Subproperty `DisableApiTermination` is not a Boolean" => lambda { |v| v[:DisableApiTermination].is_a? Boolean },
           "Subproperty `RamDiskId` is not a String" => lambda { |v| v[:RamDiskId].is_a? String },
         },
         description: ""

property :launch_template_name, String,
         callbacks: {
           "launch_template_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A name for the launch template.
         DESCRIPTION

property :tag_specifications, Array,
         callbacks: {
           "tag_specifications is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags to apply to the launch template on creation.
         DESCRIPTION

property :version_description, String,
         callbacks: {
           "version_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description for the first version of the launch template.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::LaunchTemplate"
rest_api_document "/AWS::EC2::LaunchTemplate"

rest_property_map({
  launch_template_data: "LaunchTemplateData",
  launch_template_name: "LaunchTemplateName",
  tag_specifications:   "TagSpecifications",
  version_description:  "VersionDescription",
})

rest_post_only_properties %i{
  launch_template_name
}
