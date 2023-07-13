# Import API specifics
use "awscc_base"

resource_name :aws_connect_routing_profile
provides :aws_connect_routing_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::RoutingProfile
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :default_outbound_queue_arn, String,
         required: true,
         callbacks: {
           "default_outbound_queue_arn is not a String" => lambda { |v| v.is_a? String },
           "default_outbound_queue_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/queue/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/queue/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The identifier of the default outbound queue for this routing profile.
         DESCRIPTION

property :description, String,
         required: true,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..250 characters" => lambda { |v| v.length >= 1 && v.length <= 250 },
         },
         description: <<~'DESCRIPTION'
           The description of the routing profile.
         DESCRIPTION

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The identifier of the Amazon Connect instance.
         DESCRIPTION

property :media_concurrencies, Array,
         required: true,
         callbacks: {
           "media_concurrencies is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The channels agents can handle in the Contact Control Panel (CCP) for this routing profile.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
         },
         description: <<~'DESCRIPTION'
           The name of the routing profile.
         DESCRIPTION

property :queue_configs, Array,
         callbacks: {
           "queue_configs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The queues to associate with this routing profile.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Connect::RoutingProfile"
rest_api_document "/AWS::Connect::RoutingProfile"

rest_property_map({
  default_outbound_queue_arn: "DefaultOutboundQueueArn",
  description:                "Description",
  instance_arn:               "InstanceArn",
  media_concurrencies:        "MediaConcurrencies",
  name:                       "Name",
  queue_configs:              "QueueConfigs",
  tags:                       "Tags",
})

