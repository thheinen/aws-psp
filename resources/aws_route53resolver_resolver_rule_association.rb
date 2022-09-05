# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_route53resolver_resolver_rule_association
provides :aws_route53resolver_resolver_rule_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Route53Resolver::ResolverRuleAssociation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of an association between a Resolver rule and a VPC.
         DESCRIPTION

property :resolver_rule_id, String,
         required: true,
         callbacks: {
           "resolver_rule_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the Resolver rule that you associated with the VPC that is specified by VPCId.
         DESCRIPTION

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the VPC that you associated the Resolver rule with.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Route53Resolver::ResolverRuleAssociation"
rest_api_document "/AWS::Route53Resolver::ResolverRuleAssociation"

rest_property_map({
  name:             "Name",
  resolver_rule_id: "ResolverRuleId",
  vpc_id:           "VPCId",
})

rest_post_only_properties %i{
  name resolver_rule_id vpc_id
}
