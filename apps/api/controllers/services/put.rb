# frozen_string_literal: true

module Api
  module Controllers
    module Services
      class Put
        include Api::Action
        include Dry::Monads::Result::Mixin
        include Dry::Monads::Do.for(:handle)

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
          result = handle(env_token, params[:service])

          case result
          when Success
            self.body = 'OK'
          when Failure(:failure_authenticate)
            halt 401, 'Authenticate failure, please check your INVENTARIUM_TOKEN EVN value'
          when Failure(:demo_plan_max_service)
            halt 403, "Organisation has max value of services on 'demo' plan"
          when Failure
            halt 422, result.failure.to_json
          end
        end

        private

        def handle(token, service_params)
          organisation = yield authenticate_operation.call(token: token)
          yield check_plan_abilities(service_params[:key], organisation)

          operation.call(organisation: organisation, params: service_params)
        end

        # TODO: move to kan
        def check_plan_abilities(service_key, organisation)
          case organisation.plan
          when 'demo'
            existed_services = organisation.services.map(&:name)

            if existed_services.push(service_key).uniq.count > 30
              Failure(:demo_plan_max_service)
            else
              Success(organisation)
            end
          else
            Success(organisation)
          end
        end

        def env_token
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
