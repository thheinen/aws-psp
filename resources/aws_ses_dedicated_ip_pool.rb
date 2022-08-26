# Import API specifics
use "awscc_base"

resource_name :aws_ses_dedicated_ip_pool
provides :aws_ses_dedicated_ip_pool, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SES::DedicatedIpPool
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :pool_name, String,
         callbacks: {
           "pool_name is not a String" => lambda { |v| v.is_a? String },
           "pool_name must match pattern ^[a-z0-9_-]{0,64}$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9_-]{0,64}$/") },
         },
         description: "The name of the dedicated IP pool."

# API URLs and mappings
rest_api_collection "/AWS::SES::DedicatedIpPool"
rest_api_document "/AWS::SES::DedicatedIpPool"

rest_property_map({
  pool_name: "PoolName",
})

rest_post_only_properties %i{
  pool_name
}
