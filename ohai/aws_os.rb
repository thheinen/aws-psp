Ohai.plugin(:AwsOs) do
  provides "os", "platform", "platform_hierarchy", "aws"
  depends "os"

  def aws?
    %w[amazonaws.com amazonaws.com.cn].any? { |extension| transport_connection.uri.end_with? extension }
  end

  collect_data(:rest) do
    return unless aws?

    # Switch OS to allow platform-specific detectors
    os "aws"
    transport_connection.detected_os = "aws"

    # Custom OS detection/reporting
    platform "aws"
    platform_family "commercial"
    platform_hierarchy %w[aws cloud rest api]

    aws Mash.new
    aws[:region]      = transport_connection.auth_handler.region
    aws[:credentials] = transport_connection.auth_handler.access_key
    # aws[:account_id]  = '123456789012' # TODO: Implement direct STS access without SDKs
  end
end
