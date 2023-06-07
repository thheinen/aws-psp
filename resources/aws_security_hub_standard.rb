# Import API specifics
use "awscc_base"

resource_name :aws_security_hub_standard
provides :aws_security_hub_standard, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::SecurityHub::Standard resource represents the implementation of an individual AWS Security Hub Standard in your account. It requires you have SecurityHub enabled before you can enable the Standard.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :disabled_standards_controls, Array,
         callbacks: {
           "disabled_standards_controls is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           StandardsControls to disable from this Standard.
         DESCRIPTION

property :standards_arn, String,
         required: true,
         callbacks: {
           "standards_arn is not a String" => lambda { |v| v.is_a? String },
           "standards_arn must match pattern arn:aws\S*:securityhub:\S" => lambda { |v| v =~ Regexp.new("/arn:aws\S*:securityhub:\S/") },
         },
         description: <<~'DESCRIPTION'
           The ARN of the Standard being enabled
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SecurityHub::Standard"
rest_api_document "/AWS::SecurityHub::Standard"

rest_property_map({
  disabled_standards_controls: "DisabledStandardsControls",
  standards_arn:               "StandardsArn",
})

rest_post_only_properties %i{
  standards_arn
}
