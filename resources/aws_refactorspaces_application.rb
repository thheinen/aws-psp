# Import API specifics
use "awscc_base"

resource_name :aws_refactorspaces_application
provides :aws_refactorspaces_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::RefactorSpaces::Application Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :apigateway_proxy, Hash,
         callbacks: {
           "Subproperty `StageName` is not a String" => lambda { |v| v[:StageName].is_a? String },
           "Subproperty `StageName` needs to be 1..128 characters" => lambda { |v| v[:StageName].length >= 1 && v[:StageName].length <= 128 },
           "Subproperty `StageName` must match pattern ^[-a-zA-Z0-9_]*$" => lambda { |v| v[:StageName] =~ Regexp.new("/^[-a-zA-Z0-9_]*$/") },
         },
         description: ""

property :environment_identifier, String,
         callbacks: {
           "environment_identifier is not a String" => lambda { |v| v.is_a? String },
           "environment_identifier needs to be 14..14 characters" => lambda { |v| v.length >= 14 && v.length <= 14 },
           "environment_identifier must match pattern ^env-([0-9A-Za-z]{10}$)" => lambda { |v| v =~ Regexp.new("/^env-([0-9A-Za-z]{10}$)/") },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..63 characters" => lambda { |v| v.length >= 3 && v.length <= 63 },
           "name must match pattern ^(?!app-)[a-zA-Z0-9]+[a-zA-Z0-9-_ ]+$" => lambda { |v| v =~ Regexp.new("/^(?!app-)[a-zA-Z0-9]+[a-zA-Z0-9-_ ]+$/") },
         },
         description: ""

property :proxy_type, Hash,
         callbacks: {
           "proxy_type is not a String" => lambda { |v| v.is_a? String },
           "proxy_typeis not one of `API_GATEWAY`" => lambda { |v| %w{API_GATEWAY}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Metadata that you can assign to help organize the frameworks that you create. Each tag is a key-value pair.
         DESCRIPTION

property :vpc_id, String,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
           "vpc_id needs to be 12..21 characters" => lambda { |v| v.length >= 12 && v.length <= 21 },
           "vpc_id must match pattern ^vpc-[-a-f0-9]{8}([-a-f0-9]{9})?$" => lambda { |v| v =~ Regexp.new("/^vpc-[-a-f0-9]{8}([-a-f0-9]{9})?$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RefactorSpaces::Application"
rest_api_document "/AWS::RefactorSpaces::Application"

rest_property_map({
  apigateway_proxy:       "ApiGatewayProxy",
  environment_identifier: "EnvironmentIdentifier",
  name:                   "Name",
  proxy_type:             "ProxyType",
  tags:                   "Tags",
  vpc_id:                 "VpcId",
})

rest_post_only_properties %i{
  apigateway_proxy environment_identifier name proxy_type vpc_id
}
