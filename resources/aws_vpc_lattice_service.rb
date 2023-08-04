# Import API specifics
use "awscc_base"

resource_name :aws_vpc_lattice_service
provides :aws_vpc_lattice_service, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A service is any software application that can run on instances containers, or serverless functions within an account or virtual private cloud (VPC).
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auth_type, String,
         callbacks: {
           "auth_type is not a String" => lambda { |v| v.is_a? String },
           "auth_typeis not one of `NONE`, `AWS_IAM`" => lambda { |v| %w{NONE AWS_IAM}.include? v },
         },
         description: ""

property :certificate_arn, String,
         callbacks: {
           "certificate_arn is not a String" => lambda { |v| v.is_a? String },
           "certificate_arn must match pattern ^(arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:certificate/[0-9a-z-]+)?$" => lambda { |v| v =~ Regexp.new("/^(arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:certificate/[0-9a-z-]+)?$/") },
         },
         description: ""

property :custom_domain_name, String,
         callbacks: {
           "custom_domain_name is not a String" => lambda { |v| v.is_a? String },
           "custom_domain_name needs to be 3..255 characters" => lambda { |v| v.length >= 3 && v.length <= 255 },
         },
         description: ""

property :dns_entry, Hash,
         callbacks: {
           "Subproperty `DomainName` is not a String" => lambda { |v| v[:DomainName].is_a? String },
           "Subproperty `HostedZoneId` is not a String" => lambda { |v| v[:HostedZoneId].is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..40 characters" => lambda { |v| v.length >= 3 && v.length <= 40 },
           "name must match pattern ^(?!svc-)(?![-])(?!.*[-]$)(?!.*[-]{2})[a-z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^(?!svc-)(?![-])(?!.*[-]$)(?!.*[-]{2})[a-z0-9-]+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VpcLattice::Service"
rest_api_document "/AWS::VpcLattice::Service"

rest_property_map({
  auth_type:          "AuthType",
  certificate_arn:    "CertificateArn",
  custom_domain_name: "CustomDomainName",
  dns_entry:          "DnsEntry",
  name:               "Name",
  tags:               "Tags",
})

rest_post_only_properties %i{
  custom_domain_name name
}
