# Import API specifics
use "awscc_base"

resource_name :aws_wafv2_regex_pattern_set
provides :aws_wafv2_regex_pattern_set, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Contains a list of Regular expressions based on the provided inputs. RegexPatternSet can be used with other WAF entities with RegexPatternSetReferenceStatement to perform other actions .
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern ^[a-zA-Z0-9=:#@/\-,.][a-zA-Z0-9+=:#@/\-,.\s]+[a-zA-Z0-9+=:#@/\-,.]{1,256}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9=:#@/\-,.][a-zA-Z0-9+=:#@/\-,.\s]+[a-zA-Z0-9+=:#@/\-,.]{1,256}$/") },
         },
         description: "Description of the entity."

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[0-9A-Za-z_-]{1,128}$" => lambda { |v| v =~ Regexp.new("/^[0-9A-Za-z_-]{1,128}$/") },
         },
         description: "Name of the RegexPatternSet."

property :regular_expression_list, Array,
         required: true,
         callbacks: {
           "regular_expression_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :scope, String,
         required: true,
         callbacks: {
           "scope is not a String" => lambda { |v| v.is_a? String },
           "scopeis not one of `CLOUDFRONT`, `REGIONAL`" => lambda { |v| %w{CLOUDFRONT REGIONAL}.include? v },
         },
         description: "Use CLOUDFRONT for CloudFront RegexPatternSet, use REGIONAL for Application Load Balancer and API Gateway."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WAFv2::RegexPatternSet"
rest_api_document "/AWS::WAFv2::RegexPatternSet"

rest_property_map({
  description:             "Description",
  name:                    "Name",
  regular_expression_list: "RegularExpressionList",
  scope:                   "Scope",
  tags:                    "Tags",
})

rest_post_only_properties %i{
  name scope
}
