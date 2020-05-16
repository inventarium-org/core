# frozen_string_literal: true

module Services
  module Workers
    class ReadinessCalculator
      include Dry::Monads::Result::Mixin
      include Sidekiq::Worker

      include Import[
        :logger,
        :rollbar,
        operation: 'services.operations.readiness_calculator'
      ]

      def perform(service_id)
        result = operation.call(service_id: service_id)
        case result
        when Success
          logger.info("Readiness information was recalculated (service ##{service_id}")
        when Failure
          rollbar.error("ReadinessCalculator error for service id #{service_id}, #{result.failure}")
        end
      end
    end
  end
end
