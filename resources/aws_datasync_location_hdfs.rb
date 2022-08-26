# Import API specifics
use "awscc_base"

resource_name :aws_datasync_location_hdfs
provides :aws_datasync_location_hdfs, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::LocationHDFS.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :agent_arns, Array,
         required: true,
         callbacks: {
           "agent_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "ARN(s) of the agent(s) to use for an HDFS location."

property :authentication_type, String,
         required: true,
         callbacks: {
           "authentication_type is not a String" => lambda { |v| v.is_a? String },
           "authentication_typeis not one of `SIMPLE`, `KERBEROS`" => lambda { |v| %w{SIMPLE KERBEROS}.include? v },
         },
         description: "The authentication mode used to determine identity of user."

property :block_size, Integer,
         callbacks: {
           "block_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "Size of chunks (blocks) in bytes that the data is divided into when stored in the HDFS cluster."

property :kerberos_keytab, String,
         callbacks: {
           "kerberos_keytab is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The Base64 string representation of the Keytab file."

property :kerberos_krb5_conf, String,
         callbacks: {
           "kerberos_krb5_conf is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The string representation of the Krb5Conf file, or the presigned URL to access the Krb5.conf file within an S3 bucket."

property :kerberos_principal, String,
         callbacks: {
           "kerberos_principal is not a String" => lambda { |v| v.is_a? String },
           "kerberos_principal needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "kerberos_principal must match pattern ^.+$" => lambda { |v| v =~ Regexp.new("/^.+$/") },
         },
         description: "The unique identity, or principal, to which Kerberos can assign tickets."

property :kms_key_provider_uri, String,
         callbacks: {
           "kms_key_provider_uri is not a String" => lambda { |v| v.is_a? String },
           "kms_key_provider_uri needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "kms_key_provider_uri must match pattern ^kms:\/\/http[s]?@(([a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9\-]*[A-Za-z0-9])(;(([a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9\-]*[A-Za-z0-9]))*:[0-9]{1,5}\/kms$" => lambda { |v| v =~ Regexp.new("/^kms:\/\/http[s]?@(([a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9\-]*[A-Za-z0-9])(;(([a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9\-]*[A-Za-z0-9]))*:[0-9]{1,5}\/kms$/") },
         },
         description: "The identifier for the Key Management Server where the encryption keys that encrypt data inside HDFS clusters are stored."

property :name_nodes, Array,
         required: true,
         callbacks: {
           "name_nodes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of Name Node(s) of the HDFS location."

property :qop_configuration, Hash,
         callbacks: {
           "Subproperty `RpcProtection` is not a String" => lambda { |v| v[:RpcProtection].is_a? String },
           "Subproperty `RpcProtection`is not one of `AUTHENTICATION`, `INTEGRITY`, `PRIVACY`, `DISABLED`" => lambda { |v| %w{AUTHENTICATION INTEGRITY PRIVACY DISABLED}.include? v[:RpcProtection] },
           "Subproperty `DataTransferProtection` is not a String" => lambda { |v| v[:DataTransferProtection].is_a? String },
           "Subproperty `DataTransferProtection`is not one of `AUTHENTICATION`, `INTEGRITY`, `PRIVACY`, `DISABLED`" => lambda { |v| %w{AUTHENTICATION INTEGRITY PRIVACY DISABLED}.include? v[:DataTransferProtection] },
         },
         description: ""

property :replication_factor, Integer,
         callbacks: {
           "replication_factor is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "Number of copies of each block that exists inside the HDFS cluster."

property :simple_user, String,
         callbacks: {
           "simple_user is not a String" => lambda { |v| v.is_a? String },
           "simple_user needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "simple_user must match pattern ^[_.A-Za-z0-9][-_.A-Za-z0-9]*$" => lambda { |v| v =~ Regexp.new("/^[_.A-Za-z0-9][-_.A-Za-z0-9]*$/") },
         },
         description: "The user name that has read and write permissions on the specified HDFS cluster."

property :subdirectory, String,
         callbacks: {
           "subdirectory is not a String" => lambda { |v| v.is_a? String },
           "subdirectory must match pattern ^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$/") },
         },
         description: "The subdirectory in HDFS that is used to read data from the HDFS source location or write data to the HDFS destination."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::DataSync::LocationHDFS"
rest_api_document "/AWS::DataSync::LocationHDFS"

rest_property_map({
  agent_arns:           "AgentArns",
  authentication_type:  "AuthenticationType",
  block_size:           "BlockSize",
  kerberos_keytab:      "KerberosKeytab",
  kerberos_krb5_conf:   "KerberosKrb5Conf",
  kerberos_principal:   "KerberosPrincipal",
  kms_key_provider_uri: "KmsKeyProviderUri",
  name_nodes:           "NameNodes",
  qop_configuration:    "QopConfiguration",
  replication_factor:   "ReplicationFactor",
  simple_user:          "SimpleUser",
  subdirectory:         "Subdirectory",
  tags:                 "Tags",
})

