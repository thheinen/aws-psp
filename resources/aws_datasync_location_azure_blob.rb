# Import API specifics
use "awscc_base"

resource_name :aws_datasync_location_azure_blob
provides :aws_datasync_location_azure_blob, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::LocationAzureBlob.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :agent_arns, Array,
         required: true,
         callbacks: {
           "agent_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Names (ARNs) of agents to use for an Azure Blob Location.
         DESCRIPTION

property :azure_access_tier, String,
         callbacks: {
           "azure_access_tier is not a String" => lambda { |v| v.is_a? String },
           "azure_access_tieris not one of `HOT`, `COOL`, `ARCHIVE`" => lambda { |v| %w{HOT COOL ARCHIVE}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies an access tier for the objects you're transferring into your Azure Blob Storage container.
         DESCRIPTION

property :azure_blob_authentication_type, String,
         required: true,
         callbacks: {
           "azure_blob_authentication_type is not a String" => lambda { |v| v.is_a? String },
           "azure_blob_authentication_typeis not one of `SAS`" => lambda { |v| %w{SAS}.include? v },
         },
         description: <<~'DESCRIPTION'
           The specific authentication type that you want DataSync to use to access your Azure Blob Container.
         DESCRIPTION

property :azure_blob_container_url, String,
         callbacks: {
           "azure_blob_container_url is not a String" => lambda { |v| v.is_a? String },
           "azure_blob_container_url must match pattern ^https://[A-Za-z0-9]((.|-+)?[A-Za-z0-9]){0,252}/[a-z0-9](-?[a-z0-9]){2,62}$" => lambda { |v| v =~ Regexp.new("/^https://[A-Za-z0-9]((.|-+)?[A-Za-z0-9]){0,252}/[a-z0-9](-?[a-z0-9]){2,62}$/") },
         },
         description: <<~'DESCRIPTION'
           The URL of the Azure Blob container that was described.
         DESCRIPTION

property :azure_blob_sas_configuration, Hash,
         callbacks: {
           "Subproperty `AzureBlobSasToken` is not a String" => lambda { |v| v[:AzureBlobSasToken].is_a? String },
           "Subproperty `AzureBlobSasToken` needs to be 1..255 characters" => lambda { |v| v[:AzureBlobSasToken].length >= 1 && v[:AzureBlobSasToken].length <= 255 },
           "Subproperty `AzureBlobSasToken` must match pattern (^.+$)" => lambda { |v| v[:AzureBlobSasToken] =~ Regexp.new("/(^.+$)/") },
         },
         description: ""

property :azure_blob_type, String,
         callbacks: {
           "azure_blob_type is not a String" => lambda { |v| v.is_a? String },
           "azure_blob_typeis not one of `BLOCK`" => lambda { |v| %w{BLOCK}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies a blob type for the objects you're transferring into your Azure Blob Storage container.
         DESCRIPTION

property :subdirectory, String,
         callbacks: {
           "subdirectory is not a String" => lambda { |v| v.is_a? String },
           "subdirectory must match pattern ^[\p{L}\p{M}\p{Z}\p{S}\p{N}\p{P}\p{C}]*$" => lambda { |v| v =~ Regexp.new("/^[\p{L}\p{M}\p{Z}\p{S}\p{N}\p{P}\p{C}]*$/") },
         },
         description: <<~'DESCRIPTION'
           The subdirectory in the Azure Blob Container that is used to read data from the Azure Blob Source Location.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DataSync::LocationAzureBlob"
rest_api_document "/AWS::DataSync::LocationAzureBlob"

rest_property_map({
  agent_arns:                     "AgentArns",
  azure_access_tier:              "AzureAccessTier",
  azure_blob_authentication_type: "AzureBlobAuthenticationType",
  azure_blob_container_url:       "AzureBlobContainerUrl",
  azure_blob_sas_configuration:   "AzureBlobSasConfiguration",
  azure_blob_type:                "AzureBlobType",
  subdirectory:                   "Subdirectory",
  tags:                           "Tags",
})

rest_post_only_properties %i{
  azure_blob_container_url
}
