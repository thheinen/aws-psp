# Import API specifics
use "awscc_base"

resource_name :aws_detective_member_invitation
provides :aws_detective_member_invitation, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Detective::MemberInvitation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :disable_email_notification, [TrueClass, FalseClass],
         callbacks: {
           "disable_email_notification is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           When set to true, invitation emails are not sent to the member accounts. Member accounts must still accept the invitation before they are added to the behavior graph. Updating this field has no effect.
         DESCRIPTION

property :graph_arn, String,
         required: true,
         callbacks: {
           "graph_arn is not a String" => lambda { |v| v.is_a? String },
           "graph_arn must match pattern arn:aws(-[\w]+)*:detective:(([a-z]+-)+[0-9]+):[0-9]{12}:graph:[0-9a-f]{32}" => lambda { |v| v =~ Regexp.new("/arn:aws(-[\w]+)*:detective:(([a-z]+-)+[0-9]+):[0-9]{12}:graph:[0-9a-f]{32}/") },
         },
         description: <<~'DESCRIPTION'
           The ARN of the graph to which the member account will be invited
         DESCRIPTION

property :member_email_address, String,
         required: true,
         callbacks: {
           "member_email_address is not a String" => lambda { |v| v.is_a? String },
           "member_email_address must match pattern .*@.*" => lambda { |v| v =~ Regexp.new("/.*@.*/") },
         },
         description: <<~'DESCRIPTION'
           The root email address for the account to be invited, for validation. Updating this field has no effect.
         DESCRIPTION

property :member_id, String,
         required: true,
         callbacks: {
           "member_id is not a String" => lambda { |v| v.is_a? String },
           "member_id must match pattern [0-9]{12}" => lambda { |v| v =~ Regexp.new("/[0-9]{12}/") },
         },
         description: <<~'DESCRIPTION'
           The AWS account ID to be invited to join the graph as a member
         DESCRIPTION

property :message, String,
         callbacks: {
           "message is not a String" => lambda { |v| v.is_a? String },
           "message needs to be 1..1000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000 },
         },
         description: <<~'DESCRIPTION'
           A message to be included in the email invitation sent to the invited account. Updating this field has no effect.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Detective::MemberInvitation"
rest_api_document "/AWS::Detective::MemberInvitation"

rest_property_map({
  disable_email_notification: "DisableEmailNotification",
  graph_arn:                  "GraphArn",
  member_email_address:       "MemberEmailAddress",
  member_id:                  "MemberId",
  message:                    "Message",
})

rest_post_only_properties %i{
  graph_arn member_id
}
