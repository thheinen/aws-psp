# Import API specifics
use "awscc_base"

resource_name :aws_elasticloadbalancingv2_target_group
provides :aws_elasticloadbalancingv2_target_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ElasticLoadBalancingV2::TargetGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :health_check_enabled, [TrueClass, FalseClass],
         callbacks: {
           "health_check_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether health checks are enabled. If the target type is lambda, health checks are disabled by default but can be enabled. If the target type is instance, ip, or alb, health checks are always enabled and cannot be disabled.
         DESCRIPTION

property :health_check_interval_seconds, Integer,
         callbacks: {
           "health_check_interval_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The approximate amount of time, in seconds, between health checks of an individual target.
         DESCRIPTION

property :health_check_path, String,
         callbacks: {
           "health_check_path is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           [HTTP/HTTPS health checks] The destination for health checks on the targets. [HTTP1 or HTTP2 protocol version] The ping path. The default is /. [GRPC protocol version] The path of a custom health check method with the format /package.service/method. The default is /AWS.ALB/healthcheck.
         DESCRIPTION

property :health_check_port, String,
         callbacks: {
           "health_check_port is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The port the load balancer uses when performing health checks on targets.
         DESCRIPTION

property :health_check_protocol, String,
         callbacks: {
           "health_check_protocol is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The protocol the load balancer uses when performing health checks on targets.
         DESCRIPTION

property :health_check_timeout_seconds, Integer,
         callbacks: {
           "health_check_timeout_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The amount of time, in seconds, during which no response from a target means a failed health check.
         DESCRIPTION

property :healthy_threshold_count, Integer,
         callbacks: {
           "healthy_threshold_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of consecutive health checks successes required before considering an unhealthy target healthy.
         DESCRIPTION

property :ip_address_type, String,
         callbacks: {
           "ip_address_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of IP address used for this target group. The possible values are ipv4 and ipv6.
         DESCRIPTION

property :matcher, Hash,
         callbacks: {
           "Subproperty `GrpcCode` is not a String" => lambda { |v| v[:GrpcCode].is_a? String },
           "Subproperty `HttpCode` is not a String" => lambda { |v| v[:HttpCode].is_a? String },
         },
         description: <<~'DESCRIPTION'
           [HTTP/HTTPS health checks] The HTTP or gRPC codes to use when checking for a successful response from a target.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the target group.
         DESCRIPTION

property :port, Integer,
         callbacks: {
           "port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The port on which the targets receive traffic. This port is used unless you specify a port override when registering the target. If the target is a Lambda function, this parameter does not apply. If the protocol is GENEVE, the supported port is 6081.
         DESCRIPTION

property :protocol, String,
         callbacks: {
           "protocol is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The protocol to use for routing traffic to the targets.
         DESCRIPTION

property :protocol_version, String,
         callbacks: {
           "protocol_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           [HTTP/HTTPS protocol] The protocol version. The possible values are GRPC, HTTP1, and HTTP2.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags.
         DESCRIPTION

property :target_group_attributes, Array,
         callbacks: {
           "target_group_attributes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The attributes.
         DESCRIPTION

property :target_type, String,
         callbacks: {
           "target_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of target that you must specify when registering targets with this target group. You can't specify targets for a target group using more than one target type.
         DESCRIPTION

property :targets, Array,
         callbacks: {
           "targets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The targets.
         DESCRIPTION

property :unhealthy_threshold_count, Integer,
         callbacks: {
           "unhealthy_threshold_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of consecutive health check failures required before considering a target unhealthy.
         DESCRIPTION

property :vpc_id, String,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier of the virtual private cloud (VPC). If the target is a Lambda function, this parameter does not apply.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ElasticLoadBalancingV2::TargetGroup"
rest_api_document "/AWS::ElasticLoadBalancingV2::TargetGroup"

rest_property_map({
  health_check_enabled:          "HealthCheckEnabled",
  health_check_interval_seconds: "HealthCheckIntervalSeconds",
  health_check_path:             "HealthCheckPath",
  health_check_port:             "HealthCheckPort",
  health_check_protocol:         "HealthCheckProtocol",
  health_check_timeout_seconds:  "HealthCheckTimeoutSeconds",
  healthy_threshold_count:       "HealthyThresholdCount",
  ip_address_type:               "IpAddressType",
  matcher:                       "Matcher",
  name:                          "Name",
  port:                          "Port",
  protocol:                      "Protocol",
  protocol_version:              "ProtocolVersion",
  tags:                          "Tags",
  target_group_attributes:       "TargetGroupAttributes",
  target_type:                   "TargetType",
  targets:                       "Targets",
  unhealthy_threshold_count:     "UnhealthyThresholdCount",
  vpc_id:                        "VpcId",
})

rest_post_only_properties %i{
  ip_address_type name port protocol protocol_version target_type vpc_id
}
