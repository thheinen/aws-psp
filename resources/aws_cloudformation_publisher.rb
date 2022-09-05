# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_cloudformation_publisher
provides :aws_cloudformation_publisher, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Register as a publisher in the CloudFormation Registry.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :accept_terms_and_conditions, [TrueClass, FalseClass],
         required: true,
         callbacks: {
           "accept_terms_and_conditions is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether you accept the terms and conditions for publishing extensions in the CloudFormation registry. You must accept the terms and conditions in order to publish public extensions to the CloudFormation registry. The terms and conditions can be found at https://cloudformation-registry-documents.s3.amazonaws.com/Terms_and_Conditions_for_AWS_CloudFormation_Registry_Publishers.pdf
         DESCRIPTION

property :connection_arn, String,
         callbacks: {
           "connection_arn is not a String" => lambda { |v| v.is_a? String },
           "connection_arn must match pattern arn:aws(-[w]+)*:.+:.+:[0-9]{12}:.+" => lambda { |v| v =~ Regexp.new("/arn:aws(-[w]+)*:.+:.+:[0-9]{12}:.+/") },
         },
         description: <<~'DESCRIPTION'
           If you are using a Bitbucket or GitHub account for identity verification, the Amazon Resource Name (ARN) for your connection to that account.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudFormation::Publisher"
rest_api_document "/AWS::CloudFormation::Publisher"

rest_property_map({
  accept_terms_and_conditions: "AcceptTermsAndConditions",
  connection_arn:              "ConnectionArn",
})

rest_post_only_properties %i{
  accept_terms_and_conditions connection_arn
}
