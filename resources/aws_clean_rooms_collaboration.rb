# Import API specifics
use "awscc_base"

resource_name :aws_clean_rooms_collaboration
provides :aws_clean_rooms_collaboration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents a collaboration between AWS accounts that allows for secure data collaboration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :creator_display_name, Hash,
         required: true,
         callbacks: {
           "creator_display_name is not a String" => lambda { |v| v.is_a? String },
           "creator_display_name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "creator_display_name must match pattern ^(?!\s*$)[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t]*$" => lambda { |v| v =~ Regexp.new("/^(?!\s*$)[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t]*$/") },
         },
         description: ""

property :creator_member_abilities, Hash,
         required: true,
         callbacks: {
           "creator_member_abilities is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :data_encryption_metadata, Hash,
         callbacks: {
           "Subproperty `AllowCleartext` is not a Boolean" => lambda { |v| v[:AllowCleartext].is_a? Boolean },
           "Subproperty `AllowDuplicates` is not a Boolean" => lambda { |v| v[:AllowDuplicates].is_a? Boolean },
           "Subproperty `AllowJoinsOnColumnsWithDifferentNames` is not a Boolean" => lambda { |v| v[:AllowJoinsOnColumnsWithDifferentNames].is_a? Boolean },
           "Subproperty `PreserveNulls` is not a Boolean" => lambda { |v| v[:PreserveNulls].is_a? Boolean },
         },
         description: ""

property :description, String,
         required: true,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "description must match pattern ^(?!\s*$)[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t\r\n]*$" => lambda { |v| v =~ Regexp.new("/^(?!\s*$)[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t\r\n]*$/") },
         },
         description: ""

property :members, Array,
         required: true,
         callbacks: {
           "members is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "name must match pattern ^(?!\s*$)[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t]*$" => lambda { |v| v =~ Regexp.new("/^(?!\s*$)[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t]*$/") },
         },
         description: ""

property :query_log_status, Hash,
         required: true,
         callbacks: {
           "query_log_status is not a String" => lambda { |v| v.is_a? String },
           "query_log_statusis not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An arbitrary set of tags (key-value pairs) for this cleanrooms collaboration.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CleanRooms::Collaboration"
rest_api_document "/AWS::CleanRooms::Collaboration"

rest_property_map({
  creator_display_name:     "CreatorDisplayName",
  creator_member_abilities: "CreatorMemberAbilities",
  data_encryption_metadata: "DataEncryptionMetadata",
  description:              "Description",
  members:                  "Members",
  name:                     "Name",
  query_log_status:         "QueryLogStatus",
  tags:                     "Tags",
})

rest_post_only_properties %i{
  creator_display_name creator_member_abilities data_encryption_metadata members query_log_status
}
