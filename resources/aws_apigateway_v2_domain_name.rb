# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_apigateway_v2_domain_name
provides :aws_apigateway_v2_domain_name, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGatewayV2::DomainName
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :domain_name_configurations, Array,
         callbacks: {
           "domain_name_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :mutual_tls_authentication, Hash,
         callbacks: {
           "Subproperty `TruststoreVersion` is not a String" => lambda { |v| v[:TruststoreVersion].is_a? String },
           "Subproperty `TruststoreUri` is not a String" => lambda { |v| v[:TruststoreUri].is_a? String },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           This resource type use map for Tags, suggest to use List of Tag
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGatewayV2::DomainName"
rest_api_document "/AWS::ApiGatewayV2::DomainName"

rest_property_map({
  domain_name:                "DomainName",
  domain_name_configurations: "DomainNameConfigurations",
  mutual_tls_authentication:  "MutualTlsAuthentication",
  tags:                       "Tags",
})

rest_post_only_properties %i{
  domain_name
}
