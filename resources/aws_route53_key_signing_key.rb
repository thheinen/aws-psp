# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_route53_key_signing_key
provides :aws_route53_key_signing_key, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents a key signing key (KSK) associated with a hosted zone. You can only have two KSKs per hosted zone.
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

property :key_management_service_arn, String,
         required: true,
         callbacks: {
           "key_management_service_arn is not a String" => lambda { |v| v.is_a? String },
           "key_management_service_arn needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           The Amazon resource name (ARN) for a customer managed key (CMK) in AWS Key Management Service (KMS). The KeyManagementServiceArn must be unique for each key signing key (KSK) in a single hosted zone.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[a-zA-Z0-9_]{3,128}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_]{3,128}$/") },
         },
         description: <<~'DESCRIPTION'
           An alphanumeric string used to identify a key signing key (KSK). Name must be unique for each key signing key in the same hosted zone.
         DESCRIPTION

property :status, String,
         required: true,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ACTIVE`, `INACTIVE`" => lambda { |v| %w{ACTIVE INACTIVE}.include? v },
         },
         description: <<~'DESCRIPTION'
           A string specifying the initial status of the key signing key (KSK). You can set the value to ACTIVE or INACTIVE.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Route53::KeySigningKey"
rest_api_document "/AWS::Route53::KeySigningKey"

rest_property_map({
  hosted_zone_id:             "HostedZoneId",
  key_management_service_arn: "KeyManagementServiceArn",
  name:                       "Name",
  status:                     "Status",
})

rest_post_only_properties %i{
  hosted_zone_id key_management_service_arn name
}
