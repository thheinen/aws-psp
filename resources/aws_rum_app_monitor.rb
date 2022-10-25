# Import API specifics
use "awscc_base"

resource_name :aws_rum_app_monitor
provides :aws_rum_app_monitor, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::RUM::AppMonitor
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :app_monitor_configuration, Hash,
         callbacks: {
           "Subproperty `IdentityPoolId` is not a String" => lambda { |v| v[:IdentityPoolId].is_a? String },
           "Subproperty `IdentityPoolId` needs to be 1..55 characters" => lambda { |v| v[:IdentityPoolId].length >= 1 && v[:IdentityPoolId].length <= 55 },
           "Subproperty `IdentityPoolId` must match pattern [\w-]+:[0-9a-f-]+" => lambda { |v| v[:IdentityPoolId] =~ Regexp.new("/[\w-]+:[0-9a-f-]+/") },
           "Subproperty `SessionSampleRate` is not a Number" => lambda { |v| v[:SessionSampleRate].is_a? Number },
           "Subproperty `AllowCookies` is not a Boolean" => lambda { |v| v[:AllowCookies].is_a? Boolean },
           "Subproperty `Telemetries` is not a Array" => lambda { |v| v[:Telemetries].is_a? Array },
           "Subproperty `EnableXRay` is not a Boolean" => lambda { |v| v[:EnableXRay].is_a? Boolean },
           "Subproperty `MetricDestinations` is not a Array" => lambda { |v| v[:MetricDestinations].is_a? Array },
         },
         description: ""

property :cw_log_enabled, [TrueClass, FalseClass],
         callbacks: {
           "cw_log_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Data collected by RUM is kept by RUM for 30 days and then deleted. This parameter specifies whether RUM sends a copy of this telemetry data to CWLlong in your account. This enables you to keep the telemetry data for more than 30 days, but it does incur CWLlong charges. If you omit this parameter, the default is false
         DESCRIPTION

property :domain, String,
         required: true,
         callbacks: {
           "domain is not a String" => lambda { |v| v.is_a? String },
           "domain needs to be 1..253 characters" => lambda { |v| v.length >= 1 && v.length <= 253 },
           "domain must match pattern ^(localhost)|^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$|^(?![-.])([A-Za-z0-9-\.\-]{0,63})((?![-])([a-zA-Z0-9]{1}|^[a-zA-Z0-9]{0,1}))\.(?![-])[A-Za-z-0-9]{1,63}((?![-])([a-zA-Z0-9]{1}|^[a-zA-Z0-9]{0,1}))|^(\*\.)(?![-.])([A-Za-z0-9-\.\-]{0,63})((?![-])([a-zA-Z0-9]{1}|^[a-zA-Z0-9]{0,1}))\.(?![-])[A-Za-z-0-9]{1,63}((?![-])([a-zA-Z0-9]{1}|^[a-zA-Z0-9]{0,1}))" => lambda { |v| v =~ Regexp.new("/^(localhost)|^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$|^(?![-.])([A-Za-z0-9-\.\-]{0,63})((?![-])([a-zA-Z0-9]{1}|^[a-zA-Z0-9]{0,1}))\.(?![-])[A-Za-z-0-9]{1,63}((?![-])([a-zA-Z0-9]{1}|^[a-zA-Z0-9]{0,1}))|^(\*\.)(?![-.])([A-Za-z0-9-\.\-]{0,63})((?![-])([a-zA-Z0-9]{1}|^[a-zA-Z0-9]{0,1}))\.(?![-])[A-Za-z-0-9]{1,63}((?![-])([a-zA-Z0-9]{1}|^[a-zA-Z0-9]{0,1}))/") },
         },
         description: <<~'DESCRIPTION'
           The top-level internet domain name for which your application has administrative authority.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "name must match pattern [\.\-_/#A-Za-z0-9]+" => lambda { |v| v =~ Regexp.new("/[\.\-_/#A-Za-z0-9]+/") },
         },
         description: <<~'DESCRIPTION'
           A name for the app monitor
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RUM::AppMonitor"
rest_api_document "/AWS::RUM::AppMonitor"

rest_property_map({
  app_monitor_configuration: "AppMonitorConfiguration",
  cw_log_enabled:            "CwLogEnabled",
  domain:                    "Domain",
  name:                      "Name",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  name
}
