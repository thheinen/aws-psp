# Import API specifics
use "awscc_base"

resource_name :aws_route53_dnssec
provides :aws_route53_dnssec, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource used to control (enable/disable) DNSSEC in a specific hosted zone.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :hosted_zone_id, String,
         required: true,
         callbacks: {
           "hosted_zone_id is not a String" => lambda { |v| v.is_a? String },
           "hosted_zone_id must match pattern ^[A-Z0-9]{1,32}$" => lambda { |v| v =~ Regexp.new("/^[A-Z0-9]{1,32}$/") },
         },
         description: <<~'DESCRIPTION'
           The unique string (ID) used to identify a hosted zone.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Route53::DNSSEC"
rest_api_document "/AWS::Route53::DNSSEC"

rest_property_map({
  hosted_zone_id: "HostedZoneId",
})

rest_post_only_properties %i{
  hosted_zone_id
}
