# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_datasync_location_smb
provides :aws_datasync_location_smb, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::LocationSMB.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :agent_arns, Array,
         required: true,
         callbacks: {
           "agent_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Names (ARNs) of agents to use for a Simple Message Block (SMB) location.
         DESCRIPTION

property :domain, String,
         callbacks: {
           "domain is not a String" => lambda { |v| v.is_a? String },
           "domain must match pattern ^([A-Za-z0-9]+[A-Za-z0-9-.]*)*[A-Za-z0-9-]*[A-Za-z0-9]$" => lambda { |v| v =~ Regexp.new("/^([A-Za-z0-9]+[A-Za-z0-9-.]*)*[A-Za-z0-9-]*[A-Za-z0-9]$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the Windows domain that the SMB server belongs to.
         DESCRIPTION

property :mount_options, Hash,
         callbacks: {
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `Version`is not one of `AUTOMATIC`, `SMB2`, `SMB3`" => lambda { |v| %w{AUTOMATIC SMB2 SMB3}.include? v[:Version] },
         },
         description: ""

property :password, String,
         required: true,
         callbacks: {
           "password is not a String" => lambda { |v| v.is_a? String },
           "password must match pattern ^.{0,104}$" => lambda { |v| v =~ Regexp.new("/^.{0,104}$/") },
         },
         description: <<~'DESCRIPTION'
           The password of the user who can mount the share and has the permissions to access files and folders in the SMB share.
         DESCRIPTION

property :server_hostname, String,
         required: true,
         callbacks: {
           "server_hostname is not a String" => lambda { |v| v.is_a? String },
           "server_hostname must match pattern ^(([a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9\-]*[A-Za-z0-9])$" => lambda { |v| v =~ Regexp.new("/^(([a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9\-]*[A-Za-z0-9])$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the SMB server. This value is the IP address or Domain Name Service (DNS) name of the SMB server.
         DESCRIPTION

property :subdirectory, String,
         required: true,
         callbacks: {
           "subdirectory is not a String" => lambda { |v| v.is_a? String },
           "subdirectory must match pattern ^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$/") },
         },
         description: <<~'DESCRIPTION'
           The subdirectory in the SMB file system that is used to read data from the SMB source location or write data to the SMB destination
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :user, String,
         required: true,
         callbacks: {
           "user is not a String" => lambda { |v| v.is_a? String },
           "user must match pattern ^[^\x5B\x5D\\/:;|=,+*?]{1,104}$" => lambda { |v| v =~ Regexp.new("/^[^\x5B\x5D\\/:;|=,+*?]{1,104}$/") },
         },
         description: <<~'DESCRIPTION'
           The user who can mount the share, has the permissions to access files and folders in the SMB share.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DataSync::LocationSMB"
rest_api_document "/AWS::DataSync::LocationSMB"

rest_property_map({
  agent_arns:      "AgentArns",
  domain:          "Domain",
  mount_options:   "MountOptions",
  password:        "Password",
  server_hostname: "ServerHostname",
  subdirectory:    "Subdirectory",
  tags:            "Tags",
  user:            "User",
})

rest_post_only_properties %i{
  server_hostname
}
