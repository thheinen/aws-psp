# Import API specifics
use "awscc_base"

resource_name :aws_clean_rooms_analysis_template
provides :aws_clean_rooms_analysis_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents a stored analysis within a collaboration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :analysis_parameters, Array,
         callbacks: {
           "analysis_parameters is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The member who can query can provide this placeholder for a literal data value in an analysis template
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern ^[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t\r\n]*$" => lambda { |v| v =~ Regexp.new("/^[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t\r\n]*$/") },
         },
         description: ""

property :format, String,
         required: true,
         callbacks: {
           "format is not a String" => lambda { |v| v.is_a? String },
           "formatis not one of `SQL`" => lambda { |v| %w{SQL}.include? v },
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

property :source, Hash,
         required: true,
         callbacks: {
           "Subproperty `Text` is not a String" => lambda { |v| v[:Text].is_a? String },
           "Subproperty `Text` needs to be 0..15000 characters" => lambda { |v| v[:Text].length >= 0 && v[:Text].length <= 15000 },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An arbitrary set of tags (key-value pairs) for this cleanrooms analysis template.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CleanRooms::AnalysisTemplate"
rest_api_document "/AWS::CleanRooms::AnalysisTemplate"

rest_property_map({
  analysis_parameters:   "AnalysisParameters",
  description:           "Description",
  format:                "Format",
  membership_identifier: "MembershipIdentifier",
  name:                  "Name",
  source:                "Source",
  tags:                  "Tags",
})

rest_post_only_properties %i{
  analysis_parameters analysis_parameters/default_value analysis_parameters/name analysis_parameters/type format membership_identifier name source source/text
}
