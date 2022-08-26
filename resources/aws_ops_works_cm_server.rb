# Import API specifics
use "awscc_base"

resource_name :aws_ops_works_cm_server
provides :aws_ops_works_cm_server, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::OpsWorksCM::Server
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :associate_public_ip_address, [TrueClass, FalseClass],
         callbacks: {
           "associate_public_ip_address is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :backup_id, String,
         callbacks: {
           "backup_id is not a String" => lambda { |v| v.is_a? String },
           "backup_id must match pattern [a-zA-Z][a-zA-Z0-9\-\.\:]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z][a-zA-Z0-9\-\.\:]*/") },
         },
         description: ""

property :backup_retention_count, Integer,
         callbacks: {
           "backup_retention_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :custom_certificate, String,
         callbacks: {
           "custom_certificate is not a String" => lambda { |v| v.is_a? String },
           "custom_certificate must match pattern (?s)\s*-----BEGIN CERTIFICATE-----.+-----END CERTIFICATE-----\s*" => lambda { |v| v =~ Regexp.new("/(?s)\s*-----BEGIN CERTIFICATE-----.+-----END CERTIFICATE-----\s*/") },
         },
         description: ""

property :custom_domain, String,
         callbacks: {
           "custom_domain is not a String" => lambda { |v| v.is_a? String },
           "custom_domain must match pattern ^(((?!-)[A-Za-z0-9-]{0,62}[A-Za-z0-9])\.)+((?!-)[A-Za-z0-9-]{1,62}[A-Za-z0-9])$" => lambda { |v| v =~ Regexp.new("/^(((?!-)[A-Za-z0-9-]{0,62}[A-Za-z0-9])\.)+((?!-)[A-Za-z0-9-]{1,62}[A-Za-z0-9])$/") },
         },
         description: ""

property :custom_private_key, String,
         callbacks: {
           "custom_private_key is not a String" => lambda { |v| v.is_a? String },
           "custom_private_key must match pattern (?ms)\s*^-----BEGIN (?-s:.*)PRIVATE KEY-----$.*?^-----END (?-s:.*)PRIVATE KEY-----$\s*" => lambda { |v| v =~ Regexp.new("/(?ms)\s*^-----BEGIN (?-s:.*)PRIVATE KEY-----$.*?^-----END (?-s:.*)PRIVATE KEY-----$\s*/") },
         },
         description: ""

property :disable_automated_backup, [TrueClass, FalseClass],
         callbacks: {
           "disable_automated_backup is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :engine, String,
         callbacks: {
           "engine is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :engine_attributes, Array,
         callbacks: {
           "engine_attributes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :engine_model, String,
         callbacks: {
           "engine_model is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :engine_version, String,
         callbacks: {
           "engine_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :instance_profile_arn, String,
         required: true,
         callbacks: {
           "instance_profile_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_profile_arn must match pattern arn:aws:iam::[0-9]{12}:instance-profile/.*" => lambda { |v| v =~ Regexp.new("/arn:aws:iam::[0-9]{12}:instance-profile/.*/") },
         },
         description: ""

property :instance_type, String,
         required: true,
         callbacks: {
           "instance_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :key_pair, String,
         callbacks: {
           "key_pair is not a String" => lambda { |v| v.is_a? String },
           "key_pair must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: ""

property :preferred_backup_window, String,
         callbacks: {
           "preferred_backup_window is not a String" => lambda { |v| v.is_a? String },
           "preferred_backup_window must match pattern ^((Mon|Tue|Wed|Thu|Fri|Sat|Sun):)?([0-1][0-9]|2[0-3]):[0-5][0-9]$" => lambda { |v| v =~ Regexp.new("/^((Mon|Tue|Wed|Thu|Fri|Sat|Sun):)?([0-1][0-9]|2[0-3]):[0-5][0-9]$/") },
         },
         description: ""

property :preferred_maintenance_window, String,
         callbacks: {
           "preferred_maintenance_window is not a String" => lambda { |v| v.is_a? String },
           "preferred_maintenance_window must match pattern ^((Mon|Tue|Wed|Thu|Fri|Sat|Sun):)?([0-1][0-9]|2[0-3]):[0-5][0-9]$" => lambda { |v| v =~ Regexp.new("/^((Mon|Tue|Wed|Thu|Fri|Sat|Sun):)?([0-1][0-9]|2[0-3]):[0-5][0-9]$/") },
         },
         description: ""

property :security_group_ids, Array,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :server_name, String,
         callbacks: {
           "server_name is not a String" => lambda { |v| v.is_a? String },
           "server_name needs to be 1..40 characters" => lambda { |v| v.length >= 1 && v.length <= 40 },
           "server_name must match pattern [a-zA-Z][a-zA-Z0-9\-]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z][a-zA-Z0-9\-]*/") },
         },
         description: ""

property :service_role_arn, String,
         required: true,
         callbacks: {
           "service_role_arn is not a String" => lambda { |v| v.is_a? String },
           "service_role_arn must match pattern arn:aws:iam::[0-9]{12}:role/.*" => lambda { |v| v =~ Regexp.new("/arn:aws:iam::[0-9]{12}:role/.*/") },
         },
         description: ""

property :subnet_ids, Array,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::OpsWorksCM::Server"
rest_api_document "/AWS::OpsWorksCM::Server"

rest_property_map({
  associate_public_ip_address:  "AssociatePublicIpAddress",
  backup_id:                    "BackupId",
  backup_retention_count:       "BackupRetentionCount",
  custom_certificate:           "CustomCertificate",
  custom_domain:                "CustomDomain",
  custom_private_key:           "CustomPrivateKey",
  disable_automated_backup:     "DisableAutomatedBackup",
  engine:                       "Engine",
  engine_attributes:            "EngineAttributes",
  engine_model:                 "EngineModel",
  engine_version:               "EngineVersion",
  instance_profile_arn:         "InstanceProfileArn",
  instance_type:                "InstanceType",
  key_pair:                     "KeyPair",
  preferred_backup_window:      "PreferredBackupWindow",
  preferred_maintenance_window: "PreferredMaintenanceWindow",
  security_group_ids:           "SecurityGroupIds",
  server_name:                  "ServerName",
  service_role_arn:             "ServiceRoleArn",
  subnet_ids:                   "SubnetIds",
  tags:                         "Tags",
})

rest_post_only_properties %i{
  associate_public_ip_address backup_id custom_certificate custom_domain custom_private_key engine engine_model engine_version instance_profile_arn instance_type key_pair security_group_ids server_name service_role_arn subnet_ids
}
