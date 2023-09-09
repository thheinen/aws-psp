# Import API specifics
use "awscc_base"

resource_name :aws_clean_rooms_membership
provides :aws_clean_rooms_membership, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents an AWS account that is a part of a collaboration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :collaboration_identifier, String,
         required: true,
         callbacks: {
           "collaboration_identifier is not a String" => lambda { |v| v.is_a? String },
           "collaboration_identifier needs to be 36..36 characters" => lambda { |v| v.length >= 36 && v.length <= 36 },
           "collaboration_identifier must match pattern [0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}" => lambda { |v| v =~ Regexp.new("/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/") },
         },
         description: ""

property :default_result_configuration, Hash,
         callbacks: {
           "Subproperty `RoleArn` is not a String" => lambda { |v| v[:RoleArn].is_a? String },
           "Subproperty `RoleArn` needs to be 32..512 characters" => lambda { |v| v[:RoleArn].length >= 32 && v[:RoleArn].length <= 512 },
           "Subproperty `RoleArn`is not a valid ARN" => lambda { |v| v[:RoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
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
           An arbitrary set of tags (key-value pairs) for this cleanrooms membership.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CleanRooms::Membership"
rest_api_document "/AWS::CleanRooms::Membership"

rest_property_map({
  collaboration_identifier:     "CollaborationIdentifier",
  default_result_configuration: "DefaultResultConfiguration",
  query_log_status:             "QueryLogStatus",
  tags:                         "Tags",
})

rest_post_only_properties %i{
  collaboration_identifier
}
