# Import API specifics
use "awscc_base"

resource_name :aws_route53resolver_outpost_resolver
provides :aws_route53resolver_outpost_resolver, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Route53Resolver::OutpostResolver.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :instance_count, Integer,
         callbacks: {
           "instance_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of OutpostResolvers.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The OutpostResolver name.
         DESCRIPTION

property :outpost_arn, String,
         required: true,
         callbacks: {
           "outpost_arn is not a String" => lambda { |v| v.is_a? String },
           "outpost_arn needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           The Outpost ARN.
         DESCRIPTION

property :preferred_instance_type, String,
         required: true,
         callbacks: {
           "preferred_instance_type is not a String" => lambda { |v| v.is_a? String },
           "preferred_instance_type needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The OutpostResolver instance type.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Route53Resolver::OutpostResolver"
rest_api_document "/AWS::Route53Resolver::OutpostResolver"

rest_property_map({
  instance_count:          "InstanceCount",
  name:                    "Name",
  outpost_arn:             "OutpostArn",
  preferred_instance_type: "PreferredInstanceType",
  tags:                    "Tags",
})

rest_post_only_properties %i{
  outpost_arn
}
