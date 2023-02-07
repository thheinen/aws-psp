# Import API specifics
use "awscc_base"

resource_name :aws_datasync_location_object_storage
provides :aws_datasync_location_object_storage, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::LocationObjectStorage.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_key, String,
         callbacks: {
           "access_key is not a String" => lambda { |v| v.is_a? String },
           "access_key needs to be 8..200 characters" => lambda { |v| v.length >= 8 && v.length <= 200 },
           "access_key must match pattern ^.+$" => lambda { |v| v =~ Regexp.new("/^.+$/") },
         },
         description: <<~'DESCRIPTION'
           Optional. The access key is used if credentials are required to access the self-managed object storage server.
         DESCRIPTION

property :agent_arns, Array,
         required: true,
         callbacks: {
           "agent_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the agents associated with the self-managed object storage server location.
         DESCRIPTION

property :bucket_name, String,
         callbacks: {
           "bucket_name is not a String" => lambda { |v| v.is_a? String },
           "bucket_name needs to be 3..63 characters" => lambda { |v| v.length >= 3 && v.length <= 63 },
           "bucket_name must match pattern ^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the bucket on the self-managed object storage server.
         DESCRIPTION

property :secret_key, String,
         callbacks: {
           "secret_key is not a String" => lambda { |v| v.is_a? String },
           "secret_key needs to be 8..200 characters" => lambda { |v| v.length >= 8 && v.length <= 200 },
           "secret_key must match pattern ^.+$" => lambda { |v| v =~ Regexp.new("/^.+$/") },
         },
         description: <<~'DESCRIPTION'
           Optional. The secret key is used if credentials are required to access the self-managed object storage server.
         DESCRIPTION

property :server_certificate, String,
         callbacks: {
           "server_certificate is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           X.509 PEM content containing a certificate authority or chain to trust.
         DESCRIPTION

property :server_hostname, String,
         callbacks: {
           "server_hostname is not a String" => lambda { |v| v.is_a? String },
           "server_hostname must match pattern ^(([a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9\-]*[A-Za-z0-9])$" => lambda { |v| v =~ Regexp.new("/^(([a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9\-]*[A-Za-z0-9])$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the self-managed object storage server. This value is the IP address or Domain Name Service (DNS) name of the object storage server.
         DESCRIPTION

property :server_port, Integer,
         callbacks: {
           "server_port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The port that your self-managed server accepts inbound network traffic on.
         DESCRIPTION

property :server_protocol, String,
         callbacks: {
           "server_protocol is not a String" => lambda { |v| v.is_a? String },
           "server_protocolis not one of `HTTPS`, `HTTP`" => lambda { |v| %w{HTTPS HTTP}.include? v },
         },
         description: <<~'DESCRIPTION'
           The protocol that the object storage server uses to communicate.
         DESCRIPTION

property :subdirectory, String,
         callbacks: {
           "subdirectory is not a String" => lambda { |v| v.is_a? String },
           "subdirectory must match pattern ^[a-zA-Z0-9_\-\+\./\(\)\p{Zs}]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-\+\./\(\)\p{Zs}]*$/") },
         },
         description: <<~'DESCRIPTION'
           The subdirectory in the self-managed object storage server that is used to read data from.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DataSync::LocationObjectStorage"
rest_api_document "/AWS::DataSync::LocationObjectStorage"

rest_property_map({
  access_key:         "AccessKey",
  agent_arns:         "AgentArns",
  bucket_name:        "BucketName",
  secret_key:         "SecretKey",
  server_certificate: "ServerCertificate",
  server_hostname:    "ServerHostname",
  server_port:        "ServerPort",
  server_protocol:    "ServerProtocol",
  subdirectory:       "Subdirectory",
  tags:               "Tags",
})

rest_post_only_properties %i{
  bucket_name server_hostname
}
