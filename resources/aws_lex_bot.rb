# Import API specifics
use "awscc_base"

resource_name :aws_lex_bot
provides :aws_lex_bot, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Amazon Lex conversational bot performing automated tasks such as ordering a pizza, booking a hotel, and so on.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auto_build_bot_locales, [TrueClass, FalseClass],
         callbacks: {
           "auto_build_bot_locales is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether to build the bot locales after bot creation completes.
         DESCRIPTION

property :bot_file_s3_location, Hash,
         callbacks: {
           "Subproperty `S3ObjectVersion` is not a String" => lambda { |v| v[:S3ObjectVersion].is_a? String },
           "Subproperty `S3ObjectVersion` needs to be 1..1024 characters" => lambda { |v| v[:S3ObjectVersion].length >= 1 && v[:S3ObjectVersion].length <= 1024 },
         },
         description: ""

property :bot_locales, Array,
         callbacks: {
           "bot_locales is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of bot locales
         DESCRIPTION

property :bot_tags, Array,
         callbacks: {
           "bot_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags to add to the bot, which can only be added at bot creation.
         DESCRIPTION

property :data_privacy, Hash,
         required: true,
         callbacks: {
           "Subproperty `ChildDirected` is not a Boolean" => lambda { |v| v[:ChildDirected].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Data privacy setting of the Bot.
         DESCRIPTION

property :description, Hash,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :idle_session_ttl_in_seconds, Integer,
         required: true,
         callbacks: {
           "idle_session_ttl_in_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           IdleSessionTTLInSeconds of the resource
         DESCRIPTION

property :name, Hash,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "name must match pattern ^([0-9a-zA-Z][_-]?)+$" => lambda { |v| v =~ Regexp.new("/^([0-9a-zA-Z][_-]?)+$/") },
         },
         description: ""

property :role_arn, Hash,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 32..2048 characters" => lambda { |v| v.length >= 32 && v.length <= 2048 },
           "role_arn must match pattern ^arn:aws[a-zA-Z-]*:iam::[0-9]{12}:role/.*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[a-zA-Z-]*:iam::[0-9]{12}:role/.*$/") },
         },
         description: ""

property :test_bot_alias_settings, Hash,
         callbacks: {
           "Subproperty `SentimentAnalysisSettings` is not a Object" => lambda { |v| v[:SentimentAnalysisSettings].is_a? Object },
         },
         description: ""

property :test_bot_alias_tags, Array,
         callbacks: {
           "test_bot_alias_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags to add to the test alias for a bot, , which can only be added at bot/bot alias creation.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lex::Bot"
rest_api_document "/AWS::Lex::Bot"

rest_property_map({
  auto_build_bot_locales:      "AutoBuildBotLocales",
  bot_file_s3_location:        "BotFileS3Location",
  bot_locales:                 "BotLocales",
  bot_tags:                    "BotTags",
  data_privacy:                "DataPrivacy",
  description:                 "Description",
  idle_session_ttl_in_seconds: "IdleSessionTTLInSeconds",
  name:                        "Name",
  role_arn:                    "RoleArn",
  test_bot_alias_settings:     "TestBotAliasSettings",
  test_bot_alias_tags:         "TestBotAliasTags",
})

