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
          authenticate_operation: 'organisations.operations.authenticate'
        ]

        ALLOWED_VERSIONS = %w[v0].freeze

        before :validate_version!

        def call(params)
          result = authenticate_operation.call(token: token).bind do |organisation|
            operation.call(organisation: organisation, params: params[:service])
          end

          case result
          when Success
            self.body = 'OK'
          when Failure(:invalid_data)
            halt 422, 'Invalid data in service.yaml file'
          when Failure(:failure_authenticate)
            halt 422, 'Authenticate failure'
          end
        end

        private

        def token
          request.env['HTTP_X_INVENTARIUM_TOKEN']
        end

        # rubocop:disable Layout/LineLength
        def validate_version!(params)
          version = params.dig(:service, :version).to_s.downcase
          return if ALLOWED_VERSIONS.include?(version)

          # TODO: add link to readme about config file
          halt 422, "Invalid service.yaml file. Please use allowed versions: #{ALLOWED_VERSIONS.join(', ')} (Req version: #{version.inspect})"
        end
        # rubocop:enable Layout/LineLength
      end
    end
  end
end
