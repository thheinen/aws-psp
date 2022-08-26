# Import API specifics
use "awscc_base"

resource_name :aws_lightsail_load_balancer_tls_certificate
provides :aws_lightsail_load_balancer_tls_certificate, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lightsail::LoadBalancerTlsCertificate
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :certificate_alternative_names, Array,
         callbacks: {
           "certificate_alternative_names is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of strings listing alternative domains and subdomains for your SSL/TLS certificate."

property :certificate_domain_name, String,
         required: true,
         callbacks: {
           "certificate_domain_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The domain name (e.g., example.com ) for your SSL/TLS certificate."

property :certificate_name, String,
         required: true,
         callbacks: {
           "certificate_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The SSL/TLS certificate name."

property :https_redirection_enabled, [TrueClass, FalseClass],
         callbacks: {
           "https_redirection_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "A Boolean value that indicates whether HTTPS redirection is enabled for the load balancer."

property :is_attached, [TrueClass, FalseClass],
         callbacks: {
           "is_attached is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "When true, the SSL/TLS certificate is attached to the Lightsail load balancer."

property :load_balancer_name, String,
         required: true,
         callbacks: {
           "load_balancer_name is not a String" => lambda { |v| v.is_a? String },
           "load_balancer_name must match pattern \w[\w\-]*\w" => lambda { |v| v =~ Regexp.new("/\w[\w\-]*\w/") },
         },
         description: "The name of your load balancer."

# API URLs and mappings
rest_api_collection "/AWS::Lightsail::LoadBalancerTlsCertificate"
rest_api_document "/AWS::Lightsail::LoadBalancerTlsCertificate"

rest_property_map({
  certificate_alternative_names: "CertificateAlternativeNames",
  certificate_domain_name:       "CertificateDomainName",
  certificate_name:              "CertificateName",
  https_redirection_enabled:     "HttpsRedirectionEnabled",
  is_attached:                   "IsAttached",
  load_balancer_name:            "LoadBalancerName",
})

rest_post_only_properties %i{
  certificate_alternative_names certificate_domain_name certificate_name load_balancer_name
}
