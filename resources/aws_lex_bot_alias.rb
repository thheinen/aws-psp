# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_lex_bot_alias
provides :aws_lex_bot_alias, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A Bot Alias enables you to change the version of a bot without updating applications that use the bot
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bot_alias_locale_settings, Hash,
         callbacks: {
           "bot_alias_locale_settings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :bot_alias_name, Hash,
         required: true,
         callbacks: {
           "bot_alias_name is not a String" => lambda { |v| v.is_a? String },
           "bot_alias_name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "bot_alias_name must match pattern ^([0-9a-zA-Z][_-]?)+$" => lambda { |v| v =~ Regexp.new("/^([0-9a-zA-Z][_-]?)+$/") },
         },
         description: ""

property :bot_alias_tags, Array,
         callbacks: {
           "bot_alias_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags to add to the bot alias.
         DESCRIPTION

property :bot_id, Hash,
         required: true,
         callbacks: {
           "bot_id is not a String" => lambda { |v| v.is_a? String },
           "bot_id needs to be 10..10 characters" => lambda { |v| v.length >= 10 && v.length <= 10 },
           "bot_id must match pattern ^[0-9a-zA-Z]+$" => lambda { |v| v =~ Regexp.new("/^[0-9a-zA-Z]+$/") },
         },
         description: ""

property :bot_version, Hash,
         callbacks: {
           "bot_version is not a String" => lambda { |v| v.is_a? String },
           "bot_version needs to be 1..5 characters" => lambda { |v| v.length >= 1 && v.length <= 5 },
           "bot_version must match pattern ^(DRAFT|[0-9]+)$" => lambda { |v| v =~ Regexp.new("/^(DRAFT|[0-9]+)$/") },
         },
         description: ""

property :conversation_log_settings, Hash,
         description: ""

property :description, Hash,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :sentiment_analysis_settings, Hash,
         callbacks: {
           "Subproperty `DetectSentiment` is not a Boolean" => lambda { |v| v[:DetectSentiment].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Determines whether Amazon Lex will use Amazon Comprehend to detect the sentiment of user utterances.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lex::BotAlias"
rest_api_document "/AWS::Lex::BotAlias"

rest_property_map({
  bot_alias_locale_settings:   "BotAliasLocaleSettings",
  bot_alias_name:              "BotAliasName",
  bot_alias_tags:              "BotAliasTags",
  bot_id:                      "BotId",
  bot_version:                 "BotVersion",
  conversation_log_settings:   "ConversationLogSettings",
  description:                 "Description",
  sentiment_analysis_settings: "SentimentAnalysisSettings",
})

rest_post_only_properties %i{
  bot_id
}
