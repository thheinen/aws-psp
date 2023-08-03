# Import API specifics
use "awscc_base"

resource_name :aws_mediatailor_live_source
provides :aws_mediatailor_live_source, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::MediaTailor::LiveSource Resource Type
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
           <p>A list of HTTP package configuration parameters for this live source.</p>
         DESCRIPTION

property :live_source_name, String,
         required: true,
         callbacks: {
           "live_source_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

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
           The tags to assign to the live source.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaTailor::LiveSource"
rest_api_document "/AWS::MediaTailor::LiveSource"

rest_property_map({
  http_package_configurations: "HttpPackageConfigurations",
  live_source_name:            "LiveSourceName",
  source_location_name:        "SourceLocationName",
  tags:                        "Tags",
})

rest_post_only_properties %i{
  live_source_name source_location_name
}
