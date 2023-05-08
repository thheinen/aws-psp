# Import API specifics
use "awscc_base"

resource_name :aws_ec2_verified_access_group
provides :aws_ec2_verified_access_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::EC2::VerifiedAccessGroup resource creates an AWS EC2 Verified Access Group.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description for the AWS Verified Access group.
         DESCRIPTION

property :policy_document, String,
         callbacks: {
           "policy_document is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The AWS Verified Access policy document.
         DESCRIPTION

property :policy_enabled, [TrueClass, FalseClass],
         callbacks: {
           "policy_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           The status of the Verified Access policy.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :verified_access_instance_id, String,
         required: true,
         callbacks: {
           "verified_access_instance_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the AWS Verified Access instance.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::VerifiedAccessGroup"
rest_api_document "/AWS::EC2::VerifiedAccessGroup"

rest_property_map({
  description:                 "Description",
  policy_document:             "PolicyDocument",
  policy_enabled:              "PolicyEnabled",
  tags:                        "Tags",
  verified_access_instance_id: "VerifiedAccessInstanceId",
})

