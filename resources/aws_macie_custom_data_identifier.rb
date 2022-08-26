# Import API specifics
use "awscc_base"

resource_name :aws_macie_custom_data_identifier
provides :aws_macie_custom_data_identifier, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Macie CustomDataIdentifier resource schema
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Description of custom data identifier."

property :ignore_words, Array,
         callbacks: {
           "ignore_words is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Words to be ignored."

property :keywords, Array,
         callbacks: {
           "keywords is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Keywords to be matched against."

property :maximum_match_distance, Integer,
         callbacks: {
           "maximum_match_distance is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "Maximum match distance."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Name of custom data identifier."

property :regex, String,
         required: true,
         callbacks: {
           "regex is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Regular expression for custom data identifier."

# API URLs and mappings
rest_api_collection "/AWS::Macie::CustomDataIdentifier"
rest_api_document "/AWS::Macie::CustomDataIdentifier"

rest_property_map({
  description:            "Description",
  ignore_words:           "IgnoreWords",
  keywords:               "Keywords",
  maximum_match_distance: "MaximumMatchDistance",
  name:                   "Name",
  regex:                  "Regex",
})

rest_post_only_properties %i{
  description ignore_words keywords maximum_match_distance name regex
}
