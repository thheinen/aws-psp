# Import API specifics
use "awscc_base"

resource_name :aws_ssm_contacts_plan
provides :aws_ssm_contacts_plan, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Engagement Plan for a SSM Incident Manager Contact.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :contact_id, String,
         callbacks: {
           "contact_id is not a String" => lambda { |v| v.is_a? String },
           "contact_id must match pattern arn:[-\w+=\/,.@]+:[-\w+=\/,.@]+:[-\w+=\/,.@]*:[0-9]+:([\w+=\/,.@:-]+)*" => lambda { |v| v =~ Regexp.new("/arn:[-\w+=\/,.@]+:[-\w+=\/,.@]+:[-\w+=\/,.@]*:[0-9]+:([\w+=\/,.@:-]+)*/") },
         },
         description: <<~'DESCRIPTION'
           Contact ID for the AWS SSM Incident Manager Contact to associate the plan.
         DESCRIPTION

property :rotation_ids, Array,
         callbacks: {
           "rotation_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Rotation Ids to associate with Oncall Contact for engagement.
         DESCRIPTION

property :stages, Array,
         callbacks: {
           "stages is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The stages that an escalation plan or engagement plan engages contacts and contact methods in.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SSMContacts::Plan"
rest_api_document "/AWS::SSMContacts::Plan"

rest_property_map({
  contact_id:   "ContactId",
  rotation_ids: "RotationIds",
  stages:       "Stages",
})

rest_post_only_properties %i{
  contact_id
}
