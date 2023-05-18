# Import API specifics
use "awscc_base"

resource_name :aws_shield_drt_access
provides :aws_shield_drt_access, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Config the role and list of Amazon S3 log buckets used by the Shield Response Team (SRT) to access your AWS account while assisting with attack mitigation.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :log_bucket_list, Array,
         callbacks: {
           "log_bucket_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Authorizes the Shield Response Team (SRT) to access the specified Amazon S3 bucket containing log data such as Application Load Balancer access logs, CloudFront logs, or logs from third party sources. You can associate up to 10 Amazon S3 buckets with your subscription.
         DESCRIPTION

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Authorizes the Shield Response Team (SRT) using the specified role, to access your AWS account to assist with DDoS attack mitigation during potential attacks. This enables the SRT to inspect your AWS WAF configuration and create or update AWS WAF rules and web ACLs.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Shield::DRTAccess"
rest_api_document "/AWS::Shield::DRTAccess"

rest_property_map({
  log_bucket_list: "LogBucketList",
  role_arn:        "RoleArn",
})

