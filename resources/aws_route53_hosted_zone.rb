# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_route53_hosted_zone
provides :aws_route53_hosted_zone, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Route53::HostedZone.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :hosted_zone_config, Hash,
         callbacks: {
           "Subproperty `Comment` is not a String" => lambda { |v| v[:Comment].is_a? String },
         },
         description: ""

property :hosted_zone_tags, Array,
         callbacks: {
           "hosted_zone_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Adds, edits, or deletes tags for a health check or a hosted zone.
            For information about using tags for cost allocation, see Using Cost Allocation Tags in the AWS Billing and Cost Management User Guide.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the domain. Specify a fully qualified domain name, for example, www.example.com. The trailing dot is optional; Amazon Route 53 assumes that the domain name is fully qualified. This means that Route 53 treats www.example.com (without a trailing dot) and www.example.com. (with a trailing dot) as identical.
            If you're creating a public hosted zone, this is the name you have registered with your DNS registrar. If your domain name is registered with a registrar other than Route 53, change the name servers for your domain to the set of NameServers that are returned by the Fn::GetAtt intrinsic function.
         DESCRIPTION

property :query_logging_config, Hash,
         callbacks: {
           "Subproperty `CloudWatchLogsLogGroupArn` is not a String" => lambda { |v| v[:CloudWatchLogsLogGroupArn].is_a? String },
           "Subproperty `CloudWatchLogsLogGroupArn`is not a valid ARN" => lambda { |v| v[:CloudWatchLogsLogGroupArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :vp_cs, Array,
         callbacks: {
           "vp_cs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A complex type that contains information about the VPCs that are associated with the specified hosted zone.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Route53::HostedZone"
rest_api_document "/AWS::Route53::HostedZone"

rest_property_map({
  hosted_zone_config:   "HostedZoneConfig",
  hosted_zone_tags:     "HostedZoneTags",
  name:                 "Name",
  query_logging_config: "QueryLoggingConfig",
  vp_cs:                "VPCs",
})

rest_post_only_properties %i{
  name
}
