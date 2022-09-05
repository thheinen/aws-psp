# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_codestar_connections_connection
provides :aws_codestar_connections_connection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for AWS::CodeStarConnections::Connection resource which can be used to connect external source providers with AWS CodePipeline
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :connection_name, String,
         required: true,
         callbacks: {
           "connection_name is not a String" => lambda { |v| v.is_a? String },
           "connection_name needs to be 1..32 characters" => lambda { |v| v.length >= 1 && v.length <= 32 },
         },
         description: <<~'DESCRIPTION'
           The name of the connection. Connection names must be unique in an AWS user account.
         DESCRIPTION

property :host_arn, String,
         callbacks: {
           "host_arn is not a String" => lambda { |v| v.is_a? String },
           "host_arn needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
           "host_arn must match pattern arn:aws(-[\w]+)*:.+:.+:[0-9]{12}:.+" => lambda { |v| v =~ Regexp.new("/arn:aws(-[\w]+)*:.+:.+:[0-9]{12}:.+/") },
         },
         description: <<~'DESCRIPTION'
           The host arn configured to represent the infrastructure where your third-party provider is installed. You must specify either a ProviderType or a HostArn.
         DESCRIPTION

property :provider_type, String,
         callbacks: {
           "provider_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the external provider where your third-party code repository is configured. You must specify either a ProviderType or a HostArn.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Specifies the tags applied to a connection.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CodeStarConnections::Connection"
rest_api_document "/AWS::CodeStarConnections::Connection"

rest_property_map({
  connection_name: "ConnectionName",
  host_arn:        "HostArn",
  provider_type:   "ProviderType",
  tags:            "Tags",
})

rest_post_only_properties %i{
  connection_name host_arn provider_type
}
