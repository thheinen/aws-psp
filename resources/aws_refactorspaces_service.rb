# Import API specifics
use "awscc_base"

resource_name :aws_refactorspaces_service
provides :aws_refactorspaces_service, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::RefactorSpaces::Service Resource Type
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

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "description must match pattern ^[a-zA-Z0-9-_\s\.\!\*\#\@\']+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-_\s\.\!\*\#\@\']+$/") },
         },
         description: ""

property :endpoint_type, Hash,
         required: true,
         callbacks: {
           "endpoint_type is not a String" => lambda { |v| v.is_a? String },
           "endpoint_typeis not one of `LAMBDA`, `URL`" => lambda { |v| %w{LAMBDA URL}.include? v },
         },
         description: ""

property :environment_identifier, String,
         required: true,
         callbacks: {
           "environment_identifier is not a String" => lambda { |v| v.is_a? String },
           "environment_identifier needs to be 14..14 characters" => lambda { |v| v.length >= 14 && v.length <= 14 },
           "environment_identifier must match pattern ^env-([0-9A-Za-z]{10}$)" => lambda { |v| v =~ Regexp.new("/^env-([0-9A-Za-z]{10}$)/") },
         },
         description: ""

property :lambda_endpoint, Hash,
         callbacks: {
           "Subproperty `Arn` is not a String" => lambda { |v| v[:Arn].is_a? String },
           "Subproperty `Arn` needs to be 1..2048 characters" => lambda { |v| v[:Arn].length >= 1 && v[:Arn].length <= 2048 },
           "Subproperty `Arn` must match pattern ^arn:(aws[a-zA-Z-]*)?:lambda:[a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1}:\d{12}:function:[a-zA-Z0-9-_]+(:(\$LATEST|[a-zA-Z0-9-_]+))?$" => lambda { |v| v[:Arn] =~ Regexp.new("/^arn:(aws[a-zA-Z-]*)?:lambda:[a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1}:\d{12}:function:[a-zA-Z0-9-_]+(:(\$LATEST|[a-zA-Z0-9-_]+))?$/") },
           "Subproperty `Arn`is not a valid ARN" => lambda { |v| v[:Arn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..63 characters" => lambda { |v| v.length >= 3 && v.length <= 63 },
           "name must match pattern ^(?!svc-)[a-zA-Z0-9]+[a-zA-Z0-9-_ ]+$" => lambda { |v| v =~ Regexp.new("/^(?!svc-)[a-zA-Z0-9]+[a-zA-Z0-9-_ ]+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Metadata that you can assign to help organize the frameworks that you create. Each tag is a key-value pair.
         DESCRIPTION

property :url_endpoint, Hash,
         callbacks: {
           "Subproperty `HealthUrl` is not a String" => lambda { |v| v[:HealthUrl].is_a? String },
           "Subproperty `HealthUrl` needs to be 1..2048 characters" => lambda { |v| v[:HealthUrl].length >= 1 && v[:HealthUrl].length <= 2048 },
           "Subproperty `HealthUrl` must match pattern ^https?://[-a-zA-Z0-9+\x38@#/%?=~_|!:,.;]*[-a-zA-Z0-9+\x38@#/%=~_|]$" => lambda { |v| v[:HealthUrl] =~ Regexp.new("/^https?://[-a-zA-Z0-9+\x38@#/%?=~_|!:,.;]*[-a-zA-Z0-9+\x38@#/%=~_|]$/") },
           "Subproperty `Url` is not a String" => lambda { |v| v[:Url].is_a? String },
           "Subproperty `Url` needs to be 1..2048 characters" => lambda { |v| v[:Url].length >= 1 && v[:Url].length <= 2048 },
           "Subproperty `Url` must match pattern ^https?://[-a-zA-Z0-9+\x38@#/%?=~_|!:,.;]*[-a-zA-Z0-9+\x38@#/%=~_|]$" => lambda { |v| v[:Url] =~ Regexp.new("/^https?://[-a-zA-Z0-9+\x38@#/%?=~_|!:,.;]*[-a-zA-Z0-9+\x38@#/%=~_|]$/") },
         },
         description: ""

property :vpc_id, String,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
           "vpc_id needs to be 12..21 characters" => lambda { |v| v.length >= 12 && v.length <= 21 },
           "vpc_id must match pattern ^vpc-[-a-f0-9]{8}([-a-f0-9]{9})?$" => lambda { |v| v =~ Regexp.new("/^vpc-[-a-f0-9]{8}([-a-f0-9]{9})?$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RefactorSpaces::Service"
rest_api_document "/AWS::RefactorSpaces::Service"

rest_property_map({
  application_identifier: "ApplicationIdentifier",
  description:            "Description",
  endpoint_type:          "EndpointType",
  environment_identifier: "EnvironmentIdentifier",
  lambda_endpoint:        "LambdaEndpoint",
  name:                   "Name",
  tags:                   "Tags",
  url_endpoint:           "UrlEndpoint",
  vpc_id:                 "VpcId",
})

rest_post_only_properties %i{
  application_identifier description endpoint_type environment_identifier lambda_endpoint name url_endpoint vpc_id
}
