# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_lightsail_load_balancer
provides :aws_lightsail_load_balancer, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lightsail::LoadBalancer
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :attached_instances, Array,
         callbacks: {
           "attached_instances is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The names of the instances attached to the load balancer.
         DESCRIPTION

property :health_check_path, String,
         callbacks: {
           "health_check_path is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The path you provided to perform the load balancer health check. If you didn't specify a health check path, Lightsail uses the root path of your website (e.g., "/").
         DESCRIPTION

property :instance_port, Integer,
         required: true,
         callbacks: {
           "instance_port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The instance port where you're creating your load balancer.
         DESCRIPTION

property :ip_address_type, String,
         callbacks: {
           "ip_address_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The IP address type for the load balancer. The possible values are ipv4 for IPv4 only, and dualstack for IPv4 and IPv6. The default value is dualstack.
         DESCRIPTION

property :load_balancer_name, String,
         required: true,
         callbacks: {
           "load_balancer_name is not a String" => lambda { |v| v.is_a? String },
           "load_balancer_name must match pattern \w[\w\-]*\w" => lambda { |v| v =~ Regexp.new("/\w[\w\-]*\w/") },
         },
         description: <<~'DESCRIPTION'
           The name of your load balancer.
         DESCRIPTION

property :session_stickiness_enabled, [TrueClass, FalseClass],
         callbacks: {
           "session_stickiness_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Configuration option to enable session stickiness.
         DESCRIPTION

property :session_stickiness_lb_cookie_duration_seconds, String,
         callbacks: {
           "session_stickiness_lb_cookie_duration_seconds is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Configuration option to adjust session stickiness cookie duration parameter.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :tls_policy_name, String,
         callbacks: {
           "tls_policy_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the TLS policy to apply to the load balancer.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lightsail::LoadBalancer"
rest_api_document "/AWS::Lightsail::LoadBalancer"

rest_property_map({
  attached_instances:                            "AttachedInstances",
  health_check_path:                             "HealthCheckPath",
  instance_port:                                 "InstancePort",
  ip_address_type:                               "IpAddressType",
  load_balancer_name:                            "LoadBalancerName",
  session_stickiness_enabled:                    "SessionStickinessEnabled",
  session_stickiness_lb_cookie_duration_seconds: "SessionStickinessLBCookieDurationSeconds",
  tags:                                          "Tags",
  tls_policy_name:                               "TlsPolicyName",
})

rest_post_only_properties %i{
  instance_port ip_address_type load_balancer_name
}
