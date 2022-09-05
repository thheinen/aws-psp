# Import API specifics
use "awscc_base"

resource_name :aws_access_analyzer_analyzer
provides :aws_access_analyzer_analyzer, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::AccessAnalyzer::Analyzer type specifies an analyzer of the user's account
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :analyzer_name, String,
         callbacks: {
           "analyzer_name is not a String" => lambda { |v| v.is_a? String },
           "analyzer_name needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           Analyzer name
         DESCRIPTION

property :archive_rules, Array,
         callbacks: {
           "archive_rules is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "type needs to be 0..1024 characters" => lambda { |v| v.length >= 0 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           The type of the analyzer, must be ACCOUNT or ORGANIZATION
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AccessAnalyzer::Analyzer"
rest_api_document "/AWS::AccessAnalyzer::Analyzer"

rest_property_map({
  analyzer_name: "AnalyzerName",
  archive_rules: "ArchiveRules",
  tags:          "Tags",
  type:          "Type",
})

rest_post_only_properties %i{
  analyzer_name type
}
