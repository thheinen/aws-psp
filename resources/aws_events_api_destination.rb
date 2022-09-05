# Import API specifics
use "awscc_base"

resource_name :aws_events_api_destination
provides :aws_events_api_destination, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Events::ApiDestination.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :connection_arn, String,
         required: true,
         callbacks: {
           "connection_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The arn of the connection.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :http_method, String,
         required: true,
         callbacks: {
           "http_method is not a String" => lambda { |v| v.is_a? String },
           "http_methodis not one of `GET`, `HEAD`, `POST`, `OPTIONS`, `PUT`, `DELETE`, `PATCH`" => lambda { |v| %w{GET HEAD POST OPTIONS PUT DELETE PATCH}.include? v },
         },
         description: ""

property :invocation_endpoint, String,
         required: true,
         callbacks: {
           "invocation_endpoint is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Url endpoint to invoke.
         DESCRIPTION

property :invocation_rate_limit_per_second, Integer,
         callbacks: {
           "invocation_rate_limit_per_second is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: <<~'DESCRIPTION'
           Name of the apiDestination.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Events::ApiDestination"
rest_api_document "/AWS::Events::ApiDestination"

rest_property_map({
  connection_arn:                   "ConnectionArn",
  description:                      "Description",
  http_method:                      "HttpMethod",
  invocation_endpoint:              "InvocationEndpoint",
  invocation_rate_limit_per_second: "InvocationRateLimitPerSecond",
  name:                             "Name",
})

rest_post_only_properties %i{
  name
}
