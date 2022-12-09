# Import API specifics
use "awscc_base"

resource_name :aws_mediaconnect_flow_entitlement
provides :aws_mediaconnect_flow_entitlement, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaConnect::FlowEntitlement
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :data_transfer_subscriber_fee_percent, Integer,
         callbacks: {
           "data_transfer_subscriber_fee_percent is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Percentage from 0-100 of the data transfer cost to be billed to the subscriber.
         DESCRIPTION

property :description, String,
         required: true,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description of the entitlement.
         DESCRIPTION

property :encryption, Hash,
         callbacks: {
           "Subproperty `Algorithm` is not a String" => lambda { |v| v[:Algorithm].is_a? String },
           "Subproperty `Algorithm`is not one of `aes128`, `aes192`, `aes256`" => lambda { |v| %w{aes128 aes192 aes256}.include? v[:Algorithm] },
           "Subproperty `ConstantInitializationVector` is not a String" => lambda { |v| v[:ConstantInitializationVector].is_a? String },
           "Subproperty `DeviceId` is not a String" => lambda { |v| v[:DeviceId].is_a? String },
           "Subproperty `KeyType` is not a String" => lambda { |v| v[:KeyType].is_a? String },
           "Subproperty `KeyType`is not one of `speke`, `static-key`" => lambda { |v| %w{speke static-key}.include? v[:KeyType] },
           "Subproperty `Region` is not a String" => lambda { |v| v[:Region].is_a? String },
           "Subproperty `ResourceId` is not a String" => lambda { |v| v[:ResourceId].is_a? String },
           "Subproperty `RoleArn` is not a String" => lambda { |v| v[:RoleArn].is_a? String },
           "Subproperty `RoleArn`is not a valid ARN" => lambda { |v| v[:RoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `SecretArn` is not a String" => lambda { |v| v[:SecretArn].is_a? String },
           "Subproperty `SecretArn`is not a valid ARN" => lambda { |v| v[:SecretArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `Url` is not a String" => lambda { |v| v[:Url].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of encryption that will be used on the output that is associated with this entitlement.
         DESCRIPTION

property :entitlement_status, String,
         callbacks: {
           "entitlement_status is not a String" => lambda { |v| v.is_a? String },
           "entitlement_statusis not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v },
         },
         description: <<~'DESCRIPTION'
           An indication of whether the entitlement is enabled.
         DESCRIPTION

property :flow_arn, String,
         required: true,
         callbacks: {
           "flow_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of the flow.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the entitlement.
         DESCRIPTION

property :subscribers, Array,
         required: true,
         callbacks: {
           "subscribers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The AWS account IDs that you want to share your content with. The receiving accounts (subscribers) will be allowed to create their own flow using your content as the source.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaConnect::FlowEntitlement"
rest_api_document "/AWS::MediaConnect::FlowEntitlement"

rest_property_map({
  data_transfer_subscriber_fee_percent: "DataTransferSubscriberFeePercent",
  description:                          "Description",
  encryption:                           "Encryption",
  entitlement_status:                   "EntitlementStatus",
  flow_arn:                             "FlowArn",
  name:                                 "Name",
  subscribers:                          "Subscribers",
})

rest_post_only_properties %i{
  data_transfer_subscriber_fee_percent name
}
