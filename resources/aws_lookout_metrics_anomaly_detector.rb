# Import API specifics
use "awscc_base"

resource_name :aws_lookout_metrics_anomaly_detector
provides :aws_lookout_metrics_anomaly_detector, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An Amazon Lookout for Metrics Detector
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :anomaly_detector_config, Hash,
         required: true,
         description: "Configuration options for the AnomalyDetector"

property :anomaly_detector_description, String,
         callbacks: {
           "anomaly_detector_description is not a String" => lambda { |v| v.is_a? String },
           "anomaly_detector_description must match pattern .*\S.*" => lambda { |v| v =~ Regexp.new("/.*\S.*/") },
         },
         description: "A description for the AnomalyDetector."

property :anomaly_detector_name, String,
         callbacks: {
           "anomaly_detector_name is not a String" => lambda { |v| v.is_a? String },
           "anomaly_detector_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "anomaly_detector_name must match pattern ^[a-zA-Z0-9][a-zA-Z0-9\-_]*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9\-_]*/") },
         },
         description: "Name for the Amazon Lookout for Metrics Anomaly Detector"

property :kms_key_arn, String,
         callbacks: {
           "kms_key_arn is not a String" => lambda { |v| v.is_a? String },
           "kms_key_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "kms_key_arn must match pattern arn:aws.*:kms:.*:[0-9]{12}:key/.*" => lambda { |v| v =~ Regexp.new("/arn:aws.*:kms:.*:[0-9]{12}:key/.*/") },
         },
         description: "KMS key used to encrypt the AnomalyDetector data"

property :metric_set_list, Array,
         required: true,
         callbacks: {
           "metric_set_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "List of metric sets for anomaly detection"

# API URLs and mappings
rest_api_collection "/AWS::LookoutMetrics::AnomalyDetector"
rest_api_document "/AWS::LookoutMetrics::AnomalyDetector"

rest_property_map({
  anomaly_detector_config:      "AnomalyDetectorConfig",
  anomaly_detector_description: "AnomalyDetectorDescription",
  anomaly_detector_name:        "AnomalyDetectorName",
  kms_key_arn:                  "KmsKeyArn",
  metric_set_list:              "MetricSetList",
})

rest_post_only_properties %i{
  anomaly_detector_name metric_source
}
