# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_lex_bot_version
provides :aws_lex_bot_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A version is a numbered snapshot of your work that you can publish for use in different parts of your workflow, such as development, beta deployment, and production.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bot_id, Hash,
         required: true,
         callbacks: {
           "bot_id is not a String" => lambda { |v| v.is_a? String },
           "bot_id needs to be 10..10 characters" => lambda { |v| v.length >= 10 && v.length <= 10 },
           "bot_id must match pattern ^[0-9a-zA-Z]+$" => lambda { |v| v =~ Regexp.new("/^[0-9a-zA-Z]+$/") },
         },
         description: ""

property :bot_version_locale_specification, Hash,
         required: true,
         callbacks: {
           "bot_version_locale_specification is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :description, Hash,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Lex::BotVersion"
rest_api_document "/AWS::Lex::BotVersion"

rest_property_map({
  bot_id:                           "BotId",
  bot_version_locale_specification: "BotVersionLocaleSpecification",
  description:                      "Description",
})

rest_post_only_properties %i{
  bot_id
}
