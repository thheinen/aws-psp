# Import API specifics
use "awscc_base"

resource_name :aws_clean_rooms_configured_table_association
provides :aws_clean_rooms_configured_table_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents a table that can be queried within a collaboration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :configured_table_identifier, String,
         required: true,
         callbacks: {
           "configured_table_identifier is not a String" => lambda { |v| v.is_a? String },
           "configured_table_identifier needs to be 36..36 characters" => lambda { |v| v.length >= 36 && v.length <= 36 },
           "configured_table_identifier must match pattern [0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}" => lambda { |v| v =~ Regexp.new("/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/") },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern ^[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t\r\n]*$" => lambda { |v| v =~ Regexp.new("/^[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t\r\n]*$/") },
         },
         description: ""

property :membership_identifier, String,
         required: true,
         callbacks: {
           "membership_identifier is not a String" => lambda { |v| v.is_a? String },
           "membership_identifier needs to be 36..36 characters" => lambda { |v| v.length >= 36 && v.length <= 36 },
           "membership_identifier must match pattern [0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}" => lambda { |v| v =~ Regexp.new("/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/") },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[a-zA-Z0-9_](([a-zA-Z0-9_ ]+-)*([a-zA-Z0-9_ ]+))?$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_](([a-zA-Z0-9_ ]+-)*([a-zA-Z0-9_ ]+))?$/") },
         },
         description: ""

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 32..512 characters" => lambda { |v| v.length >= 32 && v.length <= 512 },
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
rest_api_collection "/AWS::CleanRooms::ConfiguredTableAssociation"
rest_api_document "/AWS::CleanRooms::ConfiguredTableAssociation"

rest_property_map({
  configured_table_identifier: "ConfiguredTableIdentifier",
  description:                 "Description",
  membership_identifier:       "MembershipIdentifier",
  name:                        "Name",
  role_arn:                    "RoleArn",
  tags:                        "Tags",
})

rest_post_only_properties %i{
  configured_table_identifier membership_identifier name
}
