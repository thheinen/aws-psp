# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_work_spaces_connection_alias
provides :aws_work_spaces_connection_alias, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::WorkSpaces::ConnectionAlias
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :connection_string, String,
         required: true,
         callbacks: {
           "connection_string is not a String" => lambda { |v| v.is_a? String },
           "connection_string needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "connection_string must match pattern ^[.0-9a-zA-Z\-]{1,255}$" => lambda { |v| v =~ Regexp.new("/^[.0-9a-zA-Z\-]{1,255}$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WorkSpaces::ConnectionAlias"
rest_api_document "/AWS::WorkSpaces::ConnectionAlias"

rest_property_map({
  connection_string: "ConnectionString",
  tags:              "Tags",
})

rest_post_only_properties %i{
  connection_string tags
}
