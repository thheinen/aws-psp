# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_domain_name
provides :aws_apigateway_v2_domain_name, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The ``AWS::ApiGatewayV2::DomainName`` resource specifies a custom domain name for your API in Amazon API Gateway (API Gateway).
 You can use a custom domain name to provide a URL that's more intuitive and easier to recall. For more information about using custom domain names, see [Set up Custom Domain Name for an API in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-custom-domains.html) in the *API Gateway Developer Guide*.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The custom domain name for your API in Amazon API Gateway. Uppercase letters are not supported.
         DESCRIPTION

property :domain_name_configurations, Array,
         callbacks: {
           "domain_name_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The domain name configurations.
         DESCRIPTION

property :mutual_tls_authentication, Hash,
         callbacks: {
           "Subproperty `TruststoreVersion` is not a String" => lambda { |v| v[:TruststoreVersion].is_a? String },
           "Subproperty `TruststoreUri` is not a String" => lambda { |v| v[:TruststoreUri].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The mutual TLS authentication configuration for a custom domain name.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The collection of tags associated with a domain name.
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
