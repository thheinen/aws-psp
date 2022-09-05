# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_rekognition_stream_processor
provides :aws_rekognition_stream_processor, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Rekognition::StreamProcessor type is used to create an Amazon Rekognition StreamProcessor that you can use to analyze streaming videos.


DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bounding_box_regions_of_interest, Array,
         callbacks: {
           "bounding_box_regions_of_interest is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The BoundingBoxRegionsOfInterest specifies an array of bounding boxes of interest in the video frames to analyze, as part of connected home feature. If an object is partially in a region of interest, Rekognition will tag it as detected if the overlap of the object with the region-of-interest is greater than 20%.
         DESCRIPTION

property :connected_home_settings, Hash,
         callbacks: {
           "Subproperty `MinConfidence` is not a Number" => lambda { |v| v[:MinConfidence].is_a? Number },
         },
         description: ""

property :data_sharing_preference, Hash,
         callbacks: {
           "Subproperty `OptIn` is not a Boolean" => lambda { |v| v[:OptIn].is_a? Boolean },
         },
         description: ""

property :face_search_settings, Hash,
         callbacks: {
           "Subproperty `CollectionId` is not a String" => lambda { |v| v[:CollectionId].is_a? String },
           "Subproperty `CollectionId` must match pattern \A[a-zA-Z0-9_\.\-]+$" => lambda { |v| v[:CollectionId] =~ Regexp.new("/\A[a-zA-Z0-9_\.\-]+$/") },
           "Subproperty `FaceMatchThreshold` is not a Number" => lambda { |v| v[:FaceMatchThreshold].is_a? Number },
         },
         description: ""

property :kinesis_data_stream, Hash,
         callbacks: {
           "Subproperty `Arn` is not a String" => lambda { |v| v[:Arn].is_a? String },
           "Subproperty `Arn` must match pattern (^arn:([a-z\d-]+):kinesis:([a-z\d-]+):\d{12}:.+$)" => lambda { |v| v[:Arn] =~ Regexp.new("/(^arn:([a-z\d-]+):kinesis:([a-z\d-]+):\d{12}:.+$)/") },
           "Subproperty `Arn`is not a valid ARN" => lambda { |v| v[:Arn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :kinesis_video_stream, Hash,
         required: true,
         callbacks: {
           "Subproperty `Arn` is not a String" => lambda { |v| v[:Arn].is_a? String },
           "Subproperty `Arn` must match pattern (^arn:([a-z\d-]+):kinesisvideo:([a-z\d-]+):\d{12}:.+$)" => lambda { |v| v[:Arn] =~ Regexp.new("/(^arn:([a-z\d-]+):kinesisvideo:([a-z\d-]+):\d{12}:.+$)/") },
           "Subproperty `Arn`is not a valid ARN" => lambda { |v| v[:Arn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The KMS key that is used by Rekognition to encrypt any intermediate customer metadata and store in the customer's S3 bucket.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "name must match pattern [a-zA-Z0-9_.\-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_.\-]+/") },
         },
         description: <<~'DESCRIPTION'
           Name of the stream processor. It's an identifier you assign to the stream processor. You can use it to manage the stream processor.
         DESCRIPTION

property :notification_channel, Hash,
         callbacks: {
           "Subproperty `Arn` is not a String" => lambda { |v| v[:Arn].is_a? String },
           "Subproperty `Arn`is not a valid ARN" => lambda { |v| v[:Arn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :polygon_regions_of_interest, Array,
         callbacks: {
           "polygon_regions_of_interest is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The PolygonRegionsOfInterest specifies a set of polygon areas of interest in the video frames to analyze, as part of connected home feature. Each polygon is in turn, an ordered list of Point
         DESCRIPTION

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn must match pattern arn:aws(-[\w]+)*:iam::[0-9]{12}:role/.*" => lambda { |v| v =~ Regexp.new("/arn:aws(-[\w]+)*:iam::[0-9]{12}:role/.*/") },
         },
         description: <<~'DESCRIPTION'
           ARN of the IAM role that allows access to the stream processor, and provides Rekognition read permissions for KVS stream and write permissions to S3 bucket and SNS topic.
         DESCRIPTION

property :s3_destination, Hash,
         callbacks: {
           "Subproperty `BucketName` is not a String" => lambda { |v| v[:BucketName].is_a? String },
           "Subproperty `ObjectKeyPrefix` is not a String" => lambda { |v| v[:ObjectKeyPrefix].is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Rekognition::StreamProcessor"
rest_api_document "/AWS::Rekognition::StreamProcessor"

rest_property_map({
  bounding_box_regions_of_interest: "BoundingBoxRegionsOfInterest",
  connected_home_settings:          "ConnectedHomeSettings",
  data_sharing_preference:          "DataSharingPreference",
  face_search_settings:             "FaceSearchSettings",
  kinesis_data_stream:              "KinesisDataStream",
  kinesis_video_stream:             "KinesisVideoStream",
  kms_key_id:                       "KmsKeyId",
  name:                             "Name",
  notification_channel:             "NotificationChannel",
  polygon_regions_of_interest:      "PolygonRegionsOfInterest",
  role_arn:                         "RoleArn",
  s3_destination:                   "S3Destination",
  tags:                             "Tags",
})

rest_post_only_properties %i{
  bounding_box_regions_of_interest connected_home_settings data_sharing_preference face_search_settings kinesis_data_stream kinesis_video_stream kms_key_id name notification_channel polygon_regions_of_interest role_arn s3_destination
}
