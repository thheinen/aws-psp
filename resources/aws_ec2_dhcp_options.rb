# Import API specifics
use "awscc_base"

resource_name :aws_ec2_dhcp_options
provides :aws_ec2_dhcp_options, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::DHCPOptions
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain_name, String,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "This value is used to complete unqualified DNS hostnames."

property :domain_name_servers, Array,
         callbacks: {
           "domain_name_servers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The IPv4 addresses of up to four domain name servers, or AmazonProvidedDNS."

property :netbios_name_servers, Array,
         callbacks: {
           "netbios_name_servers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The IPv4 addresses of up to four NetBIOS name servers."

property :netbios_node_type, Integer,
         callbacks: {
           "netbios_node_type is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The NetBIOS node type (1, 2, 4, or 8)."

property :ntp_servers, Array,
         callbacks: {
           "ntp_servers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The IPv4 addresses of up to four Network Time Protocol (NTP) servers."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Any tags assigned to the DHCP options set."

# API URLs and mappings
rest_api_collection "/AWS::EC2::DHCPOptions"
rest_api_document "/AWS::EC2::DHCPOptions"

rest_property_map({
  domain_name:          "DomainName",
  domain_name_servers:  "DomainNameServers",
  netbios_name_servers: "NetbiosNameServers",
  netbios_node_type:    "NetbiosNodeType",
  ntp_servers:          "NtpServers",
  tags:                 "Tags",
})

rest_post_only_properties %i{
  domain_name domain_name_servers netbios_name_servers netbios_node_type ntp_servers
}
