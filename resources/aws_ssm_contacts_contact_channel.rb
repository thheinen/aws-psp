# Import API specifics
use "awscc_base"

resource_name :aws_ssm_contacts_contact_channel
provides :aws_ssm_contacts_contact_channel, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SSMContacts::ContactChannel
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :channel_address, String,
         callbacks: {
           "channel_address is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The details that SSM Incident Manager uses when trying to engage the contact channel."

property :channel_name, String,
         callbacks: {
           "channel_name is not a String" => lambda { |v| v.is_a? String },
           "channel_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "channel_name must match pattern [a-zA-Z 0-9_\-+'&amp;\u2000-\u3300]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z 0-9_\-+'&amp;\u2000-\u3300]+/") },
         },
         description: "The device name. String of 6 to 50 alphabetical, numeric, dash, and underscore characters."

property :channel_type, String,
         callbacks: {
           "channel_type is not a String" => lambda { |v| v.is_a? String },
           "channel_typeis not one of `SMS`, `VOICE`, `EMAIL`" => lambda { |v| %w{SMS VOICE EMAIL}.include? v },
         },
         description: "Device type, which specify notification channel. Currently supported values: ?SMS?, ?VOICE?, ?EMAIL?, ?CHATBOT."

property :contact_id, String,
         callbacks: {
           "contact_id is not a String" => lambda { |v| v.is_a? String },
           "contact_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "contact_id must match pattern arn:[-\w+=\/,.@]+:[-\w+=\/,.@]+:[-\w+=\/,.@]*:[0-9]+:([\w+=\/,.@:-]+)*" => lambda { |v| v =~ Regexp.new("/arn:[-\w+=\/,.@]+:[-\w+=\/,.@]+:[-\w+=\/,.@]*:[0-9]+:([\w+=\/,.@:-]+)*/") },
         },
         description: "ARN of the contact resource"

property :defer_activation, [TrueClass, FalseClass],
         callbacks: {
           "defer_activation is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "If you want to activate the channel at a later time, you can choose to defer activation. SSM Incident Manager can't engage your contact channel until it has been activated."

# API URLs and mappings
rest_api_collection "/AWS::SSMContacts::ContactChannel"
rest_api_document "/AWS::SSMContacts::ContactChannel"

rest_property_map({
  channel_address:  "ChannelAddress",
  channel_name:     "ChannelName",
  channel_type:     "ChannelType",
  contact_id:       "ContactId",
  defer_activation: "DeferActivation",
})

rest_post_only_properties %i{
  channel_type contact_id
}
