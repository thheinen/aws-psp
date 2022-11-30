# Import API specifics
use "awscc_base"

resource_name :aws_gamelift_location
provides :aws_gamelift_location, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::GameLift::Location resource creates an Amazon GameLift (GameLift) custom location.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :location_name, String,
         required: true,
         callbacks: {
           "location_name is not a String" => lambda { |v| v.is_a? String },
           "location_name needs to be 8..64 characters" => lambda { |v| v.length >= 8 && v.length <= 64 },
           "location_name must match pattern ^custom-[A-Za-z0-9\-]+" => lambda { |v| v =~ Regexp.new("/^custom-[A-Za-z0-9\-]+/") },
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
rest_api_collection "/AWS::GameLift::Location"
rest_api_document "/AWS::GameLift::Location"

rest_property_map({
  location_name: "LocationName",
  tags:          "Tags",
})

rest_post_only_properties %i{
  location_name
}
