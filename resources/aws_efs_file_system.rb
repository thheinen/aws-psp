# Import API specifics
use "awscc_base"

resource_name :aws_efs_file_system
provides :aws_efs_file_system, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EFS::FileSystem
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :availability_zone_name, String,
         callbacks: {
           "availability_zone_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :backup_policy, Hash,
         callbacks: {
           "Subproperty `Status` is not a String" => lambda { |v| v[:Status].is_a? String },
         },
         description: ""

property :bypass_policy_lockout_safety_check, [TrueClass, FalseClass],
         callbacks: {
           "bypass_policy_lockout_safety_check is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether to bypass the FileSystemPolicy lockout safety check. The policy lockout safety check determines whether the policy in the request will prevent the principal making the request to be locked out from making future PutFileSystemPolicy requests on the file system. Set BypassPolicyLockoutSafetyCheck to True only when you intend to prevent the principal that is making the request from making a subsequent PutFileSystemPolicy request on the file system. Defaults to false
         DESCRIPTION

property :encrypted, [TrueClass, FalseClass],
         callbacks: {
           "encrypted is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :file_system_policy, Hash,
         callbacks: {
           "file_system_policy is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :file_system_tags, Array,
         callbacks: {
           "file_system_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :lifecycle_policies, Array,
         callbacks: {
           "lifecycle_policies is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :performance_mode, String,
         callbacks: {
           "performance_mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :provisioned_throughput_in_mibps, Number,
         callbacks: {
           "provisioned_throughput_in_mibps is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: ""

property :replication_configuration, Hash,
         callbacks: {
           "Subproperty `Destinations` is not a Array" => lambda { |v| v[:Destinations].is_a? Array },
         },
         description: ""

property :throughput_mode, String,
         callbacks: {
           "throughput_mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EFS::FileSystem"
rest_api_document "/AWS::EFS::FileSystem"

rest_property_map({
  availability_zone_name:             "AvailabilityZoneName",
  backup_policy:                      "BackupPolicy",
  bypass_policy_lockout_safety_check: "BypassPolicyLockoutSafetyCheck",
  encrypted:                          "Encrypted",
  file_system_policy:                 "FileSystemPolicy",
  file_system_tags:                   "FileSystemTags",
  kms_key_id:                         "KmsKeyId",
  lifecycle_policies:                 "LifecyclePolicies",
  performance_mode:                   "PerformanceMode",
  provisioned_throughput_in_mibps:    "ProvisionedThroughputInMibps",
  replication_configuration:          "ReplicationConfiguration",
  throughput_mode:                    "ThroughputMode",
})

rest_post_only_properties %i{
  availability_zone_name encrypted kms_key_id performance_mode
}
