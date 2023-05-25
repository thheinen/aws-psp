# Import API specifics
use "awscc_base"

resource_name :aws_cloudtrail_event_data_store
provides :aws_cloudtrail_event_data_store, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A storage lake of event data against which you can run complex SQL-based queries. An event data store can include events that you have logged on your account from the last 90 to 2555 days (about three months to up to seven years).
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :advanced_event_selectors, Array,
         callbacks: {
           "advanced_event_selectors is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The advanced event selectors that were used to select events for the data store.
         DESCRIPTION

property :ingestion_enabled, [TrueClass, FalseClass],
         callbacks: {
           "ingestion_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the event data store is ingesting events.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the KMS key ID to use to encrypt the events delivered by CloudTrail. The value can be an alias name prefixed by 'alias/', a fully specified ARN to an alias, a fully specified ARN to a key, or a globally unique identifier.
         DESCRIPTION

property :multi_region_enabled, [TrueClass, FalseClass],
         callbacks: {
           "multi_region_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the event data store includes events from all regions, or only from the region in which it was created.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the event data store.
         DESCRIPTION

property :organization_enabled, [TrueClass, FalseClass],
         callbacks: {
           "organization_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates that an event data store is collecting logged events for an organization.
         DESCRIPTION

property :retention_period, Integer,
         callbacks: {
           "retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The retention period, in days.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :termination_protection_enabled, [TrueClass, FalseClass],
         callbacks: {
           "termination_protection_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the event data store is protected from termination.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudTrail::EventDataStore"
rest_api_document "/AWS::CloudTrail::EventDataStore"

rest_property_map({
  advanced_event_selectors:       "AdvancedEventSelectors",
  ingestion_enabled:              "IngestionEnabled",
  kms_key_id:                     "KmsKeyId",
  multi_region_enabled:           "MultiRegionEnabled",
  name:                           "Name",
  organization_enabled:           "OrganizationEnabled",
  retention_period:               "RetentionPeriod",
  tags:                           "Tags",
  termination_protection_enabled: "TerminationProtectionEnabled",
})

