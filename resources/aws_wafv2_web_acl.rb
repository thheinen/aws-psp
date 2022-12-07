# Import API specifics
use "awscc_base"

resource_name :aws_wafv2_web_acl
provides :aws_wafv2_web_acl, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Contains the Rules that identify the requests that you want to allow, block, or count. In a WebACL, you also specify a default action (ALLOW or BLOCK), and the action for each Rule that you add to a WebACL, for example, block requests from specified IP addresses or block requests from specified referrers. You also associate the WebACL with a CloudFront distribution to identify the requests that you want AWS WAF to filter. If you add more than one Rule to a WebACL, a request needs to match only one of the specifications to be allowed, blocked, or counted.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :captcha_config, Hash,
         description: ""

property :custom_response_bodies, Hash,
         callbacks: {
           "custom_response_bodies is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :default_action, Hash,
         required: true,
         description: ""

property :description, Hash,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern ^[a-zA-Z0-9=:#@/\-,.][a-zA-Z0-9+=:#@/\-,.\s]+[a-zA-Z0-9+=:#@/\-,.]{1,256}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9=:#@/\-,.][a-zA-Z0-9+=:#@/\-,.\s]+[a-zA-Z0-9+=:#@/\-,.]{1,256}$/") },
         },
         description: ""

property :name, Hash,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[0-9A-Za-z_-]{1,128}$" => lambda { |v| v =~ Regexp.new("/^[0-9A-Za-z_-]{1,128}$/") },
         },
         description: ""

property :rules, Array,
         callbacks: {
           "rules is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Collection of Rules.
         DESCRIPTION

property :scope, Hash,
         required: true,
         callbacks: {
           "scope is not a String" => lambda { |v| v.is_a? String },
           "scopeis not one of `CLOUDFRONT`, `REGIONAL`" => lambda { |v| %w{CLOUDFRONT REGIONAL}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :visibility_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `SampledRequestsEnabled` is not a Boolean" => lambda { |v| v[:SampledRequestsEnabled].is_a? Boolean },
           "Subproperty `CloudWatchMetricsEnabled` is not a Boolean" => lambda { |v| v[:CloudWatchMetricsEnabled].is_a? Boolean },
           "Subproperty `MetricName` is not a String" => lambda { |v| v[:MetricName].is_a? String },
           "Subproperty `MetricName` needs to be 1..128 characters" => lambda { |v| v[:MetricName].length >= 1 && v[:MetricName].length <= 128 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WAFv2::WebACL"
rest_api_document "/AWS::WAFv2::WebACL"

rest_property_map({
  captcha_config:         "CaptchaConfig",
  custom_response_bodies: "CustomResponseBodies",
  default_action:         "DefaultAction",
  description:            "Description",
  name:                   "Name",
  rules:                  "Rules",
  scope:                  "Scope",
  tags:                   "Tags",
  visibility_config:      "VisibilityConfig",
})

rest_post_only_properties %i{
  name scope
}
