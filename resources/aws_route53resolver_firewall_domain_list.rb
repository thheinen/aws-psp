# Import API specifics
use "awscc_base"

resource_name :aws_route53resolver_firewall_domain_list
provides :aws_route53resolver_firewall_domain_list, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Route53Resolver::FirewallDomainList.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain_file_url, String,
         callbacks: {
           "domain_file_url is not a String" => lambda { |v| v.is_a? String },
           "domain_file_url needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           S3 URL to import domains from.
         DESCRIPTION

property :domains, Hash,
         callbacks: {
           "domains is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern (?!^[0-9]+$)([a-zA-Z0-9\-_' ']+)" => lambda { |v| v =~ Regexp.new("/(?!^[0-9]+$)([a-zA-Z0-9\-_' ']+)/") },
         },
         description: <<~'DESCRIPTION'
           FirewallDomainListName
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Tags
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Route53Resolver::FirewallDomainList"
rest_api_document "/AWS::Route53Resolver::FirewallDomainList"

rest_property_map({
  domain_file_url: "DomainFileUrl",
  domains:         "Domains",
  name:            "Name",
  tags:            "Tags",
})

rest_post_only_properties %i{
  name
}
