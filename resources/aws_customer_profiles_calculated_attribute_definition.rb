# Import API specifics
use "awscc_base"

resource_name :aws_customer_profiles_calculated_attribute_definition
provides :aws_customer_profiles_calculated_attribute_definition, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A calculated attribute definition for Customer Profiles
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :attribute_details, Hash,
         required: true,
         description: ""

property :calculated_attribute_name, Hash,
         required: true,
         callbacks: {
           "calculated_attribute_name is not a String" => lambda { |v| v.is_a? String },
           "calculated_attribute_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "calculated_attribute_name must match pattern ^[a-zA-Z_][a-zA-Z_0-9-]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z_][a-zA-Z_0-9-]*$/") },
         },
         description: ""

property :conditions, Hash,
         description: ""

property :description, Hash,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000 },
         },
         description: ""

property :display_name, Hash,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
           "display_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "display_name must match pattern ^[a-zA-Z_][a-zA-Z_0-9-\s]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z_][a-zA-Z_0-9-\s]*$/") },
         },
         description: ""

property :domain_name, Hash,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
           "domain_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "domain_name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: ""

property :statistic, Hash,
         required: true,
         callbacks: {
           "statistic is not a String" => lambda { |v| v.is_a? String },
           "statisticis not one of `FIRST_OCCURRENCE`, `LAST_OCCURRENCE`, `COUNT`, `SUM`, `MINIMUM`, `MAXIMUM`, `AVERAGE`, `MAX_OCCURRENCE`" => lambda { |v| %w{FIRST_OCCURRENCE LAST_OCCURRENCE COUNT SUM MINIMUM MAXIMUM AVERAGE MAX_OCCURRENCE}.include? v },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CustomerProfiles::CalculatedAttributeDefinition"
rest_api_document "/AWS::CustomerProfiles::CalculatedAttributeDefinition"

rest_property_map({
  attribute_details:         "AttributeDetails",
  calculated_attribute_name: "CalculatedAttributeName",
  conditions:                "Conditions",
  description:               "Description",
  display_name:              "DisplayName",
  domain_name:               "DomainName",
  statistic:                 "Statistic",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  calculated_attribute_name domain_name
}
