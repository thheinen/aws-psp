# Import API specifics
use "awscc_base"

resource_name :aws_quicksight_topic
provides :aws_quicksight_topic, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of the AWS::QuickSight::Topic Resource Type.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :aws_account_id, String,
         callbacks: {
           "aws_account_id is not a String" => lambda { |v| v.is_a? String },
           "aws_account_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
           "aws_account_id must match pattern ^[0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9]{12}$/") },
         },
         description: ""

property :data_sets, Array,
         callbacks: {
           "data_sets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: ""

property :topic_id, String,
         callbacks: {
           "topic_id is not a String" => lambda { |v| v.is_a? String },
           "topic_id needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
           "topic_id must match pattern ^[A-Za-z0-9-_.\\+]*$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9-_.\\+]*$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::QuickSight::Topic"
rest_api_document "/AWS::QuickSight::Topic"

rest_property_map({
  aws_account_id: "AwsAccountId",
  data_sets:      "DataSets",
  description:    "Description",
  name:           "Name",
  topic_id:       "TopicId",
})

rest_post_only_properties %i{
  aws_account_id topic_id
}
