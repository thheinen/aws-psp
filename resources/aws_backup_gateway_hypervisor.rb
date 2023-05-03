# Import API specifics
use "awscc_base"

resource_name :aws_backup_gateway_hypervisor
provides :aws_backup_gateway_hypervisor, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::BackupGateway::Hypervisor Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :host, String,
         callbacks: {
           "host is not a String" => lambda { |v| v.is_a? String },
           "host needs to be 3..128 characters" => lambda { |v| v.length >= 3 && v.length <= 128 },
           "host must match pattern ^.+$" => lambda { |v| v =~ Regexp.new("/^.+$/") },
         },
         description: ""

property :kms_key_arn, String,
         callbacks: {
           "kms_key_arn is not a String" => lambda { |v| v.is_a? String },
           "kms_key_arn needs to be 50..500 characters" => lambda { |v| v.length >= 50 && v.length <= 500 },
           "kms_key_arn must match pattern ^(^arn:(aws|aws-cn|aws-us-gov):kms:([a-zA-Z0-9-]+):([0-9]+):(key|alias)/(\S+)$)|(^alias/(\S+)$)$" => lambda { |v| v =~ Regexp.new("/^(^arn:(aws|aws-cn|aws-us-gov):kms:([a-zA-Z0-9-]+):([0-9]+):(key|alias)/(\S+)$)|(^alias/(\S+)$)$/") },
         },
         description: ""

property :log_group_arn, String,
         callbacks: {
           "log_group_arn is not a String" => lambda { |v| v.is_a? String },
           "log_group_arn needs to be 0..2048 characters" => lambda { |v| v.length >= 0 && v.length <= 2048 },
           "log_group_arn must match pattern ^$|^arn:(aws|aws-cn|aws-us-gov):logs:([a-zA-Z0-9-]+):([0-9]+):log-group:[a-zA-Z0-9_\-\/\.]+:\*$" => lambda { |v| v =~ Regexp.new("/^$|^arn:(aws|aws-cn|aws-us-gov):logs:([a-zA-Z0-9-]+):([0-9]+):log-group:[a-zA-Z0-9_\-\/\.]+:\*$/") },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "name must match pattern ^[a-zA-Z0-9-]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-]*$/") },
         },
         description: ""

property :password, String,
         callbacks: {
           "password is not a String" => lambda { |v| v.is_a? String },
           "password needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "password must match pattern ^[ -~]+$" => lambda { |v| v =~ Regexp.new("/^[ -~]+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :username, String,
         callbacks: {
           "username is not a String" => lambda { |v| v.is_a? String },
           "username needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "username must match pattern ^[ -\.0-\[\]-~]*[!-\.0-\[\]-~][ -\.0-\[\]-~]*$" => lambda { |v| v =~ Regexp.new("/^[ -\.0-\[\]-~]*[!-\.0-\[\]-~][ -\.0-\[\]-~]*$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::BackupGateway::Hypervisor"
rest_api_document "/AWS::BackupGateway::Hypervisor"

rest_property_map({
  host:          "Host",
  kms_key_arn:   "KmsKeyArn",
  log_group_arn: "LogGroupArn",
  name:          "Name",
  password:      "Password",
  tags:          "Tags",
  username:      "Username",
})

rest_post_only_properties %i{
  kms_key_arn tags
}
