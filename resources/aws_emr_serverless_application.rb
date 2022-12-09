# Import API specifics
use "awscc_base"

resource_name :aws_emr_serverless_application
provides :aws_emr_serverless_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::EMRServerless::Application Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :architecture, Hash,
         callbacks: {
           "architecture is not a String" => lambda { |v| v.is_a? String },
           "architectureis not one of `ARM64`, `X86_64`" => lambda { |v| %w{ARM64 X86_64}.include? v },
         },
         description: ""

property :auto_start_configuration, Hash,
         callbacks: {
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Configuration for Auto Start of Application.
         DESCRIPTION

property :auto_stop_configuration, Hash,
         callbacks: {
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
           "Subproperty `IdleTimeoutMinutes` is not a Integer" => lambda { |v| v[:IdleTimeoutMinutes].is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Configuration for Auto Stop of Application.
         DESCRIPTION

property :initial_capacity, Hash,
         callbacks: {
           "initial_capacity is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Initial capacity initialized when an Application is started.
         DESCRIPTION

property :maximum_capacity, Hash,
         description: <<~'DESCRIPTION'
           Maximum allowed cumulative resources for an Application. No new resources will be created once the limit is hit.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern ^[A-Za-z0-9._\/#-]+$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9._\/#-]+$/") },
         },
         description: <<~'DESCRIPTION'
           User friendly Application name.
         DESCRIPTION

property :network_configuration, Hash,
         callbacks: {
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Network Configuration for customer VPC connectivity.
         DESCRIPTION

property :release_label, String,
         required: true,
         callbacks: {
           "release_label is not a String" => lambda { |v| v.is_a? String },
           "release_label needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "release_label must match pattern ^[A-Za-z0-9._/-]+$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9._/-]+$/") },
         },
         description: <<~'DESCRIPTION'
           EMR release label.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Tag map with key and value
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of the application
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EMRServerless::Application"
rest_api_document "/AWS::EMRServerless::Application"

rest_property_map({
  architecture:             "Architecture",
  auto_start_configuration: "AutoStartConfiguration",
  auto_stop_configuration:  "AutoStopConfiguration",
  initial_capacity:         "InitialCapacity",
  maximum_capacity:         "MaximumCapacity",
  name:                     "Name",
  network_configuration:    "NetworkConfiguration",
  release_label:            "ReleaseLabel",
  tags:                     "Tags",
  type:                     "Type",
})

rest_post_only_properties %i{
  name release_label type
}
