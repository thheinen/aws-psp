# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_s3_storage_lens
provides :aws_s3_storage_lens, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::S3::StorageLens resource is an Amazon S3 resource type that you can use to create Storage Lens configurations.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :storage_lens_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `IsEnabled` is not a Boolean" => lambda { |v| v[:IsEnabled].is_a? Boolean },
           "Subproperty `StorageLensArn` is not a String" => lambda { |v| v[:StorageLensArn].is_a? String },
           "Subproperty `StorageLensArn`is not a valid ARN" => lambda { |v| v[:StorageLensArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A set of tags (key-value pairs) for this Amazon S3 Storage Lens configuration.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::S3::StorageLens"
rest_api_document "/AWS::S3::StorageLens"

rest_property_map({
  storage_lens_configuration: "StorageLensConfiguration",
  tags:                       "Tags",
})

rest_post_only_properties %i{
  storage_lens_configuration/id
}
