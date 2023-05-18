# Import API specifics
use "awscc_base"

resource_name :aws_shield_protection
provides :aws_shield_protection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Enables AWS Shield Advanced for a specific AWS resource. The resource can be an Amazon CloudFront distribution, Amazon Route 53 hosted zone, AWS Global Accelerator standard accelerator, Elastic IP Address, Application Load Balancer, or a Classic Load Balancer. You can protect Amazon EC2 instances and Network Load Balancers by association with protected Amazon EC2 Elastic IP addresses.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_layer_automatic_response_configuration, Hash,
         callbacks: {
           "Subproperty `Status` is not a String" => lambda { |v| v[:Status].is_a? String },
           "Subproperty `Status`is not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v[:Status] },
         },
         description: ""

property :health_check_arns, Array,
         callbacks: {
           "health_check_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Names (ARNs) of the health check to associate with the protection.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "name must match pattern [ a-zA-Z0-9_\.\-]*" => lambda { |v| v =~ Regexp.new("/[ a-zA-Z0-9_\.\-]*/") },
         },
         description: <<~'DESCRIPTION'
           Friendly name for the Protection.
         DESCRIPTION

property :resource_arn, String,
         required: true,
         callbacks: {
           "resource_arn is not a String" => lambda { |v| v.is_a? String },
           "resource_arn needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           The ARN (Amazon Resource Name) of the resource to be protected.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more tag key-value pairs for the Protection object.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Shield::Protection"
rest_api_document "/AWS::Shield::Protection"

rest_property_map({
  application_layer_automatic_response_configuration: "ApplicationLayerAutomaticResponseConfiguration",
  health_check_arns:                                  "HealthCheckArns",
  name:                                               "Name",
  resource_arn:                                       "ResourceArn",
  tags:                                               "Tags",
})

rest_post_only_properties %i{
  name resource_arn
}
