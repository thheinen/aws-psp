# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_lookout_metrics_alert
provides :aws_lookout_metrics_alert, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::LookoutMetrics::Alert
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :action, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           The action to be taken by the alert when an anomaly is detected.
         DESCRIPTION

property :alert_description, String,
         callbacks: {
           "alert_description is not a String" => lambda { |v| v.is_a? String },
           "alert_description must match pattern .*\S.*" => lambda { |v| v =~ Regexp.new("/.*\S.*/") },
         },
         description: <<~'DESCRIPTION'
           A description for the alert.
         DESCRIPTION

property :alert_name, String,
         callbacks: {
           "alert_name is not a String" => lambda { |v| v.is_a? String },
           "alert_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "alert_name must match pattern ^[a-zA-Z0-9][a-zA-Z0-9\-_]*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9\-_]*/") },
         },
         description: <<~'DESCRIPTION'
           The name of the alert. If not provided, a name is generated automatically.
         DESCRIPTION

property :alert_sensitivity_threshold, Integer,
         required: true,
         callbacks: {
           "alert_sensitivity_threshold is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           A number between 0 and 100 (inclusive) that tunes the sensitivity of the alert.
         DESCRIPTION

property :anomaly_detector_arn, String,
         required: true,
         callbacks: {
           "anomaly_detector_arn is not a String" => lambda { |v| v.is_a? String },
           "anomaly_detector_arn must match pattern arn:([a-z\d-]+):.*:.*:.*:.+" => lambda { |v| v =~ Regexp.new("/arn:([a-z\d-]+):.*:.*:.*:.+/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon resource name (ARN) of the Anomaly Detector to alert.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::LookoutMetrics::Alert"
rest_api_document "/AWS::LookoutMetrics::Alert"

rest_property_map({
  action:                      "Action",
  alert_description:           "AlertDescription",
  alert_name:                  "AlertName",
  alert_sensitivity_threshold: "AlertSensitivityThreshold",
  anomaly_detector_arn:        "AnomalyDetectorArn",
})

rest_post_only_properties %i{
  action alert_description alert_name alert_sensitivity_threshold anomaly_detector_arn
}
