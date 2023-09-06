# Import API specifics
use "awscc_base"

resource_name :aws_connect_campaigns_campaign
provides :aws_connect_campaigns_campaign, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::ConnectCampaigns::Campaign Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :connect_instance_arn, String,
         required: true,
         callbacks: {
           "connect_instance_arn is not a String" => lambda { |v| v.is_a? String },
           "connect_instance_arn needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
           "connect_instance_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           Amazon Connect Instance Arn
         DESCRIPTION

property :dialer_config, Hash,
         required: true,
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
         },
         description: <<~'DESCRIPTION'
           Amazon Connect Campaign Name
         DESCRIPTION

property :outbound_call_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `ConnectContactFlowArn` is not a String" => lambda { |v| v[:ConnectContactFlowArn].is_a? String },
           "Subproperty `ConnectContactFlowArn` must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/contact-flow/[-a-zA-Z0-9]*$" => lambda { |v| v[:ConnectContactFlowArn] =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/contact-flow/[-a-zA-Z0-9]*$/") },
           "Subproperty `ConnectContactFlowArn`is not a valid ARN" => lambda { |v| v[:ConnectContactFlowArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `ConnectSourcePhoneNumber` is not a String" => lambda { |v| v[:ConnectSourcePhoneNumber].is_a? String },
           "Subproperty `ConnectQueueArn` is not a String" => lambda { |v| v[:ConnectQueueArn].is_a? String },
           "Subproperty `ConnectQueueArn` must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/queue/[-a-zA-Z0-9]*$" => lambda { |v| v[:ConnectQueueArn] =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/queue/[-a-zA-Z0-9]*$/") },
           "Subproperty `ConnectQueueArn`is not a valid ARN" => lambda { |v| v[:ConnectQueueArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more tags.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ConnectCampaigns::Campaign"
rest_api_document "/AWS::ConnectCampaigns::Campaign"

rest_property_map({
  connect_instance_arn: "ConnectInstanceArn",
  dialer_config:        "DialerConfig",
  name:                 "Name",
  outbound_call_config: "OutboundCallConfig",
  tags:                 "Tags",
})

rest_post_only_properties %i{
  connect_instance_arn
}
