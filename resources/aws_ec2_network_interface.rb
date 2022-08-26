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
         description: "A description for the network interface."

property :group_set, Array,
         callbacks: {
           "group_set is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of security group IDs associated with this network interface."

property :interface_type, String,
         callbacks: {
           "interface_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Indicates the type of network interface."

property :ipv6_address_count, Integer,
         callbacks: {
           "ipv6_address_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The number of IPv6 addresses to assign to a network interface. Amazon EC2 automatically selects the IPv6 addresses from the subnet range. To specify specific IPv6 addresses, use the Ipv6Addresses property and don't specify this property."

property :ipv6_addresses, Array,
         callbacks: {
           "ipv6_addresses is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "One or more specific IPv6 addresses from the IPv6 CIDR block range of your subnet to associate with the network interface. If you're specifying a number of IPv6 addresses, use the Ipv6AddressCount property and don't specify this property."

property :private_ip_address, String,
         callbacks: {
           "private_ip_address is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Assigns a single private IP address to the network interface, which is used as the primary private IP address. If you want to specify multiple private IP address, use the PrivateIpAddresses property. "

property :private_ip_addresses, Array,
         callbacks: {
           "private_ip_addresses is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Assigns a list of private IP addresses to the network interface. You can specify a primary private IP address by setting the value of the Primary property to true in the PrivateIpAddressSpecification property. If you want EC2 to automatically assign private IP addresses, use the SecondaryPrivateIpAddressCount property and do not specify this property."

property :secondary_private_ip_address_count, Integer,
         callbacks: {
           "secondary_private_ip_address_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The number of secondary private IPv4 addresses to assign to a network interface. When you specify a number of secondary IPv4 addresses, Amazon EC2 selects these IP addresses within the subnet's IPv4 CIDR range. You can't specify this option and specify more than one private IP address using privateIpAddresses"

property :source_dest_check, [TrueClass, FalseClass],
         callbacks: {
           "source_dest_check is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "Indicates whether traffic to or from the instance is validated."

property :subnet_id, String,
         required: true,
         callbacks: {
           "subnet_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the subnet to associate with the network interface."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An arbitrary set of tags (key-value pairs) for this network interface."

# API URLs and mappings
rest_api_collection "/AWS::EC2::NetworkInterface"
rest_api_document "/AWS::EC2::NetworkInterface"

rest_property_map({
  description:                        "Description",
  group_set:                          "GroupSet",
  interface_type:                     "InterfaceType",
  ipv6_address_count:                 "Ipv6AddressCount",
  ipv6_addresses:                     "Ipv6Addresses",
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
