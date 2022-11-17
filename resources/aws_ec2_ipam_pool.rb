# Import API specifics
use "awscc_base"

resource_name :aws_ec2_ipam_pool
provides :aws_ec2_ipam_pool, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema of AWS::EC2::IPAMPool Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :address_family, String,
         required: true,
         callbacks: {
           "address_family is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The address family of the address space in this pool. Either IPv4 or IPv6.
         DESCRIPTION

property :allocation_default_netmask_length, Integer,
         callbacks: {
           "allocation_default_netmask_length is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The default netmask length for allocations made from this pool. This value is used when the netmask length of an allocation isn't specified.
         DESCRIPTION

property :allocation_max_netmask_length, Integer,
         callbacks: {
           "allocation_max_netmask_length is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The maximum allowed netmask length for allocations made from this pool.
         DESCRIPTION

property :allocation_min_netmask_length, Integer,
         callbacks: {
           "allocation_min_netmask_length is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The minimum allowed netmask length for allocations made from this pool.
         DESCRIPTION

property :allocation_resource_tags, Array,
         callbacks: {
           "allocation_resource_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           When specified, an allocation will not be allowed unless a resource has a matching set of tags.
         DESCRIPTION

property :auto_import, [TrueClass, FalseClass],
         callbacks: {
           "auto_import is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Determines what to do if IPAM discovers resources that haven't been assigned an allocation. If set to true, an allocation will be made automatically.
         DESCRIPTION

property :aws_service, String,
         callbacks: {
           "aws_service is not a String" => lambda { |v| v.is_a? String },
           "aws_serviceis not one of `ec2`" => lambda { |v| %w{ec2}.include? v },
         },
         description: <<~'DESCRIPTION'
           Limits which service in Amazon Web Services that the pool can be used in.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :ipam_scope_id, String,
         required: true,
         callbacks: {
           "ipam_scope_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Id of the scope this pool is a part of.
         DESCRIPTION

property :locale, String,
         callbacks: {
           "locale is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The region of this pool. If not set, this will default to "None" which will disable non-custom allocations. If the locale has been specified for the source pool, this value must match.
         DESCRIPTION

property :provisioned_cidrs, Array,
         callbacks: {
           "provisioned_cidrs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of cidrs representing the address space available for allocation in this pool.
         DESCRIPTION

property :publicly_advertisable, [TrueClass, FalseClass],
         callbacks: {
           "publicly_advertisable is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Determines whether or not address space from this pool is publicly advertised. Must be set if and only if the pool is IPv6.
         DESCRIPTION

property :source_ipam_pool_id, String,
         callbacks: {
           "source_ipam_pool_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Id of this pool's source. If set, all space provisioned in this pool must be free space provisioned in the parent pool.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::IPAMPool"
rest_api_document "/AWS::EC2::IPAMPool"

rest_property_map({
  address_family:                    "AddressFamily",
  allocation_default_netmask_length: "AllocationDefaultNetmaskLength",
  allocation_max_netmask_length:     "AllocationMaxNetmaskLength",
  allocation_min_netmask_length:     "AllocationMinNetmaskLength",
  allocation_resource_tags:          "AllocationResourceTags",
  auto_import:                       "AutoImport",
  aws_service:                       "AwsService",
  description:                       "Description",
  ipam_scope_id:                     "IpamScopeId",
  locale:                            "Locale",
  provisioned_cidrs:                 "ProvisionedCidrs",
  publicly_advertisable:             "PubliclyAdvertisable",
  source_ipam_pool_id:               "SourceIpamPoolId",
  tags:                              "Tags",
})

rest_post_only_properties %i{
  address_family aws_service ipam_scope_id locale publicly_advertisable source_ipam_pool_id
}
