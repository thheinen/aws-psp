# Import API specifics
use "awscc_base"

resource_name :aws_s3_bucket
provides :aws_s3_bucket, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::S3::Bucket
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :accelerate_configuration, Hash,
         callbacks: {
           "Subproperty `AccelerationStatus` is not a String" => lambda { |v| v[:AccelerationStatus].is_a? String },
           "Subproperty `AccelerationStatus`is not one of `Enabled`, `Suspended`" => lambda { |v| %w{Enabled Suspended}.include? v[:AccelerationStatus] },
         },
         description: "Configuration for the transfer acceleration state."

property :access_control, String,
         callbacks: {
           "access_control is not a String" => lambda { |v| v.is_a? String },
           "access_controlis not one of `AuthenticatedRead`, `AwsExecRead`, `BucketOwnerFullControl`, `BucketOwnerRead`, `LogDeliveryWrite`, `Private`, `PublicRead`, `PublicReadWrite`" => lambda { |v| %w{AuthenticatedRead AwsExecRead BucketOwnerFullControl BucketOwnerRead LogDeliveryWrite Private PublicRead PublicReadWrite}.include? v },
         },
         description: "A canned access control list (ACL) that grants predefined permissions to the bucket."

property :analytics_configurations, Array,
         callbacks: {
           "analytics_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The configuration and any analyses for the analytics filter of an Amazon S3 bucket."

property :bucket_encryption, Hash,
         callbacks: {
           "Subproperty `ServerSideEncryptionConfiguration` is not a Array" => lambda { |v| v[:ServerSideEncryptionConfiguration].is_a? Array },
         },
         description: ""

property :bucket_name, String,
         callbacks: {
           "bucket_name is not a String" => lambda { |v| v.is_a? String },
           "bucket_name needs to be 3..63 characters" => lambda { |v| v.length >= 3 && v.length <= 63 },
           "bucket_name must match pattern ^[a-z0-9][a-z0-9//.//-]*[a-z0-9]$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9][a-z0-9//.//-]*[a-z0-9]$/") },
         },
         description: "A name for the bucket. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the bucket name."

property :cors_configuration, Hash,
         callbacks: {
           "Subproperty `CorsRules` is not a Array" => lambda { |v| v[:CorsRules].is_a? Array },
         },
         description: "Rules that define cross-origin resource sharing of objects in this bucket."

property :intelligent_tiering_configurations, Array,
         callbacks: {
           "intelligent_tiering_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Specifies the S3 Intelligent-Tiering configuration for an Amazon S3 bucket."

property :inventory_configurations, Array,
         callbacks: {
           "inventory_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The inventory configuration for an Amazon S3 bucket."

property :lifecycle_configuration, Hash,
         callbacks: {
           "Subproperty `Rules` is not a Array" => lambda { |v| v[:Rules].is_a? Array },
         },
         description: "Rules that define how Amazon S3 manages objects during their lifetime."

property :logging_configuration, Hash,
         callbacks: {
           "Subproperty `DestinationBucketName` is not a String" => lambda { |v| v[:DestinationBucketName].is_a? String },
           "Subproperty `LogFilePrefix` is not a String" => lambda { |v| v[:LogFilePrefix].is_a? String },
         },
         description: "Settings that define where logs are stored."

property :metrics_configurations, Array,
         callbacks: {
           "metrics_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Settings that define a metrics configuration for the CloudWatch request metrics from the bucket."

property :notification_configuration, Hash,
         callbacks: {
           "Subproperty `LambdaConfigurations` is not a Array" => lambda { |v| v[:LambdaConfigurations].is_a? Array },
           "Subproperty `QueueConfigurations` is not a Array" => lambda { |v| v[:QueueConfigurations].is_a? Array },
           "Subproperty `TopicConfigurations` is not a Array" => lambda { |v| v[:TopicConfigurations].is_a? Array },
         },
         description: "Configuration that defines how Amazon S3 handles bucket notifications."

property :object_lock_configuration, Hash,
         callbacks: {
           "Subproperty `ObjectLockEnabled` is not a String" => lambda { |v| v[:ObjectLockEnabled].is_a? String },
         },
         description: "Places an Object Lock configuration on the specified bucket."

property :object_lock_enabled, [TrueClass, FalseClass],
         callbacks: {
           "object_lock_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "Indicates whether this bucket has an Object Lock configuration enabled."

property :ownership_controls, Hash,
         callbacks: {
           "Subproperty `Rules` is not a Array" => lambda { |v| v[:Rules].is_a? Array },
         },
         description: "Specifies the container element for object ownership rules."

property :public_access_block_configuration, Hash,
         callbacks: {
           "Subproperty `BlockPublicAcls` is not a Boolean" => lambda { |v| v[:BlockPublicAcls].is_a? Boolean },
           "Subproperty `BlockPublicPolicy` is not a Boolean" => lambda { |v| v[:BlockPublicPolicy].is_a? Boolean },
           "Subproperty `IgnorePublicAcls` is not a Boolean" => lambda { |v| v[:IgnorePublicAcls].is_a? Boolean },
           "Subproperty `RestrictPublicBuckets` is not a Boolean" => lambda { |v| v[:RestrictPublicBuckets].is_a? Boolean },
         },
         description: ""

property :replication_configuration, Hash,
         callbacks: {
           "Subproperty `Role` is not a String" => lambda { |v| v[:Role].is_a? String },
           "Subproperty `Rules` is not a Array" => lambda { |v| v[:Rules].is_a? Array },
         },
         description: "Configuration for replicating objects in an S3 bucket."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An arbitrary set of tags (key-value pairs) for this S3 bucket."

property :versioning_configuration, Hash,
         callbacks: {
           "Subproperty `Status` is not a String" => lambda { |v| v[:Status].is_a? String },
           "Subproperty `Status`is not one of `Enabled`, `Suspended`" => lambda { |v| %w{Enabled Suspended}.include? v[:Status] },
         },
         description: ""

property :website_configuration, Hash,
         callbacks: {
           "Subproperty `ErrorDocument` is not a String" => lambda { |v| v[:ErrorDocument].is_a? String },
           "Subproperty `IndexDocument` is not a String" => lambda { |v| v[:IndexDocument].is_a? String },
           "Subproperty `RoutingRules` is not a Array" => lambda { |v| v[:RoutingRules].is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::S3::Bucket"
rest_api_document "/AWS::S3::Bucket"

rest_property_map({
  accelerate_configuration:           "AccelerateConfiguration",
  access_control:                     "AccessControl",
  analytics_configurations:           "AnalyticsConfigurations",
  bucket_encryption:                  "BucketEncryption",
  bucket_name:                        "BucketName",
  cors_configuration:                 "CorsConfiguration",
  intelligent_tiering_configurations: "IntelligentTieringConfigurations",
  inventory_configurations:           "InventoryConfigurations",
  lifecycle_configuration:            "LifecycleConfiguration",
  logging_configuration:              "LoggingConfiguration",
  metrics_configurations:             "MetricsConfigurations",
  notification_configuration:         "NotificationConfiguration",
  object_lock_configuration:          "ObjectLockConfiguration",
  object_lock_enabled:                "ObjectLockEnabled",
  ownership_controls:                 "OwnershipControls",
  public_access_block_configuration:  "PublicAccessBlockConfiguration",
  replication_configuration:          "ReplicationConfiguration",
  tags:                               "Tags",
  versioning_configuration:           "VersioningConfiguration",
  website_configuration:              "WebsiteConfiguration",
})

rest_post_only_properties %i{
  bucket_name object_lock_enabled
}
