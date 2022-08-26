# Import API specifics
use "awscc_base"

resource_name :aws_events_connection
provides :aws_events_connection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Events::Connection.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auth_parameters, Hash,
         required: true,
         description: ""

property :authorization_type, String,
         required: true,
         callbacks: {
           "authorization_type is not a String" => lambda { |v| v.is_a? String },
           "authorization_typeis not one of `API_KEY`, `BASIC`, `OAUTH_CLIENT_CREDENTIALS`" => lambda { |v| %w{API_KEY BASIC OAUTH_CLIENT_CREDENTIALS}.include? v },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Description of the connection."

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: "Name of the connection."

# API URLs and mappings
rest_api_collection "/AWS::Events::Connection"
rest_api_document "/AWS::Events::Connection"

rest_property_map({
  auth_parameters:    "AuthParameters",
  authorization_type: "AuthorizationType",
  description:        "Description",
  name:               "Name",
})

rest_post_only_properties %i{
  name
}
