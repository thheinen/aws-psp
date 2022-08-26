# Import API specifics
use "awscc_base"

resource_name :aws_sso_instance_access_control_attribute_configuration
provides :aws_sso_instance_access_control_attribute_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for SSO InstanceAccessControlAttributeConfiguration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_control_attributes, Hash,
         callbacks: {
           "access_control_attributes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :instance_access_control_attribute_configuration, Hash,
         description: "The InstanceAccessControlAttributeConfiguration property has been deprecated but is still supported for backwards compatibility purposes. We recomend that you use  AccessControlAttributes property instead."

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn needs to be 10..1224 characters" => lambda { |v| v.length >= 10 && v.length <= 1224 },
           "instance_arn must match pattern arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b):sso:::instance/(sso)?ins-[a-zA-Z0-9-.]{16}" => lambda { |v| v =~ Regexp.new("/arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b):sso:::instance/(sso)?ins-[a-zA-Z0-9-.]{16}/") },
         },
         description: "The ARN of the AWS SSO instance under which the operation will be executed."

# API URLs and mappings
rest_api_collection "/AWS::SSO::InstanceAccessControlAttributeConfiguration"
rest_api_document "/AWS::SSO::InstanceAccessControlAttributeConfiguration"

rest_property_map({
  access_control_attributes:                       "AccessControlAttributes",
  instance_access_control_attribute_configuration: "InstanceAccessControlAttributeConfiguration",
  instance_arn:                                    "InstanceArn",
})

rest_post_only_properties %i{
  instance_arn
}
