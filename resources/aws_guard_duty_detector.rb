# Import API specifics
use "awscc_base"

resource_name :aws_guard_duty_detector
provides :aws_guard_duty_detector, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::GuardDuty::Detector
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :data_sources, Hash,
         description: ""

property :enable, [TrueClass, FalseClass],
         required: true,
         callbacks: {
           "enable is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :features, Array,
         callbacks: {
           "features is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :finding_publishing_frequency, String,
         callbacks: {
           "finding_publishing_frequency is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::GuardDuty::Detector"
rest_api_document "/AWS::GuardDuty::Detector"

rest_property_map({
  data_sources:                 "DataSources",
  enable:                       "Enable",
  features:                     "Features",
  finding_publishing_frequency: "FindingPublishingFrequency",
  tags:                         "Tags",
})

