# Import API specifics
use "awscc_base"

resource_name :aws_transfer_agreement
provides :aws_transfer_agreement, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Transfer::Agreement
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_role, String,
         required: true,
         callbacks: {
           "access_role is not a String" => lambda { |v| v.is_a? String },
           "access_role needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "access_role must match pattern arn:.*role/.*" => lambda { |v| v =~ Regexp.new("/arn:.*role/.*/") },
         },
         description: <<~'DESCRIPTION'
           Specifies the access role for the agreement.
         DESCRIPTION

property :base_directory, String,
         required: true,
         callbacks: {
           "base_directory is not a String" => lambda { |v| v.is_a? String },
           "base_directory must match pattern ^$|/.*" => lambda { |v| v =~ Regexp.new("/^$|/.*/") },
         },
         description: <<~'DESCRIPTION'
           Specifies the base directory for the agreement.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..200 characters" => lambda { |v| v.length >= 1 && v.length <= 200 },
           "description must match pattern ^[\w\- ]*$" => lambda { |v| v =~ Regexp.new("/^[\w\- ]*$/") },
         },
         description: <<~'DESCRIPTION'
           A textual description for the agreement.
         DESCRIPTION

property :local_profile_id, String,
         required: true,
         callbacks: {
           "local_profile_id is not a String" => lambda { |v| v.is_a? String },
           "local_profile_id needs to be 19..19 characters" => lambda { |v| v.length >= 19 && v.length <= 19 },
           "local_profile_id must match pattern ^p-([0-9a-f]{17})$" => lambda { |v| v =~ Regexp.new("/^p-([0-9a-f]{17})$/") },
         },
         description: <<~'DESCRIPTION'
           A unique identifier for the local profile.
         DESCRIPTION

property :partner_profile_id, String,
         required: true,
         callbacks: {
           "partner_profile_id is not a String" => lambda { |v| v.is_a? String },
           "partner_profile_id needs to be 19..19 characters" => lambda { |v| v.length >= 19 && v.length <= 19 },
           "partner_profile_id must match pattern ^p-([0-9a-f]{17})$" => lambda { |v| v =~ Regexp.new("/^p-([0-9a-f]{17})$/") },
         },
         description: <<~'DESCRIPTION'
           A unique identifier for the partner profile.
         DESCRIPTION

property :server_id, String,
         required: true,
         callbacks: {
           "server_id is not a String" => lambda { |v| v.is_a? String },
           "server_id needs to be 19..19 characters" => lambda { |v| v.length >= 19 && v.length <= 19 },
           "server_id must match pattern ^s-([0-9a-f]{17})$" => lambda { |v| v =~ Regexp.new("/^s-([0-9a-f]{17})$/") },
         },
         description: <<~'DESCRIPTION'
           A unique identifier for the server.
         DESCRIPTION

property :status, String,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ACTIVE`, `INACTIVE`" => lambda { |v| %w{ACTIVE INACTIVE}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies the status of the agreement.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Key-value pairs that can be used to group and search for agreements. Tags are metadata attached to agreements for any purpose.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Transfer::Agreement"
rest_api_document "/AWS::Transfer::Agreement"

rest_property_map({
  access_role:        "AccessRole",
  base_directory:     "BaseDirectory",
  description:        "Description",
  local_profile_id:   "LocalProfileId",
  partner_profile_id: "PartnerProfileId",
  server_id:          "ServerId",
  status:             "Status",
  tags:               "Tags",
})

rest_post_only_properties %i{
  server_id
}
