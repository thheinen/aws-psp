# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_devopsguru_notification_channel
provides :aws_devopsguru_notification_channel, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  This resource schema represents the NotificationChannel resource in the Amazon DevOps Guru.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :config, Hash,
         required: true,
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::DevOpsGuru::NotificationChannel"
rest_api_document "/AWS::DevOpsGuru::NotificationChannel"

rest_property_map({
  config: "Config",
})

rest_post_only_properties %i{
  config
}
