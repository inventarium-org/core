# frozen_string_literal: true

module Services
  module Operations
    class ReadinessCalculator < ::Libs::Operation
      include Import[
        mapper: 'services.mappers.readiness_status',
        readiness_repo: 'repositories.readiness',
        service_repo: 'repositories.service'
      ]

      def call(service_id:)
        service = yield find_service(service_id)

        payload = mapper.call(service)
        Success(readiness_repo.create_or_update(service_id, payload))
      end

      private

      def find_service(id)
        service = service_repo.find_with_environments(id)
        service ? Success(service) : Failure(:service_not_found)
      end

      def rediness_payload(service)
        {
          service_id: service.id,

          owner: !!service.owner_name,
          slack: !!service.owner_slack_channel,

          continuous_integration: !!service.ci_build_url,
          api_documentation: !!service.docs_api,
          maintenance_documentation: !!service.docs_maintenance,

          **production_checks(service)
        }
      end

      def production_checks(service)
        production_env = service.environments.find { |e| PRODUCTION_ENV_NAMES.include?(e.name.to_s) }

        return {} if production_env.nil?

        {
          healthcheck: !!production_env.healthcheck_url,
          logs: !!production_env.logs_url,
          error_traker: !!production_env.error_traker_url,
          monitoring: !!production_env.monitoring.any?
        }
      end
    end
  end
end
