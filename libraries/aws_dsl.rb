class Chef
  module DSL
    module AWS
      def aws_account_id
        node.dig('aws', 'account_id') || 'unknown'
      end

      def aws_credentials
        node.dig('aws', 'credentials') || 'unknown'
      end

      def aws_region
        node.dig('aws', 'region') || 'unknown'
      end
    end
  end
end

Chef::DSL::Universal.include Chef::DSL::AWS
