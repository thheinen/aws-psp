# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_datasync_location_nfs
provides :aws_datasync_location_nfs, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::LocationNFS
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :mount_options, Hash,
         callbacks: {
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `Version`is not one of `AUTOMATIC`, `NFS3`, `NFS4_0`, `NFS4_1`" => lambda { |v| %w{AUTOMATIC NFS3 NFS4_0 NFS4_1}.include? v[:Version] },
         },
         description: ""

property :on_prem_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `AgentArns` is not a Array" => lambda { |v| v[:AgentArns].is_a? Array },
         },
         description: ""

property :server_hostname, String,
         required: true,
         callbacks: {
           "server_hostname is not a String" => lambda { |v| v.is_a? String },
           "server_hostname must match pattern ^(([a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9\-]*[A-Za-z0-9])$" => lambda { |v| v =~ Regexp.new("/^(([a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9\-]*[A-Za-z0-9])$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the NFS server. This value is the IP address or DNS name of the NFS server.
         DESCRIPTION

property :subdirectory, String,
         required: true,
         callbacks: {
           "subdirectory is not a String" => lambda { |v| v.is_a? String },
           "subdirectory must match pattern ^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$/") },
         },
         description: <<~'DESCRIPTION'
           The subdirectory in the NFS file system that is used to read data from the NFS source location or write data to the NFS destination.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DataSync::LocationNFS"
rest_api_document "/AWS::DataSync::LocationNFS"

rest_property_map({
  mount_options:   "MountOptions",
  on_prem_config:  "OnPremConfig",
  server_hostname: "ServerHostname",
  subdirectory:    "Subdirectory",
  tags:            "Tags",
})

rest_post_only_properties %i{
  server_hostname
}
