# Import API specifics
use "awscc_base"

resource_name :aws_refactorspaces_route
provides :aws_refactorspaces_route, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::RefactorSpaces::Route Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_identifier, String,
         required: true,
         callbacks: {
           "application_identifier is not a String" => lambda { |v| v.is_a? String },
           "application_identifier needs to be 14..14 characters" => lambda { |v| v.length >= 14 && v.length <= 14 },
           "application_identifier must match pattern ^app-([0-9A-Za-z]{10}$)" => lambda { |v| v =~ Regexp.new("/^app-([0-9A-Za-z]{10}$)/") },
         },
         description: ""

property :default_route, Hash,
         description: ""

property :environment_identifier, String,
         required: true,
         callbacks: {
           "environment_identifier is not a String" => lambda { |v| v.is_a? String },
           "environment_identifier needs to be 14..14 characters" => lambda { |v| v.length >= 14 && v.length <= 14 },
           "environment_identifier must match pattern ^env-([0-9A-Za-z]{10}$)" => lambda { |v| v =~ Regexp.new("/^env-([0-9A-Za-z]{10}$)/") },
         },
         description: ""

property :route_type, Hash,
         required: true,
         callbacks: {
           "route_type is not a String" => lambda { |v| v.is_a? String },
           "route_typeis not one of `DEFAULT`, `URI_PATH`" => lambda { |v| %w{DEFAULT URI_PATH}.include? v },
         },
         description: ""

property :service_identifier, String,
         required: true,
         callbacks: {
           "service_identifier is not a String" => lambda { |v| v.is_a? String },
           "service_identifier needs to be 14..14 characters" => lambda { |v| v.length >= 14 && v.length <= 14 },
           "service_identifier must match pattern ^svc-([0-9A-Za-z]{10}$)" => lambda { |v| v =~ Regexp.new("/^svc-([0-9A-Za-z]{10}$)/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Metadata that you can assign to help organize the frameworks that you create. Each tag is a key-value pair.
         DESCRIPTION

property :uri_path_route, Hash,
         callbacks: {
           "Subproperty `SourcePath` is not a String" => lambda { |v| v[:SourcePath].is_a? String },
           "Subproperty `SourcePath` needs to be 1..2048 characters" => lambda { |v| v[:SourcePath].length >= 1 && v[:SourcePath].length <= 2048 },
           "Subproperty `SourcePath` must match pattern ^(/[a-zA-Z0-9._-]+)+$" => lambda { |v| v[:SourcePath] =~ Regexp.new("/^(/[a-zA-Z0-9._-]+)+$/") },
           "Subproperty `Methods` is not a Array" => lambda { |v| v[:Methods].is_a? Array },
           "Subproperty `IncludeChildPaths` is not a Boolean" => lambda { |v| v[:IncludeChildPaths].is_a? Boolean },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RefactorSpaces::Route"
rest_api_document "/AWS::RefactorSpaces::Route"

rest_property_map({
  application_identifier: "ApplicationIdentifier",
  default_route:          "DefaultRoute",
  environment_identifier: "EnvironmentIdentifier",
  route_type:             "RouteType",
  service_identifier:     "ServiceIdentifier",
  tags:                   "Tags",
  uri_path_route:         "UriPathRoute",
})

rest_post_only_properties %i{
  application_identifier environment_identifier route_type service_identifier uri_path_route/include_child_paths uri_path_route/methods uri_path_route/source_path
}
