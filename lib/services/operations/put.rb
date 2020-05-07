# frozen_string_literal: true

module Services
  module Operations
    class Put < ::Libs::Operation
      include Import[
        mapper: 'services.mappers.service_information',
        repo: 'repositories.service',
        audit_repo: 'repositories.organisation_audit_item'
      ]

      def call(organisation:, params:)
        # TODO: implement validation logic here too
        payload = mapper.call(params)
        payload[:organisation_id] = organisation.id

        service = yield persist(organisation, payload)
        spawn_event(service)
        audit_repo.create(organisation_id: organisation.id, service_key: payload[:key], payload: params)

        Success(service)
      end

      private

      def persist(organisation, payload)
        Success(repo.create_or_upate(organisation.id, payload))
      rescue Hanami::Model::UniqueConstraintViolationError, Hanami::Model::NotNullConstraintViolationError
        Failure(:invalid_data)
      end

      def spawn_event(service)
        Services::Workers::ReadinessCalculator.perform_async(service.id)
      end
    end
  end
end
