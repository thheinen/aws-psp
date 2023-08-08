# Import API specifics
use "awscc_base"

resource_name :aws_ec2_network_interface
provides :aws_ec2_network_interface, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::EC2::NetworkInterface resource creates network interface
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description for the network interface.
         DESCRIPTION

property :group_set, Array,
         callbacks: {
           "group_set is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of security group IDs associated with this network interface.
         DESCRIPTION

property :interface_type, String,
         callbacks: {
           "interface_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Indicates the type of network interface.
         DESCRIPTION

property :ipv4_prefix_count, Integer,
         callbacks: {
           "ipv4_prefix_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of IPv4 prefixes to assign to a network interface. When you specify a number of IPv4 prefixes, Amazon EC2 selects these prefixes from your existing subnet CIDR reservations, if available, or from free spaces in the subnet. By default, these will be /28 prefixes. You can't specify a count of IPv4 prefixes if you've specified one of the following: specific IPv4 prefixes, specific private IPv4 addresses, or a count of private IPv4 addresses.
         DESCRIPTION

property :ipv4_prefixes, Array,
         callbacks: {
           "ipv4_prefixes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Assigns a list of IPv4 prefixes to the network interface. If you want EC2 to automatically assign IPv4 prefixes, use the Ipv4PrefixCount property and do not specify this property. Presently, only /28 prefixes are supported. You can't specify IPv4 prefixes if you've specified one of the following: a count of IPv4 prefixes, specific private IPv4 addresses, or a count of private IPv4 addresses.
         DESCRIPTION

property :ipv6_address_count, Integer,
         callbacks: {
           "ipv6_address_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of IPv6 addresses to assign to a network interface. Amazon EC2 automatically selects the IPv6 addresses from the subnet range. To specify specific IPv6 addresses, use the Ipv6Addresses property and don't specify this property.
         DESCRIPTION

property :ipv6_addresses, Array,
         callbacks: {
           "ipv6_addresses is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more specific IPv6 addresses from the IPv6 CIDR block range of your subnet to associate with the network interface. If you're specifying a number of IPv6 addresses, use the Ipv6AddressCount property and don't specify this property.
         DESCRIPTION

property :ipv6_prefix_count, Integer,
         callbacks: {
           "ipv6_prefix_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of IPv6 prefixes to assign to a network interface. When you specify a number of IPv6 prefixes, Amazon EC2 selects these prefixes from your existing subnet CIDR reservations, if available, or from free spaces in the subnet. By default, these will be /80 prefixes. You can't specify a count of IPv6 prefixes if you've specified one of the following: specific IPv6 prefixes, specific IPv6 addresses, or a count of IPv6 addresses.
         DESCRIPTION

property :ipv6_prefixes, Array,
         callbacks: {
           "ipv6_prefixes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Assigns a list of IPv6 prefixes to the network interface. If you want EC2 to automatically assign IPv6 prefixes, use the Ipv6PrefixCount property and do not specify this property. Presently, only /80 prefixes are supported. You can't specify IPv6 prefixes if you've specified one of the following: a count of IPv6 prefixes, specific IPv6 addresses, or a count of IPv6 addresses.
         DESCRIPTION

property :private_ip_address, String,
         callbacks: {
           "private_ip_address is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Assigns a single private IP address to the network interface, which is used as the primary private IP address. If you want to specify multiple private IP address, use the PrivateIpAddresses property.
         DESCRIPTION

property :private_ip_addresses, Array,
         callbacks: {
           "private_ip_addresses is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Assigns a list of private IP addresses to the network interface. You can specify a primary private IP address by setting the value of the Primary property to true in the PrivateIpAddressSpecification property. If you want EC2 to automatically assign private IP addresses, use the SecondaryPrivateIpAddressCount property and do not specify this property.
         DESCRIPTION

property :secondary_private_ip_address_count, Integer,
         callbacks: {
           "secondary_private_ip_address_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of secondary private IPv4 addresses to assign to a network interface. When you specify a number of secondary IPv4 addresses, Amazon EC2 selects these IP addresses within the subnet's IPv4 CIDR range. You can't specify this option and specify more than one private IP address using privateIpAddresses
         DESCRIPTION

property :source_dest_check, [TrueClass, FalseClass],
         callbacks: {
           "source_dest_check is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether traffic to or from the instance is validated.
         DESCRIPTION

property :subnet_id, String,
         required: true,
         callbacks: {
           "subnet_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the subnet to associate with the network interface.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An arbitrary set of tags (key-value pairs) for this network interface.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::NetworkInterface"
rest_api_document "/AWS::EC2::NetworkInterface"

rest_property_map({
  description:                        "Description",
  group_set:                          "GroupSet",
  interface_type:                     "InterfaceType",
  ipv4_prefix_count:                  "Ipv4PrefixCount",
  ipv4_prefixes:                      "Ipv4Prefixes",
  ipv6_address_count:                 "Ipv6AddressCount",
  ipv6_addresses:                     "Ipv6Addresses",
  ipv6_prefix_count:                  "Ipv6PrefixCount",
  ipv6_prefixes:                      "Ipv6Prefixes",
  private_ip_address:                 "PrivateIpAddress",
  private_ip_addresses:               "PrivateIpAddresses",
  secondary_private_ip_address_count: "SecondaryPrivateIpAddressCount",
  source_dest_check:                  "SourceDestCheck",
  subnet_id:                          "SubnetId",
  tags:                               "Tags",
})

rest_post_only_properties %i{
  interface_type private_ip_address subnet_id
}
