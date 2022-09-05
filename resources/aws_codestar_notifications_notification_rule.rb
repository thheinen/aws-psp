# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_codestar_notifications_notification_rule
provides :aws_codestar_notifications_notification_rule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CodeStarNotifications::NotificationRule
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :created_by, String,
         callbacks: {
           "created_by is not a String" => lambda { |v| v.is_a? String },
           "created_by needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :detail_type, String,
         required: true,
         callbacks: {
           "detail_type is not a String" => lambda { |v| v.is_a? String },
           "detail_typeis not one of `BASIC`, `FULL`" => lambda { |v| %w{BASIC FULL}.include? v },
         },
         description: ""

property :event_type_id, String,
         callbacks: {
           "event_type_id is not a String" => lambda { |v| v.is_a? String },
           "event_type_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :event_type_ids, Array,
         required: true,
         callbacks: {
           "event_type_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern [A-Za-z0-9\-_ ]+$" => lambda { |v| v =~ Regexp.new("/[A-Za-z0-9\-_ ]+$/") },
         },
         description: ""

property :resource, String,
         required: true,
         callbacks: {
           "resource is not a String" => lambda { |v| v.is_a? String },
           "resource must match pattern ^arn:aws[^:\s]*:[^:\s]*:[^:\s]*:[0-9]{12}:[^\s]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[^:\s]*:[^:\s]*:[^:\s]*:[0-9]{12}:[^\s]+$/") },
         },
         description: ""

property :status, String,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :target_address, String,
         callbacks: {
           "target_address is not a String" => lambda { |v| v.is_a? String },
           "target_address needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :targets, Array,
         required: true,
         callbacks: {
           "targets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CodeStarNotifications::NotificationRule"
rest_api_document "/AWS::CodeStarNotifications::NotificationRule"

rest_property_map({
  created_by:     "CreatedBy",
  detail_type:    "DetailType",
  event_type_id:  "EventTypeId",
  event_type_ids: "EventTypeIds",
  name:           "Name",
  resource:       "Resource",
  status:         "Status",
  tags:           "Tags",
  target_address: "TargetAddress",
  targets:        "Targets",
})

rest_post_only_properties %i{
  resource tags
}
