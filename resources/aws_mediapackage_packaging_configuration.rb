# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_mediapackage_packaging_configuration
provides :aws_mediapackage_packaging_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaPackage::PackagingConfiguration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cmaf_package, Hash,
         callbacks: {
           "Subproperty `HlsManifests` is not a Array" => lambda { |v| v[:HlsManifests].is_a? Array },
           "Subproperty `IncludeEncoderConfigurationInSegments` is not a Boolean" => lambda { |v| v[:IncludeEncoderConfigurationInSegments].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A CMAF packaging configuration.
         DESCRIPTION

property :dash_package, Hash,
         callbacks: {
           "Subproperty `DashManifests` is not a Array" => lambda { |v| v[:DashManifests].is_a? Array },
           "Subproperty `PeriodTriggers` is not a Array" => lambda { |v| v[:PeriodTriggers].is_a? Array },
           "Subproperty `SegmentTemplateFormat` is not a String" => lambda { |v| v[:SegmentTemplateFormat].is_a? String },
           "Subproperty `SegmentTemplateFormat`is not one of `NUMBER_WITH_TIMELINE`, `TIME_WITH_TIMELINE`, `NUMBER_WITH_DURATION`" => lambda { |v| %w{NUMBER_WITH_TIMELINE TIME_WITH_TIMELINE NUMBER_WITH_DURATION}.include? v[:SegmentTemplateFormat] },
           "Subproperty `IncludeEncoderConfigurationInSegments` is not a Boolean" => lambda { |v| v[:IncludeEncoderConfigurationInSegments].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A Dynamic Adaptive Streaming over HTTP (DASH) packaging configuration.
         DESCRIPTION

property :hls_package, Hash,
         callbacks: {
           "Subproperty `HlsManifests` is not a Array" => lambda { |v| v[:HlsManifests].is_a? Array },
           "Subproperty `UseAudioRenditionGroup` is not a Boolean" => lambda { |v| v[:UseAudioRenditionGroup].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           An HTTP Live Streaming (HLS) packaging configuration.
         DESCRIPTION

property :id, String,
         required: true,
         callbacks: {
           "id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the PackagingConfiguration.
         DESCRIPTION

property :mss_package, Hash,
         callbacks: {
           "Subproperty `MssManifests` is not a Array" => lambda { |v| v[:MssManifests].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A Microsoft Smooth Streaming (MSS) PackagingConfiguration.
         DESCRIPTION

property :packaging_group_id, String,
         required: true,
         callbacks: {
           "packaging_group_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of a PackagingGroup.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A collection of tags associated with a resource
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaPackage::PackagingConfiguration"
rest_api_document "/AWS::MediaPackage::PackagingConfiguration"

rest_property_map({
  cmaf_package:       "CmafPackage",
  dash_package:       "DashPackage",
  hls_package:        "HlsPackage",
  id:                 "Id",
  mss_package:        "MssPackage",
  packaging_group_id: "PackagingGroupId",
  tags:               "Tags",
})

rest_post_only_properties %i{
  id
}
