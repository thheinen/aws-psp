# Import API specifics
use "awscc_base"

resource_name :aws_mediatailor_channel_policy
provides :aws_mediatailor_channel_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::MediaTailor::ChannelPolicy Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :channel_name, String,
         required: true,
         callbacks: {
           "channel_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :policy, [Hash, String],
         required: true,
         description: <<~'DESCRIPTION'
           <p>The IAM policy for the channel. IAM policies are used to control access to your channel.</p>
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaTailor::ChannelPolicy"
rest_api_document "/AWS::MediaTailor::ChannelPolicy"

rest_property_map({
  channel_name: "ChannelName",
  policy:       "Policy",
})

rest_post_only_properties %i{
  channel_name
}
