# Import API specifics
use "awscc_base"

resource_name :aws_open_search_service_domain
provides :aws_open_search_service_domain, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An example resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_policies, Hash,
         callbacks: {
           "access_policies is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :advanced_options, Hash,
         callbacks: {
           "advanced_options is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :advanced_security_options, Hash,
         callbacks: {
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
           "Subproperty `InternalUserDatabaseEnabled` is not a Boolean" => lambda { |v| v[:InternalUserDatabaseEnabled].is_a? Boolean },
           "Subproperty `AnonymousAuthEnabled` is not a Boolean" => lambda { |v| v[:AnonymousAuthEnabled].is_a? Boolean },
           "Subproperty `AnonymousAuthDisableDate` is not a String" => lambda { |v| v[:AnonymousAuthDisableDate].is_a? String },
         },
         description: ""

property :cluster_config, Hash,
         callbacks: {
           "Subproperty `InstanceCount` is not a Integer" => lambda { |v| v[:InstanceCount].is_a? Integer },
           "Subproperty `WarmEnabled` is not a Boolean" => lambda { |v| v[:WarmEnabled].is_a? Boolean },
           "Subproperty `WarmCount` is not a Integer" => lambda { |v| v[:WarmCount].is_a? Integer },
           "Subproperty `DedicatedMasterEnabled` is not a Boolean" => lambda { |v| v[:DedicatedMasterEnabled].is_a? Boolean },
           "Subproperty `DedicatedMasterCount` is not a Integer" => lambda { |v| v[:DedicatedMasterCount].is_a? Integer },
           "Subproperty `InstanceType` is not a String" => lambda { |v| v[:InstanceType].is_a? String },
           "Subproperty `WarmType` is not a String" => lambda { |v| v[:WarmType].is_a? String },
           "Subproperty `ZoneAwarenessEnabled` is not a Boolean" => lambda { |v| v[:ZoneAwarenessEnabled].is_a? Boolean },
           "Subproperty `DedicatedMasterType` is not a String" => lambda { |v| v[:DedicatedMasterType].is_a? String },
           "Subproperty `MultiAZWithStandbyEnabled` is not a Boolean" => lambda { |v| v[:MultiAZWithStandbyEnabled].is_a? Boolean },
         },
         description: ""

property :cognito_options, Hash,
         callbacks: {
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
           "Subproperty `IdentityPoolId` is not a String" => lambda { |v| v[:IdentityPoolId].is_a? String },
           "Subproperty `UserPoolId` is not a String" => lambda { |v| v[:UserPoolId].is_a? String },
           "Subproperty `RoleArn` is not a String" => lambda { |v| v[:RoleArn].is_a? String },
           "Subproperty `RoleArn`is not a valid ARN" => lambda { |v| v[:RoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :domain_endpoint_options, Hash,
         callbacks: {
           "Subproperty `CustomEndpointCertificateArn` is not a String" => lambda { |v| v[:CustomEndpointCertificateArn].is_a? String },
           "Subproperty `CustomEndpointCertificateArn`is not a valid ARN" => lambda { |v| v[:CustomEndpointCertificateArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `CustomEndpointEnabled` is not a Boolean" => lambda { |v| v[:CustomEndpointEnabled].is_a? Boolean },
           "Subproperty `EnforceHTTPS` is not a Boolean" => lambda { |v| v[:EnforceHTTPS].is_a? Boolean },
           "Subproperty `CustomEndpoint` is not a String" => lambda { |v| v[:CustomEndpoint].is_a? String },
           "Subproperty `TLSSecurityPolicy` is not a String" => lambda { |v| v[:TLSSecurityPolicy].is_a? String },
         },
         description: ""

property :domain_name, String,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :ebs_options, Hash,
         callbacks: {
           "Subproperty `EBSEnabled` is not a Boolean" => lambda { |v| v[:EBSEnabled].is_a? Boolean },
           "Subproperty `VolumeType` is not a String" => lambda { |v| v[:VolumeType].is_a? String },
           "Subproperty `Iops` is not a Integer" => lambda { |v| v[:Iops].is_a? Integer },
           "Subproperty `VolumeSize` is not a Integer" => lambda { |v| v[:VolumeSize].is_a? Integer },
           "Subproperty `Throughput` is not a Integer" => lambda { |v| v[:Throughput].is_a? Integer },
         },
         description: ""

property :encryption_at_rest_options, Hash,
         callbacks: {
           "Subproperty `KmsKeyId` is not a String" => lambda { |v| v[:KmsKeyId].is_a? String },
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
         },
         description: ""

property :engine_version, String,
         callbacks: {
           "engine_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :log_publishing_options, Hash,
         callbacks: {
           "log_publishing_options is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :node_to_node_encryption_options, Hash,
         callbacks: {
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
         },
         description: ""

property :off_peak_window_options, Hash,
         callbacks: {
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
         },
         description: ""

property :snapshot_options, Hash,
         callbacks: {
           "Subproperty `AutomatedSnapshotStartHour` is not a Integer" => lambda { |v| v[:AutomatedSnapshotStartHour].is_a? Integer },
         },
         description: ""

property :software_update_options, Hash,
         callbacks: {
           "Subproperty `AutoSoftwareUpdateEnabled` is not a Boolean" => lambda { |v| v[:AutoSoftwareUpdateEnabled].is_a? Boolean },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An arbitrary set of tags (key-value pairs) for this Domain.
         DESCRIPTION

property :vpc_options, Hash,
         callbacks: {
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::OpenSearchService::Domain"
rest_api_document "/AWS::OpenSearchService::Domain"

rest_property_map({
  access_policies:                 "AccessPolicies",
  advanced_options:                "AdvancedOptions",
  advanced_security_options:       "AdvancedSecurityOptions",
  cluster_config:                  "ClusterConfig",
  cognito_options:                 "CognitoOptions",
  domain_endpoint_options:         "DomainEndpointOptions",
  domain_name:                     "DomainName",
  ebs_options:                     "EBSOptions",
  encryption_at_rest_options:      "EncryptionAtRestOptions",
  engine_version:                  "EngineVersion",
  log_publishing_options:          "LogPublishingOptions",
  node_to_node_encryption_options: "NodeToNodeEncryptionOptions",
  off_peak_window_options:         "OffPeakWindowOptions",
  snapshot_options:                "SnapshotOptions",
  software_update_options:         "SoftwareUpdateOptions",
  tags:                            "Tags",
  vpc_options:                     "VPCOptions",
})

rest_post_only_properties %i{
  domain_name
}
