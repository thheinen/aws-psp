# Import API specifics
use "awscc_base"

resource_name :aws_route53_health_check
provides :aws_route53_health_check, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Route53::HealthCheck.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :health_check_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `ChildHealthChecks` is not a Array" => lambda { |v| v[:ChildHealthChecks].is_a? Array },
           "Subproperty `EnableSNI` is not a Boolean" => lambda { |v| v[:EnableSNI].is_a? Boolean },
           "Subproperty `FailureThreshold` is not a Integer" => lambda { |v| v[:FailureThreshold].is_a? Integer },
           "Subproperty `FullyQualifiedDomainName` is not a String" => lambda { |v| v[:FullyQualifiedDomainName].is_a? String },
           "Subproperty `HealthThreshold` is not a Integer" => lambda { |v| v[:HealthThreshold].is_a? Integer },
           "Subproperty `InsufficientDataHealthStatus` is not a String" => lambda { |v| v[:InsufficientDataHealthStatus].is_a? String },
           "Subproperty `InsufficientDataHealthStatus`is not one of `Healthy`, `LastKnownStatus`, `Unhealthy`" => lambda { |v| %w{Healthy LastKnownStatus Unhealthy}.include? v[:InsufficientDataHealthStatus] },
           "Subproperty `Inverted` is not a Boolean" => lambda { |v| v[:Inverted].is_a? Boolean },
           "Subproperty `IPAddress` is not a String" => lambda { |v| v[:IPAddress].is_a? String },
           "Subproperty `IPAddress` must match pattern ^((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))$|^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$" => lambda { |v| v[:IPAddress] =~ Regexp.new("/^((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))$|^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/") },
           "Subproperty `MeasureLatency` is not a Boolean" => lambda { |v| v[:MeasureLatency].is_a? Boolean },
           "Subproperty `Port` is not a Integer" => lambda { |v| v[:Port].is_a? Integer },
           "Subproperty `Regions` is not a Array" => lambda { |v| v[:Regions].is_a? Array },
           "Subproperty `RequestInterval` is not a Integer" => lambda { |v| v[:RequestInterval].is_a? Integer },
           "Subproperty `ResourcePath` is not a String" => lambda { |v| v[:ResourcePath].is_a? String },
           "Subproperty `SearchString` is not a String" => lambda { |v| v[:SearchString].is_a? String },
           "Subproperty `RoutingControlArn` is not a String" => lambda { |v| v[:RoutingControlArn].is_a? String },
           "Subproperty `RoutingControlArn` needs to be 1..255 characters" => lambda { |v| v[:RoutingControlArn].length >= 1 && v[:RoutingControlArn].length <= 255 },
           "Subproperty `RoutingControlArn`is not a valid ARN" => lambda { |v| v[:RoutingControlArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `CALCULATED`, `CLOUDWATCH_METRIC`, `HTTP`, `HTTP_STR_MATCH`, `HTTPS`, `HTTPS_STR_MATCH`, `TCP`, `RECOVERY_CONTROL`" => lambda { |v| %w{CALCULATED CLOUDWATCH_METRIC HTTP HTTP_STR_MATCH HTTPS HTTPS_STR_MATCH TCP RECOVERY_CONTROL}.include? v[:Type] },
         },
         description: <<~'DESCRIPTION'
           A complex type that contains information about the health check.
         DESCRIPTION

property :health_check_tags, Array,
         callbacks: {
           "health_check_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Route53::HealthCheck"
rest_api_document "/AWS::Route53::HealthCheck"

rest_property_map({
  health_check_config: "HealthCheckConfig",
  health_check_tags:   "HealthCheckTags",
})

rest_post_only_properties %i{
  health_check_config/measure_latency health_check_config/request_interval health_check_config/type
}
