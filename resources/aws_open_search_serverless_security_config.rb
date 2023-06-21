# Import API specifics
use "awscc_base"

resource_name :aws_open_search_serverless_security_config
provides :aws_open_search_serverless_security_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Amazon OpenSearchServerless security config resource
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000 },
         },
         description: <<~'DESCRIPTION'
           Security config description
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..32 characters" => lambda { |v| v.length >= 3 && v.length <= 32 },
           "name must match pattern ^[a-z][a-z0-9-]{2,31}$" => lambda { |v| v =~ Regexp.new("/^[a-z][a-z0-9-]{2,31}$/") },
         },
         description: <<~'DESCRIPTION'
           The friendly name of the security config
         DESCRIPTION

property :saml_options, Hash,
         callbacks: {
           "Subproperty `Metadata` is not a String" => lambda { |v| v[:Metadata].is_a? String },
           "Subproperty `Metadata` needs to be 1..51200 characters" => lambda { |v| v[:Metadata].length >= 1 && v[:Metadata].length <= 51200 },
           "Subproperty `Metadata` must match pattern [\u0009\u000A\u000D\u0020-\u007E\u00A1-\u00FF]+" => lambda { |v| v[:Metadata] =~ Regexp.new("/[\u0009\u000A\u000D\u0020-\u007E\u00A1-\u00FF]+/") },
           "Subproperty `UserAttribute` is not a String" => lambda { |v| v[:UserAttribute].is_a? String },
           "Subproperty `UserAttribute` needs to be 1..2048 characters" => lambda { |v| v[:UserAttribute].length >= 1 && v[:UserAttribute].length <= 2048 },
           "Subproperty `UserAttribute` must match pattern [\w+=,.@-]+" => lambda { |v| v[:UserAttribute] =~ Regexp.new("/[\w+=,.@-]+/") },
           "Subproperty `GroupAttribute` is not a String" => lambda { |v| v[:GroupAttribute].is_a? String },
           "Subproperty `GroupAttribute` needs to be 1..2048 characters" => lambda { |v| v[:GroupAttribute].length >= 1 && v[:GroupAttribute].length <= 2048 },
           "Subproperty `GroupAttribute` must match pattern [\w+=,.@-]+" => lambda { |v| v[:GroupAttribute] =~ Regexp.new("/[\w+=,.@-]+/") },
           "Subproperty `SessionTimeout` is not a Integer" => lambda { |v| v[:SessionTimeout].is_a? Integer },
         },
         description: ""

property :type, Hash,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `saml`" => lambda { |v| %w{saml}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::OpenSearchServerless::SecurityConfig"
rest_api_document "/AWS::OpenSearchServerless::SecurityConfig"

rest_property_map({
  description:  "Description",
  name:         "Name",
  saml_options: "SamlOptions",
  type:         "Type",
})

rest_post_only_properties %i{
  name type
}
