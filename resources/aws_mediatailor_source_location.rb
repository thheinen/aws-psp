# Import API specifics
use "awscc_base"

resource_name :aws_mediatailor_source_location
provides :aws_mediatailor_source_location, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::MediaTailor::SourceLocation Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_configuration, Hash,
         description: ""

property :default_segment_delivery_configuration, Hash,
         callbacks: {
           "Subproperty `BaseUrl` is not a String" => lambda { |v| v[:BaseUrl].is_a? String },
         },
         description: ""

property :http_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `BaseUrl` is not a String" => lambda { |v| v[:BaseUrl].is_a? String },
         },
         description: ""

property :segment_delivery_configurations, Array,
         callbacks: {
           "segment_delivery_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>A list of the segment delivery configurations associated with this resource.</p>
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
           The tags to assign to the source location.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaTailor::SourceLocation"
rest_api_document "/AWS::MediaTailor::SourceLocation"

rest_property_map({
  access_configuration:                   "AccessConfiguration",
  default_segment_delivery_configuration: "DefaultSegmentDeliveryConfiguration",
  http_configuration:                     "HttpConfiguration",
  segment_delivery_configurations:        "SegmentDeliveryConfigurations",
  source_location_name:                   "SourceLocationName",
  tags:                                   "Tags",
})

rest_post_only_properties %i{
  source_location_name
}
