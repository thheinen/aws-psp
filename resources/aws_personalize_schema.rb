# Import API specifics
use "awscc_base"

resource_name :aws_personalize_schema
provides :aws_personalize_schema, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Personalize::Schema.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain, String,
         callbacks: {
           "domain is not a String" => lambda { |v| v.is_a? String },
           "domainis not one of `ECOMMERCE`, `VIDEO_ON_DEMAND`" => lambda { |v| %w{ECOMMERCE VIDEO_ON_DEMAND}.include? v },
         },
         description: "The domain of a Domain dataset group."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "name must match pattern ^[a-zA-Z0-9][a-zA-Z0-9\-_]*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9\-_]*/") },
         },
         description: "Name for the schema."

property :schema, String,
         required: true,
         callbacks: {
           "schema is not a String" => lambda { |v| v.is_a? String },
         },
         description: "A schema in Avro JSON format."

# API URLs and mappings
rest_api_collection "/AWS::Personalize::Schema"
rest_api_document "/AWS::Personalize::Schema"

rest_property_map({
  domain: "Domain",
  name:   "Name",
  schema: "Schema",
})

rest_post_only_properties %i{
  domain name schema
}
