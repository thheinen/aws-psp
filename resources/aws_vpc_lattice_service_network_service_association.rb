# Import API specifics
use "awscc_base"

resource_name :aws_vpc_lattice_service_network_service_association
provides :aws_vpc_lattice_service_network_service_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Associates a service with a service network.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :dns_entry, Hash,
         callbacks: {
           "Subproperty `DomainName` is not a String" => lambda { |v| v[:DomainName].is_a? String },
           "Subproperty `HostedZoneId` is not a String" => lambda { |v| v[:HostedZoneId].is_a? String },
         },
         description: ""

property :service_identifier, String,
         callbacks: {
           "service_identifier is not a String" => lambda { |v| v.is_a? String },
           "service_identifier needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "service_identifier must match pattern ^((svc-[0-9a-z]{17})|(arn:[a-z0-9\-]+:vpc-lattice:[a-zA-Z0-9\-]+:\d{12}:service/svc-[0-9a-z]{17}))$" => lambda { |v| v =~ Regexp.new("/^((svc-[0-9a-z]{17})|(arn:[a-z0-9\-]+:vpc-lattice:[a-zA-Z0-9\-]+:\d{12}:service/svc-[0-9a-z]{17}))$/") },
         },
         description: ""

property :service_network_identifier, String,
         callbacks: {
           "service_network_identifier is not a String" => lambda { |v| v.is_a? String },
           "service_network_identifier needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "service_network_identifier must match pattern ^((sn-[0-9a-z]{17})|(arn:[a-z0-9\-]+:vpc-lattice:[a-zA-Z0-9\-]+:\d{12}:servicenetwork/sn-[0-9a-z]{17}))$" => lambda { |v| v =~ Regexp.new("/^((sn-[0-9a-z]{17})|(arn:[a-z0-9\-]+:vpc-lattice:[a-zA-Z0-9\-]+:\d{12}:servicenetwork/sn-[0-9a-z]{17}))$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VpcLattice::ServiceNetworkServiceAssociation"
rest_api_document "/AWS::VpcLattice::ServiceNetworkServiceAssociation"

rest_property_map({
  dns_entry:                  "DnsEntry",
  service_identifier:         "ServiceIdentifier",
  service_network_identifier: "ServiceNetworkIdentifier",
  tags:                       "Tags",
})

rest_post_only_properties %i{
  service_identifier service_network_identifier
}
