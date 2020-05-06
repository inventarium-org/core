# frozen_string_literal: true

module Services
  module Mappers
    class ReadinessStatus
      def call(service)
        return {} unless service.is_a?(Service)
        return {} unless service.id

        env_data = production_checks(service)

        {
          service_id: service.id,

          owner: !!service.owner_name,
          slack: !!service.owner_slack_channel,

          continuous_integration: !!service.ci_build_url,
          api_documentation: !!service.docs_api,
          maintenance_documentation: !!service.docs_maintenance,

          **env_data
        }
      end

      private

      PRODUCTION_ENV_NAMES = %w[production prod].freeze

      def production_checks(service)
        production_env = find_prod_env(service.environments)

        return {} if production_env.nil?

        {
          healthcheck: !!production_env.healthcheck_url,
          logs: !!production_env.logs_url,
          error_traker: !!production_env.error_traker_url,
          monitoring: !!production_env.monitoring.any?
        }
      end

      def find_prod_env(envs)
        Array(envs).find { |e| PRODUCTION_ENV_NAMES.include?(e.name.to_s) }
      end
    end
  end
end
