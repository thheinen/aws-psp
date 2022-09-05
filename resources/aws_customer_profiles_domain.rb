# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_customer_profiles_domain
provides :aws_customer_profiles_domain, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A domain defined for 3rd party data source in Profile Service
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :dead_letter_queue_url, String,
         callbacks: {
           "dead_letter_queue_url is not a String" => lambda { |v| v.is_a? String },
           "dead_letter_queue_url needs to be 0..255 characters" => lambda { |v| v.length >= 0 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The URL of the SQS dead letter queue
         DESCRIPTION

property :default_encryption_key, String,
         callbacks: {
           "default_encryption_key is not a String" => lambda { |v| v.is_a? String },
           "default_encryption_key needs to be 0..255 characters" => lambda { |v| v.length >= 0 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The default encryption key
         DESCRIPTION

property :default_expiration_days, Integer,
         callbacks: {
           "default_expiration_days is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The default number of days until the data within the domain expires.
         DESCRIPTION

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
           "domain_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "domain_name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The unique name of the domain.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags (keys and values) associated with the domain
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CustomerProfiles::Domain"
rest_api_document "/AWS::CustomerProfiles::Domain"

rest_property_map({
  dead_letter_queue_url:   "DeadLetterQueueUrl",
  default_encryption_key:  "DefaultEncryptionKey",
  default_expiration_days: "DefaultExpirationDays",
  domain_name:             "DomainName",
  tags:                    "Tags",
})

rest_post_only_properties %i{
  domain_name
}
