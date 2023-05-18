# Import API specifics
use "awscc_base"

resource_name :aws_shield_proactive_engagement
provides :aws_shield_proactive_engagement, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Authorizes the Shield Response Team (SRT) to use email and phone to notify contacts about escalations to the SRT and to initiate proactive customer support.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :emergency_contact_list, Array,
         required: true,
         callbacks: {
           "emergency_contact_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of email addresses and phone numbers that the Shield Response Team (SRT) can use to contact you for escalations to the SRT and to initiate proactive customer support.
      To enable proactive engagement, the contact list must include at least one phone number.
         DESCRIPTION

property :proactive_engagement_status, String,
         required: true,
         callbacks: {
           "proactive_engagement_status is not a String" => lambda { |v| v.is_a? String },
           "proactive_engagement_statusis not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v },
         },
         description: <<~'DESCRIPTION'
           If `ENABLED`, the Shield Response Team (SRT) will use email and phone to notify contacts about escalations to the SRT and to initiate proactive customer support.
      If `DISABLED`, the SRT will not proactively notify contacts about escalations or to initiate proactive customer support.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Shield::ProactiveEngagement"
rest_api_document "/AWS::Shield::ProactiveEngagement"

rest_property_map({
  emergency_contact_list:      "EmergencyContactList",
  proactive_engagement_status: "ProactiveEngagementStatus",
})

