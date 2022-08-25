# Import REST DSL
# use 'core::rest_resource'
use 'rest_resource' # the new and shiney version

# Create responses contain the AWS-side unique identifier in the 'Identifier' field
rest_id_field 'Identifier'

# Add target API specific methods and helpers
action_class do
  RestReponseFake = Struct.new(:data, keyword_init: true)

  # Handle data transformation, paging and asynchronous execution
  def rest_postprocess(response)
    data = response.data
    raise ::Chef::Exceptions::RestError, "Response is not a Hash" unless data.is_a?(Hash)

    # Paging (List)
    if data.key?('NextToken')
      # TODO
    end

    # Wait for asynchronous operations (Update/Delete/Create)
    if data.key?('ProgressEvent')
      token = data.dig('ProgressEvent', 'RequestToken')

      return wait_for_resource(token)
    end

    # List: ResourceDescriptions contains a list, including JSON encoded properties
    if data.key? 'ResourceDescriptions'
      raw_data = data['ResourceDescriptions']
      response.data = raw_data.map { |hsh| JSON.parse hsh['Properties'] }

    # Get: ResourceDescription contains JSON encoded properties
    elsif data.key? 'ResourceDescription'
      raw_data = data['ResourceDescription']
      response.data = JSON.parse raw_data['Properties']
    # Post/Delete: Return raw response
    else
      response.data = data
    end

    response
  end

  # Transform responses into readable error messages
  def rest_errorhandler(error_obj)
    raise error_obj unless error_obj.is_a? RestClient::Exception

    error_message = case error_obj
                    when RestClient::NotFound
                      url = error_obj.response.net_http_res.uri
                      "Path not found: #{url}"
                    else
                      raise error_obj
                end

    raise ::Chef::Exceptions::RestTargetError, "AWS-CC: #{error_message}"
  end

  private

  def wait_for_resource(token, interval: 5, timeout: 1800)
    logger.debug 'AWS-CC: Waiting for completion'

    Timeout.timeout(timeout) do
      loop do
        response = api_connection.post('/',
          headers: {
            "x-amz-target" => "CloudApiService.GetResourceRequestStatus"
          },
          data: {
            RequestToken: token
          }
        )

        event = response.data['ProgressEvent']
        return event if event['OperationStatus'] == 'SUCCESS'

        if event['OperationStatus'] == 'FAILED'
          raise ::Chef::Exceptions::RestOperationFailed, "AWS-CC: Job #{token} failed: #{event['StatusMessage']}"
        end

        sleep interval
      end
    end
  rescue Timeout::Error => _e
    raise ::Chef::Exceptions::RestTimeout, "AWS-CC: Job #{token} timeout exceeded"
  end

  ## Replace methods in base resource due to non-RESTiness of AWS

  def rest_get_all
    logger.debug "Skip getting all resources of type #{rest_api_document}"
    return RestReponseFake.new(data: { no_list_support: true })
  end

  def rest_get
    # Generic
    if rest_id.nil?
      logger.debug "Inexisting resource #{resource_name} of type #{rest_api_document}"
      return
    end

    logger.debug "Get data for #{resource_name} of type #{rest_api_document}"

    response = api_connection.post('/',
      headers: {
        "x-amz-target" => "CloudApiService.GetResource"
      },
      data: {
        TypeName: rest_api_document,
        Identifier: rest_id
      }
    )

    rest_postprocess(response)
  rescue RestClient::Exception => e
    rest_errorhandler(e)
  end

  def rest_post(data)
    logger.debug "Create resource of type #{rest_api_document}"

    response = api_connection.post('/',
      headers: {
        "x-amz-target" => "CloudApiService.CreateResource"
      },
      data: {
        TypeName: rest_api_document,
        DesiredState: data.to_json
      }
    )

    event = rest_postprocess(response)

    if current_resource.class.rest_id_field
      require 'jmespath' unless defined?(JMESPath)

      rest_id = JMESPath.search(current_resource.class.rest_id_field, event)
      save_rest_id(rest_id)
    end
  rescue RestClient::Exception => e
    rest_errorhandler(e)
  end

  def rest_patch(data)
    logger.debug "Update resource #{resource_name} of type #{rest_api_document}"

    # RFC 6902 - JavaScript Object Notation (JSON) Patch
    # https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-update.html#resource-operations-update-how
    patch_document = []
    data.each do |rest_property, new_value|
      chef_property = convert_to_snake_case(rest_property)

      patch_document << {
        "op" => "test",
        "path" => "#{rest_property}",
        "value" => current_resource.send(chef_property.to_sym)
      }
      patch_document << {
        "op" => "replace",
        "path" => "#{rest_property}",
        "value" => new_value
      }
    end

    response = api_connection.post('/',
      headers: {
        "x-amz-target" => "CloudApiService.UpdateResource"
      },
      data: {
        TypeName: rest_api_document,
        Identifier: rest_id,
        PatchDocument: patch_document.to_json
      }
    )

    rest_postprocess(response)
  rescue RestClient::Exception => e
    rest_errorhandler(e)
  end

  alias_method :rest_put, :rest_patch

  def rest_delete
    logger.debug "Delete resource #{resource_name} of type #{rest_api_document}"

    response = api_connection.post('/',
      headers: {
        "x-amz-target" => "CloudApiService.DeleteResource"
      },
      data: {
        TypeName: rest_api_document,
        Identifier: rest_id
      }
    )

    # Generic
    event = rest_postprocess(response)
    remove_rest_id if event['OperationStatus'] == 'SUCCESS'

    {}
  rescue RestClient::Exception => e
    rest_errorhandler(e)
  end

  # Helper to access the DSL-configured type
  def rest_api_document
    current_resource.class.rest_api_document.delete_prefix('/')
  end

  def resource_name
    current_resource.resource_name.to_s
  end

  # TODO: Chef::Mixin::ConvertToClassName.convert_to_snake_case ?
  def convert_to_snake_case(str)
    str = str.dup
    str.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
    str.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    str.downcase!
    str.sub!(/^\_/, "")
    str
  end
  # require 'mixins/convert_to_class_name'
  # include Chef::Mixin::ConvertToClassName
end
