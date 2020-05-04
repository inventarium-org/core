# frozen_string_literal: true

module Api
  module Controllers
    module Services
      class Put
        include Api::Action
        include Dry::Monads::Result::Mixin

        include Import[
          # TIPS: for next vesrions use specific operation naming like this:
          #   v1_operation: 'services.v1.operations.put',
          #   v2_operation: 'services.v2.operations.put',

          operation: 'services.operations.put',
          # authenticate_operation: 'organisations.operations.authenticate'
        ]

        ALLOWED_VERSIONS = %w[v0]

        before :validate_version!

        def call(params)
          params[:token]
          params[:service]

          # result = v0_operation.call()
          #
          # case result
          # when Success
          # when Failure
          # end

          self.body = 'OK'
        end

      private

        def validate_version!(params)
          unless ALLOWED_VERSIONS.include?(params.dig(:service, :version).to_s.downcase)
            # TODO: add link to readme about config file
            halt 422, "Invalid service.yaml file. Please use allowed versions: #{ALLOWED_VERSIONS.join(', ')}"
          end
        end
      end
    end
  end
end
