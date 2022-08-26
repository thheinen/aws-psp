# Import API specifics
use "awscc_base"

resource_name :aws_codeguru_profiler_profiling_group
provides :aws_codeguru_profiler_profiling_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  This resource schema represents the Profiling Group resource in the Amazon CodeGuru Profiler service.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :agent_permissions, Hash,
         callbacks: {
           "Subproperty `Principals` is not a Array" => lambda { |v| v[:Principals].is_a? Array },
         },
         description: "The agent permissions attached to this profiling group."

property :anomaly_detection_notification_configuration, Array,
         callbacks: {
           "anomaly_detection_notification_configuration is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Configuration for Notification Channels for Anomaly Detection feature in CodeGuru Profiler which enables customers to detect anomalies in the application profile for those methods that represent the highest proportion of CPU time or latency"

property :compute_platform, String,
         callbacks: {
           "compute_platform is not a String" => lambda { |v| v.is_a? String },
           "compute_platformis not one of `Default`, `AWSLambda`" => lambda { |v| %w{Default AWSLambda}.include? v },
         },
         description: "The compute platform of the profiling group."

property :profiling_group_name, String,
         required: true,
         callbacks: {
           "profiling_group_name is not a String" => lambda { |v| v.is_a? String },
           "profiling_group_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "profiling_group_name must match pattern ^[\w-]+$" => lambda { |v| v =~ Regexp.new("/^[\w-]+$/") },
         },
         description: "The name of the profiling group."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The tags associated with a profiling group."

# API URLs and mappings
rest_api_collection "/AWS::CodeGuruProfiler::ProfilingGroup"
rest_api_document "/AWS::CodeGuruProfiler::ProfilingGroup"

rest_property_map({
  agent_permissions:                            "AgentPermissions",
  anomaly_detection_notification_configuration: "AnomalyDetectionNotificationConfiguration",
  compute_platform:                             "ComputePlatform",
  profiling_group_name:                         "ProfilingGroupName",
  tags:                                         "Tags",
})

rest_post_only_properties %i{
  compute_platform profiling_group_name
}
