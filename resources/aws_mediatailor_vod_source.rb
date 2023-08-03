# Import API specifics
use "awscc_base"

resource_name :aws_mediatailor_vod_source
provides :aws_mediatailor_vod_source, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::MediaTailor::VodSource Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :http_package_configurations, Array,
         required: true,
         callbacks: {
           "http_package_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>A list of HTTP package configuration parameters for this VOD source.</p>
         DESCRIPTION

property :source_location_name, String,
         required: true,
         callbacks: {
           "source_location_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags to assign to the VOD source.
         DESCRIPTION

property :vod_source_name, String,
         required: true,
         callbacks: {
           "vod_source_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::MediaTailor::VodSource"
rest_api_document "/AWS::MediaTailor::VodSource"

rest_property_map({
  http_package_configurations: "HttpPackageConfigurations",
  source_location_name:        "SourceLocationName",
  tags:                        "Tags",
  vod_source_name:             "VodSourceName",
})

rest_post_only_properties %i{
  source_location_name vod_source_name
}
