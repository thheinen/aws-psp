# Import API specifics
use "awscc_base"

resource_name :aws_devopsguru_log_anomaly_detection_integration
provides :aws_devopsguru_log_anomaly_detection_integration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  This resource schema represents the LogAnomalyDetectionIntegration resource in the Amazon DevOps Guru.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

# API URLs and mappings
rest_api_collection "/AWS::DevOpsGuru::LogAnomalyDetectionIntegration"
rest_api_document "/AWS::DevOpsGuru::LogAnomalyDetectionIntegration"

rest_property_map({

})

