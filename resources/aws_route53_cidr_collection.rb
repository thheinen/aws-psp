# Import API specifics
use "awscc_base"

resource_name :aws_route53_cidr_collection
provides :aws_route53_cidr_collection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Route53::CidrCollection.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :locations, Array,
         callbacks: {
           "locations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A complex type that contains information about the list of CIDR locations."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern ^[0-9A-Za-z_\-]+$" => lambda { |v| v =~ Regexp.new("/^[0-9A-Za-z_\-]+$/") },
         },
         description: "A unique name for the CIDR collection."

# API URLs and mappings
rest_api_collection "/AWS::Route53::CidrCollection"
rest_api_document "/AWS::Route53::CidrCollection"

rest_property_map({
  locations: "Locations",
  name:      "Name",
})

rest_post_only_properties %i{
  name
}
