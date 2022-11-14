# Import API specifics
use "awscc_base"

resource_name :aws_amplify_domain
provides :aws_amplify_domain, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Amplify::Domain resource allows you to connect a custom domain to your app.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :app_id, String,
         required: true,
         callbacks: {
           "app_id is not a String" => lambda { |v| v.is_a? String },
           "app_id needs to be 1..20 characters" => lambda { |v| v.length >= 1 && v.length <= 20 },
           "app_id must match pattern d[a-z0-9]+" => lambda { |v| v =~ Regexp.new("/d[a-z0-9]+/") },
         },
         description: ""

property :auto_sub_domain_creation_patterns, Array,
         callbacks: {
           "auto_sub_domain_creation_patterns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :auto_sub_domain_iam_role, String,
         callbacks: {
           "auto_sub_domain_iam_role is not a String" => lambda { |v| v.is_a? String },
           "auto_sub_domain_iam_role must match pattern ^$|^arn:.+:iam::\d{12}:role.+" => lambda { |v| v =~ Regexp.new("/^$|^arn:.+:iam::\d{12}:role.+/") },
         },
         description: ""

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
           "domain_name must match pattern ^(((?!-)[A-Za-z0-9-]{0,62}[A-Za-z0-9])\.)+((?!-)[A-Za-z0-9-]{1,62}[A-Za-z0-9])(\.)?$" => lambda { |v| v =~ Regexp.new("/^(((?!-)[A-Za-z0-9-]{0,62}[A-Za-z0-9])\.)+((?!-)[A-Za-z0-9-]{1,62}[A-Za-z0-9])(\.)?$/") },
         },
         description: ""

property :enable_auto_sub_domain, [TrueClass, FalseClass],
         callbacks: {
           "enable_auto_sub_domain is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :sub_domain_settings, Array,
         required: true,
         callbacks: {
           "sub_domain_settings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Amplify::Domain"
rest_api_document "/AWS::Amplify::Domain"

rest_property_map({
  app_id:                            "AppId",
  auto_sub_domain_creation_patterns: "AutoSubDomainCreationPatterns",
  auto_sub_domain_iam_role:          "AutoSubDomainIAMRole",
  domain_name:                       "DomainName",
  enable_auto_sub_domain:            "EnableAutoSubDomain",
  sub_domain_settings:               "SubDomainSettings",
})

rest_post_only_properties %i{
  app_id domain_name
}
