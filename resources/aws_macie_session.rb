# Import API specifics
use "awscc_base"

resource_name :aws_macie_session
provides :aws_macie_session, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Macie::Session resource specifies a new Amazon Macie session. A session is an object that represents the Amazon Macie service. A session is required for Amazon Macie to become operational.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :finding_publishing_frequency, String,
         callbacks: {
           "finding_publishing_frequency is not a String" => lambda { |v| v.is_a? String },
           "finding_publishing_frequencyis not one of `FIFTEEN_MINUTES`, `ONE_HOUR`, `SIX_HOURS`" => lambda { |v| %w{FIFTEEN_MINUTES ONE_HOUR SIX_HOURS}.include? v },
         },
         description: "A enumeration value that specifies how frequently finding updates are published."

property :status, String,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ENABLED`, `PAUSED`" => lambda { |v| %w{ENABLED PAUSED}.include? v },
         },
         description: "A enumeration value that specifies the status of the Macie Session."

# API URLs and mappings
rest_api_collection "/AWS::Macie::Session"
rest_api_document "/AWS::Macie::Session"

rest_property_map({
  finding_publishing_frequency: "FindingPublishingFrequency",
  status:                       "Status",
})

